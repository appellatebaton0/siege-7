class_name PlanetSpawner extends Node2D

@export var min_range = Vector2(-5500, -5500)
@export var max_range = Vector2(5500, 5500)

@export var interval = 1.0
var timer = 0.0

@onready var player:Player = get_tree().get_first_node_in_group("Player")

var planet_scene:PackedScene = load("res://scenes/planet.tscn")

func good_dist() -> bool:
	if player.global_position.distance_to(global_position) < 1000:
		return false
	
	for planet in get_tree().get_nodes_in_group("Planet"):
		if planet.global_position.distance_to(global_position) < 1000:
			return false
	return true

func _process(delta: float) -> void:
	if len(get_tree().get_nodes_in_group("Planet")) < 20:
		timer = move_toward(timer, 0 , delta)
		
		#if l != null:
			#print(l.global_position)
		
		print(timer)
		if timer == 0:
			
			print(max_range, min_range)
			var spawn_x = randf_range(min_range.x, max_range.x)
			var spawn_y = randf_range(min_range.y, max_range.y)
			global_position = player.global_position + Vector2(spawn_x,spawn_y)
			
			if good_dist():
				var new:Planet = planet_scene.instantiate()
				
				add_sibling(new)
				
				print(new.sprite.texture)
				
				new.global_position = global_position
				new.lock_point = global_position
				
				timer = interval
				
				
				#print(global_position, " -> ", Vector2(x,y))
				
			
