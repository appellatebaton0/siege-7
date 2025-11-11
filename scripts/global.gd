extends Node

@warning_ignore("unused_signal") 
signal updated_contents

var money := 0

var hydrogen := 0
var helium := 0
var oxygen := 0
var carbon := 0
var neon := 0

## Changes a value by an amount and updates anything
## relying on it.
func change_contents(value:String, by:int):
	set(value, get(value) + by)
	updated_contents.emit()

func _ready() -> void:
	updated_contents.emit()
