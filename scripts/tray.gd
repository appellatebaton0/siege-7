class_name Tray extends Control

@onready var goal_values:Dictionary[String,Dictionary] = {
	"money": {"goal":0, "value": 0, "node": $Panel/MarginContainer/HBoxContainer/Planets/ElementContainer/PanelContainer2/Money},
	"hydrogen": {"goal":0, "value": 0, "node": $Panel/MarginContainer/HBoxContainer/Planets/ElementContainer/PanelContainer7/Hydrogen},
	"helium": {"goal":0, "value": 0, "node": $Panel/MarginContainer/HBoxContainer/Planets/ElementContainer/PanelContainer3/Helium},
	"oxygen": {"goal":0, "value": 0, "node": $Panel/MarginContainer/HBoxContainer/Planets/ElementContainer/PanelContainer4/Oxygen},
	"carbon": {"goal":0, "value": 0, "node": $Panel/MarginContainer/HBoxContainer/Planets/ElementContainer/PanelContainer5/Carbon},
	"neon": {"goal":0, "value": 0, "node": $Panel/MarginContainer/HBoxContainer/Planets/ElementContainer/PanelContainer6/Neon},
}

@onready var entry_slot:Node = $Panel/MarginContainer/HBoxContainer/Planets/ScrollContainer/PlanetContainer/EntrySlot
var entry_scene:PackedScene = load("res://scenes/planet_entry.tscn")
func add_planet_entry(data:PlanetData):
	var new:PlanetEntry = entry_scene.instantiate()
	
	new.data = data
	
	entry_slot.add_sibling(new)
	

func _ready() -> void:
	Global.updated_contents.connect(_on_updated_contents)
	_on_updated_contents()

func lerp_content_values() -> void:
	for value in goal_values.keys():
		var dict = goal_values[value]
		
		dict["value"] = int(move_toward(dict["value"], dict["goal"], 1))
		
		dict["node"].text = str(dict["value"]) + " "+ value
		

func _process(_delta: float) -> void:
	lerp_content_values()
	pass

func _on_updated_contents() -> void:
	for value in goal_values.keys():
		goal_values[value]["goal"] = Global.get(value)
