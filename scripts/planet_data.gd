class_name PlanetData extends Resource

@export var name := "Planet"

@export var texture:Texture2D

@export var worth := 0

@export_group("Elements")
@export var hydrogen := 0
@export var helium := 0
@export var oxygen := 0
@export var carbon := 0
@export var neon := 0

var _TEXTURE_OPTIONS = [
	load("res://assets/textures/planet1.png"),
	load("res://assets/textures/planet2.png"),
	load("res://assets/textures/planet3.png"),
	load("res://assets/textures/planet4.png"),
	load("res://assets/textures/planet5.png")
]
func make_random() -> PlanetData:
	
	var new:PlanetData = duplicate(true)
	
	var elements := ["hydrogen", "helium", "oxygen", "carbon", "neon"]
	
	for element in elements:
		new.set(element, 0)
	
	for i in range(15):
		var target = elements.pick_random()
		new.set(target, new.get(target) + 1)
	
	new.texture = _TEXTURE_OPTIONS.pick_random()
	
	new.worth = randi_range(15, 54)
	
	return new
