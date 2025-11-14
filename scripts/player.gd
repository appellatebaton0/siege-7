class_name Player extends CharacterBody2D

@export var max_speed := 1000.0
@export var acceleration := 10.0
@export var brake := 10.0
var speed := 0.0
@export var friction := 5.0
@export var beam_speed := 0.35
var tractor_lerp = 0.0

@export var max_rotation_speed := 2.0
@export var rotation_acceleration := 0.5
var rotation_speed = 0.0
@export var rotation_friction := 0.025

@onready var ray:RayCast2D = $RayCast2D
@onready var collector:Area2D = $Area2D
@onready var tray:Tray = get_tree().get_first_node_in_group("Tray")

func control(delta: float) -> void:
	
	# Forwards movement.
	var direction = Input.get_axis("Brake", "Boost")
	
	if direction != 0:
		direction = max(0, direction)
		speed = move_toward(speed, direction * max_speed, delta * (acceleration if direction != 0 else brake) * 60)
	else:
		speed = move_toward(speed, 0, delta * friction * 60)
	
	velocity = Vector2(speed, 0).rotated(rotation)
	
	# Rotational movement.
	var rotation_direction = Input.get_axis("Left", "Right")
	
	if rotation_direction:
		rotation_speed = move_toward(rotation_speed, rotation_direction * max_rotation_speed, delta * rotation_acceleration * 60)
	else:
		rotation_speed = move_toward(rotation_speed, 0, delta * rotation_friction * 60)
	
	rotate(deg_to_rad(rotation_speed))


func _physics_process(delta: float) -> void:
	control(delta)
	
	var hit_planet:Planet = ray.get_collider()
	$Beam.visible = Input.is_action_pressed("TractorBeam")
	if Input.is_action_pressed("TractorBeam") and hit_planet != null:
		hit_planet.in_tractor_beam = true
		hit_planet.player = self
		
		tractor_lerp = move_toward(tractor_lerp, 1.0, delta * beam_speed)
		
		if collector.get_overlapping_bodies().has(hit_planet) and hit_planet.scale < Vector2(0.05, 0.05):
			tray.add_planet_entry(hit_planet.data)
			hit_planet.queue_free()
			
	else:
		tractor_lerp = 0
	
	
	move_and_slide()
