class_name Planet extends CharacterBody2D

@export var max_speed := 1000.0
@export var acceleration := 30.0

var in_tractor_beam := false

func dot_product(a:Vector2, b:Vector2) -> float:
	return (a.x * b.x) + (a.y * b.y)

@onready var lock_point:Vector2 = get_lock_point()
func get_lock_point() -> Vector2:
	return $LockPoint.global_position

func move_to_lock_point(delta:float) -> void:
	var direction = global_position.direction_to(lock_point)
	var magnitude = global_position.distance_to(lock_point)
	
	acceleration = abs(50 - global_position.distance_to(lock_point))
	
	var scaler = 3.0 if dot_product(direction, velocity) < 0 else 1.0
	
	velocity += direction * magnitude * (20 * delta) * scaler
	
	velocity = (lock_point - global_position) * delta * 30

func _process(delta: float) -> void:
	if not in_tractor_beam:
		move_to_lock_point(delta)
		
	move_and_slide()
	
