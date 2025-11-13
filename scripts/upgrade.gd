@abstract class_name Upgrade extends Node

@onready var player:Player = get_tree().get_first_node_in_group("Player")

@export var get_desc := ""

@abstract func upgrade()
