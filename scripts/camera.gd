class_name Camera extends Camera2D

@export var player:Player

@export var follow_speed := 300.0
@export var lerp_amount = 0.1
@export var velocity_divider = 4

func get_goal_position() -> Vector2:
	return player.global_position + (player.velocity / velocity_divider)

func _process(_delta: float) -> void:
	global_position = lerp(global_position, get_goal_position(), lerp_amount)
