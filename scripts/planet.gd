class_name Planet extends StaticBody2D

@export var data:PlanetData

@export var max_speed := 1000.0
@export var acceleration := 30.0

@onready var player:Player = get_tree().get_first_node_in_group("Player")

var in_tractor_beam := false
var tractor_lerp = 0.0

@onready var sprite = $Sprite2D

@onready var lock_point:Vector2 = get_lock_point()
func get_lock_point() -> Vector2:
	return $LockPoint.global_position

func _ready() -> void:
	data = data.make_random()
	sprite.texture = data.texture

func _physics_process(delta: float) -> void:
	if in_tractor_beam:
		tractor_lerp = player.tractor_lerp
	else:
		tractor_lerp = move_toward(tractor_lerp, 0, delta * 2)
	
	global_position.x = lerp(lock_point.x, player.collector.global_position.x, tractor_lerp)
	global_position.y = lerp(lock_point.y, player.collector.global_position.y, tractor_lerp)
	
	scale = Vector2.ONE * (1- tractor_lerp)
	
	in_tractor_beam = false
	
	if player.global_position.distance_to(global_position) > 6500:
		queue_free()
