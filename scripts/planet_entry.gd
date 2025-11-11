class_name PlanetEntry extends PanelContainer

@export var data:PlanetData

@onready var icon := $MarginContainer/HBoxContainer/PlanetInfo/Icon
@onready var label := $MarginContainer/HBoxContainer/PlanetInfo/Name

@onready var sell := $MarginContainer/HBoxContainer/Options/Button2
@onready var sell_text = $MarginContainer/HBoxContainer/Options/Button2.text

@onready var elements:Dictionary[String, Label]= {
	"hydrogen": $MarginContainer/HBoxContainer/VBoxContainer/Hydrogen,
	"helium": $MarginContainer/HBoxContainer/VBoxContainer/Helium,
	"oxygen": $MarginContainer/HBoxContainer/VBoxContainer/Oxygen,
	"carbon": $MarginContainer/HBoxContainer/VBoxContainer/Carbon,
	"neon": $MarginContainer/HBoxContainer/VBoxContainer/Neon
}

func update_data():
	icon.texture = data.texture
	
	for element in elements.keys():
		elements[element].text = str(data.get(element)) + " " + element.capitalize()
	
	sell.text = sell_text.replace("0", str(data.worth))

func _ready() -> void:
	update_data()
