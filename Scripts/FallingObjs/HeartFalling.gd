extends "res://Scripts/FallingObjs/BaseFallingObj.gd"


func on_catch():
	.add_points()
	queue_free()

func on_drop():
	print("DROPPED")

func on_start():
	pass
