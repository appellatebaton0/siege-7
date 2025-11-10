class_name Player extends CharacterBody2D

@export var max_speed := 1000.0
@export var acceleration := 10.0
var speed := 0.0
@export var friction := 5.0

@export var max_rotation_speed := 2.0
@export var rotation_acceleration := 0.5
var rotation_speed = 0.0

func control(delta: float) -> void:
	var direction = Input.get_axis("Brake", "Boost")
	
	if direction != 0:
		print("0")
		direction = max(0, direction)
		speed = move_toward(speed, direction * max_speed, delta * acceleration * 60)
	else:
		speed = move_toward(speed, 0, delta * friction * 60)
	
	velocity = Vector2(speed, 0).rotated(rotation)
	
	var rotation_direction = Input.get_axis("Left", "Right")
	
	rotation_speed = move_toward(rotation_speed, rotation_direction * max_rotation_speed, delta * rotation_acceleration * 60)
	
	rotate(deg_to_rad(rotation_speed))
	
	
	pass
	
func _physics_process(delta: float) -> void:
	control(delta)
	
	move_and_slide()
