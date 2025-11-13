class_name TrayButton extends Button

var menu_toggle := false

@export var animator:AnimationPlayer
@export var anim := "open_menu"
@export var unanim := "close_menu"

@export var s = ["X", "O"]

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ToggleMenu"):
		_pressed()
	text = s[0] if menu_toggle else s[1]

func _pressed() -> void:
	if not animator.is_playing():
		menu_toggle = !menu_toggle
		
		animator.play(anim if menu_toggle else unanim)
