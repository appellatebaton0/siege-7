class_name PlanetEntry extends PanelContainer

@export var data:PlanetData

@onready var icon := $MarginContainer/HBoxContainer/PlanetInfo/Icon
@onready var label := $MarginContainer/HBoxContainer/PlanetInfo/Name

@onready var sell := $MarginContainer/HBoxContainer/Options/Sell
@onready var sell_text = $MarginContainer/HBoxContainer/Options/Sell.text

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


func _on_sell_pressed() -> void:
	Global.change_contents("money", data.worth)
	$AnimationPlayer.play("free")

func _on_animation_finished(_val) -> void:
	queue_free()
