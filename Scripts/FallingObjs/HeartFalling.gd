extends "res://Scripts/FallingObjs/BaseFallingObj.gd"


func on_catch():
	print("THIS IS A HEART")
	queue_free()

func on_drop():
	print("DROPPED")

func on_start():
	pass
