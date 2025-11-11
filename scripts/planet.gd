class_name Planet extends CharacterBody2D

@export var max_speed := 1000.0
@export var acceleration := 30.0

var in_tractor_beam := false

@onready var lock_point:Vector2 = get_lock_point()
func get_lock_point() -> Vector2:
	return $LockPoint.global_position

func move_to_lock_point(delta:float) -> void:
	velocity = (lock_point - global_position) * delta * 30

func _physics_process(delta: float) -> void:
	if not in_tractor_beam:
		move_to_lock_point(delta)
		
	move_and_slide()
	
