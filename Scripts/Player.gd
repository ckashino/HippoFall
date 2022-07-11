extends KinematicBody2D

const GRAVITY = 900
const WALK_SPEED = 200
const JUMP_SPEED = 400
const DASH_SPEED = 1000

var velocity = Vector2()

var can_jump

var can_dash = true
var dashing = false
var dash_duration = 0.2
var dash_timer = 0

var dash_particles = preload("res://Scenes/DashExplosion.tscn")

func _ready():
	$AnimatedSprite.playing = true

func _physics_process(delta):
	
	if !dashing:
		if Input.is_action_pressed("move_left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("move_right"):
			velocity.x = WALK_SPEED
		else:
			velocity.x = 0

	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))

	if dashing:
		dash_timer += delta
		if dash_timer > dash_duration:
			dashing = false
			can_dash = true
			$AnimatedSprite.speed_scale = 2.5
			dash_timer = 0
			
	if Input.is_action_pressed("dash") and !dashing:
		dashing = true
		can_dash = false
		$AnimatedSprite.speed_scale = 8
		velocity.x = sign(velocity.x) * DASH_SPEED
		var particles = dash_particles.instance()
		particles.get_node("CPUParticles2D").direction.x = -1 * sign(velocity.x)
		particles.position = global_position
		get_parent().add_child(particles)

	if abs(velocity.x) > 0:
		$AnimatedSprite.animation = "walking"
		$AnimatedSprite.scale.x = abs($AnimatedSprite.scale.x) * sign(velocity.x)
	else:
		$AnimatedSprite.animation = "default"

	if Input.is_action_pressed("jump") and can_jump:
		can_jump = false
		velocity.y = -JUMP_SPEED
	if is_on_floor() and !can_jump:
		can_jump = true
