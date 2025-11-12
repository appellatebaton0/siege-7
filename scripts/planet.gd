class_name Planet extends CharacterBody2D

@export var data:PlanetData

@export var max_speed := 1000.0
@export var acceleration := 30.0

@onready var player:Player = get_tree().get_first_node_in_group("Player")

var in_tractor_beam := false
var tractor_lerp = 0.0

@onready var lock_point:Vector2 = get_lock_point()
func get_lock_point() -> Vector2:
	return $LockPoint.global_position

func _ready() -> void:
	$Sprite2D.texture = data.texture

func _physics_process(delta: float) -> void:
	global_position.x = lerp(lock_point.x, player.collector.global_position.x, tractor_lerp)
	global_position.y = lerp(lock_point.y, player.collector.global_position.y, tractor_lerp)
	
	tractor_lerp = move_toward(tractor_lerp, int(in_tractor_beam), delta / 2)
	scale = Vector2.ONE * (1- tractor_lerp)
	
	move_and_slide()
	
	in_tractor_beam = false
	
