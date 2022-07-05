extends Node2D

var heart_obj = preload("res://Scenes/FallingObjects/HeartFalling.tscn")

var timer = 0
var rate = 2

func _ready():
	pass
	
func _physics_process(delta):
	timer += delta
	if timer > rate:
		var falling_obj = heart_obj.instance()
		falling_obj.position = Vector2(rand_range(167, 857), -100)
		$FallingObjs.add_child(falling_obj)
		timer = 0
