extends "res://Scripts/FallingObjs/BaseFallingObj.gd"


func on_catch():
	.add_health(1)
	queue_free()

func on_drop():
	queue_free()
	
