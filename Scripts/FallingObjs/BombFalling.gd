extends "res://Scripts/FallingObjs/BaseFallingObj.gd"


func on_catch():
	.add_points()
	.add_health(-1)
	queue_free()

func on_drop():
	queue_free()

func on_start():
	points = -10
