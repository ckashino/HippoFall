extends "res://Scripts/FallingObjs/BaseFallingObj.gd"


func on_catch():
	.add_points()
	queue_free()

func on_drop():
	globals.health -= 1
	.explode()	
	queue_free()

func on_start():
	pass
