extends Node2D

export var points = 1
export var explode_color: Color = Color(1, 1, 1)

onready var globals = get_node("/root/GlobalScript")

func _ready():
	$RigidBody2D.contact_monitor = true
	$RigidBody2D.contacts_reported = 1
	on_start()

func _physics_process(delta):
	on_tick()
	
func on_tick():
	pass

func on_start():
	pass

func on_catch():
	pass

func on_drop():
	pass

func add_points():
	globals.score += points

func add_health(health_change):
	globals.health += health_change

func _on_RigidBody2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		on_catch()
	else:
		on_drop()

func explode():
	get_parent().get_parent().spawn_explosion($RigidBody2D.global_position, explode_color)
