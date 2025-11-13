class_name PlanetEntry extends PanelContainer

@export var data:PlanetData

@onready var icon := $MarginContainer/HBoxContainer/Icon
@onready var label := $MarginContainer/HBoxContainer/VBoxContainer/Name

@onready var sell := $MarginContainer/HBoxContainer/Options/Sell
@onready var sell_text = $MarginContainer/HBoxContainer/Options/Sell.text

@onready var elements:Dictionary[String, Label]= {
	"hydrogen": $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Hydrogen,
	"helium": $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Helium,
	"oxygen": $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Oxygen,
	"carbon": $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Carbon,
	"neon": $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Neon
}

func update_data():
	icon.texture = data.texture
	
	for element in elements.keys():
		elements[element].text = str(data.get(element)) + " " + element.capitalize()
	
	sell.text = sell_text.replace("0", str(data.worth))
	label.text = data.name

func _ready() -> void:
	update_data()


func _on_sell_pressed() -> void:
	Global.change_contents("money", data.worth)
	$AnimationPlayer.play("free")
func _on_break_down_pressed() -> void:
	
	for element in elements.keys():
		Global.change_contents(element, data.get(element))
	
	$AnimationPlayer.play("free")



func _on_animation_finished(_val) -> void:
	queue_free()
