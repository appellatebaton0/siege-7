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


func make_random():
	
	var elements := ["hydrogen", "helium", "oxygen", "carbon", "neon"]
	
	for element in elements:
		set(element, 0)
	
	for i in range(15):
		var target = elements.pick_random()
		set(target, get(target) + 1)
	
	worth = randi_range(15, 54)
	
	
	pass
