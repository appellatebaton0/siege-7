class_name TrayButton extends Button

var menu_toggle := false

@export var animator:AnimationPlayer


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ToggleMenu"):
		_pressed()

func _pressed() -> void:
	if not animator.is_playing():
		menu_toggle = !menu_toggle
		
		animator.play("open_menu" if menu_toggle else "close_menu")
