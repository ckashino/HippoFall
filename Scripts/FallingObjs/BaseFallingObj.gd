extends Node2D

export var points = 1

func _ready():
	$RigidBody2D.contact_monitor = true
	$RigidBody2D.contacts_reported = 10
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


func _on_RigidBody2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		on_catch()
		print("TESR")
	else:
		on_drop()