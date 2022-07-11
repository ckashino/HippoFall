extends "res://Scripts/FallingObjs/BaseFallingObj.gd"

func on_catch():
	add_health(-3)
	queue_free()

func on_drop():
	.explode()
	queue_free()
