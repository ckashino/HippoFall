extends KinematicBody2D

const GRAVITY = 400
const WALK_SPEED = 200
const JUMP_SPEED = 200

var velocity = Vector2()

func _physics_process(delta):
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = WALK_SPEED
	else:
		velocity.x = 0

	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))

	if is_on_floor():
		if Input.is_action_pressed("jump"):
			velocity.y = -JUMP_SPEED
