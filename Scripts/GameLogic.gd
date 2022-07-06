extends Node2D

onready var globals = get_node("/root/GlobalScript")

var heart_obj = preload("res://Scenes/FallingObjects/HeartFalling.tscn")
var bomb_obj = preload("res://Scenes/FallingObjects/BombFalling.tscn")
var melon_obj = preload("res://Scenes/FallingObjects/MelonFalling.tscn")
var skull_obj = preload("res://Scenes/FallingObjects/SkullFaling.tscn")

onready var score_label = $UI/Label
onready var health_label = $UI/Health

var timer = 0
var rate = 2
var spawn_count = 0

var old_score

func _ready():
	old_score = globals.get("score")
	
func _physics_process(delta):
	if globals.get("score") != old_score:
		score_label.text = "Score: " + str(globals.get("score"))
		
	health_label.text = "<3".repeat(globals.get("health"))
	
	timer += delta
	
	if timer > rate:
		spawn_count += 1
		var falling_obj = heart_obj.instance()
		falling_obj.position = Vector2(rand_range(167, 857), -100)
		$FallingObjs.add_child(falling_obj)
		timer = 0
		
	old_score = globals.get("score")
