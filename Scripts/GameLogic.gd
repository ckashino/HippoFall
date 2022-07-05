extends Node2D

onready var globals = get_node("/root/GlobalScript")

var heart_obj = preload("res://Scenes/FallingObjects/HeartFalling.tscn")

var timer = 0
var rate = 2

var old_score

func _ready():
	old_score = globals.get("score")
	
func _physics_process(delta):
	if globals.get("score") != old_score:
		print(globals.get("score"))
	
	timer += delta
	if timer > rate:
		var falling_obj = heart_obj.instance()
		falling_obj.position = Vector2(rand_range(167, 857), -100)
		$FallingObjs.add_child(falling_obj)
		timer = 0
		
	old_score = globals.get("score")
