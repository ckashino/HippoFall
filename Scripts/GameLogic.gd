tool
extends Node2D

var globals

var debug_obj = preload("res://Debug/FallingObject_debug.tscn")

var heart_obj = preload("res://Scenes/FallingObjects/HeartFalling.tscn")
var bomb_obj = preload("res://Scenes/FallingObjects/BombFalling.tscn")
var melon_obj = preload("res://Scenes/FallingObjects/MelonFalling.tscn")
var skull_obj = preload("res://Scenes/FallingObjects/SkullFalling.tscn")

onready var score_label = $UI/Label
onready var health_label = $UI/Health

var timer = 0
var rate = 2
var spawn_count = 0

export var debug_rate = 1
export var toggle_debug: bool = false
export var launch_pos_debug = Vector2(0, 0)
export var launch_force = Vector2(0, 0)

var debugging = false

func _ready():
	if not Engine.editor_hint:
		globals = get_node("/root/GlobalScript")

func _physics_process(delta):
	if not Engine.editor_hint:
		score_label.text = "Score: " + str(globals.score)
		health_label.text = "<3 ".repeat(globals.get("health"))
		
		timer += delta
		
		if timer > rate:
			spawn_count += 1
			var falling_obj = bomb_obj.instance()
			falling_obj.position = Vector2(rand_range(167, 857), -100)
			$FallingObjs.add_child(falling_obj)
			timer = 0
	else:
		if toggle_debug:
			toggle_debug = false
			debugging = !debugging
			Physics2DServer.set_active(debugging)
		if debugging:
			timer += delta
			if timer > debug_rate:
				var debug_fall = debug_obj.instance()
				debug_fall.position = launch_pos_debug
				debug_fall.get_node("RigidBody2D").apply_central_impulse(launch_force)
				$FallingObjs.add_child(debug_fall)
				var tween = debug_fall.get_node("Tween")
				tween.interpolate_callback(debug_fall, debug_rate * 10, "queue_free")
				tween.start()
				print("TEST")
				timer = 0
		
