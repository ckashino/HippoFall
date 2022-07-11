tool
extends Node2D

var globals

var debug_obj = preload("res://Debug/FallingObject_debug.tscn")

var heart_obj = preload("res://Scenes/FallingObjects/HeartFalling.tscn")
var bomb_obj = preload("res://Scenes/FallingObjects/BombFalling.tscn")
var melon_obj = preload("res://Scenes/FallingObjects/MelonFalling.tscn")
var skull_obj = preload("res://Scenes/FallingObjects/SkullFalling.tscn")
var explosion = preload("res://Scenes/ParticleExplosion.tscn")

onready var score_label = $UI/Label
onready var health_label = $UI/Health

var timer = 0
var rate = 2
var spawn_count = 0

var start_pos = Vector2(-50, 100)
var launch_min = Vector2(100, -100)
var launch_max = Vector2(250, -100)

var falling_objs = [heart_obj, bomb_obj, melon_obj, skull_obj]

var rng = RandomNumberGenerator.new()
var probabilities = [
	[9, 10, 0, 0],
	[8, 10, 0, 0],
	[7, 9, 10, 0],
	[6, 8, 9, 10]
]

# debugging vars
export var debug_rate = 1
export var toggle_debug: bool = false
export var launch_pos_debug = Vector2(0, 0)
export var launch_force_debug = Vector2(0, 0)

var debugging = false

func _ready():
	if not Engine.editor_hint:
		globals = get_node("/root/GlobalScript")

func _physics_process(delta):
	if not Engine.editor_hint:
		score_label.text = "Score: " + str(globals.score)
		health_label.text = "<3 ".repeat(clamp(globals.get("health"), 0, 3))
		if globals.health <= 0:
			$UI/DeathText.show()
			get_tree().paused = true
		else:
			
			timer += delta
			
			if timer > rate:
				spawn_count += 1
				var falling_obj = falling_objs[get_object_index(probabilities[get_difficulty()])].instance()
				if rng.randi_range(0, 1) == 0:
					launch_spawn(falling_obj)
				else:
					normal_spawn(falling_obj)
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
				debug_fall.get_node("RigidBody2D").apply_central_impulse(launch_force_debug)
				$FallingObjs.add_child(debug_fall)
				var tween = debug_fall.get_node("Tween")
				tween.interpolate_callback(debug_fall, debug_rate * 10, "queue_free")
				tween.start()
				timer = 0
		

func get_object_index(weights):
	var rand_num = rng.randi_range(0, 10)
	for x in range(4):
		if rand_num <= weights[x]:
			return x

func normal_spawn(object):
	object.position = Vector2(rand_range(167, 857), -100)
	$FallingObjs.add_child(object)

func launch_spawn(object):
	var launch_dir = 1
	var launch_pos
	if rng.randi_range(0, 1) == 0:
		launch_pos = Vector2(-50, 100)
	else:
		launch_pos = Vector2(1074, 100)
		launch_dir = -1
		
	var launch_force = Vector2(rng.randf_range(100, 265) * launch_dir, -100)
	
	object.position = launch_pos
	object.get_node("RigidBody2D").apply_central_impulse(launch_force)
	object.get_node("RigidBody2D").angular_velocity = rand_range(-50, 50)
	$FallingObjs.add_child(object)

func get_difficulty():
	if spawn_count > 50:
		rate = 1.25
		return 3
	elif spawn_count > 30:
		rate = 1.5
		return 2
	elif spawn_count > 10:
		rate = 1.75
		return 1
	else:
		return 0

func spawn_explosion(pos: Vector2, explode_color: Color):
	var explosion_obj = explosion.instance()
	explosion_obj.position = pos
	explosion_obj.get_node("CPUParticles2D").modulate = explode_color
	add_child(explosion_obj)
