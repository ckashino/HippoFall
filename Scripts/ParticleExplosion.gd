extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$CPUParticles2D.emitting = true

func _process(delta):
	if $CPUParticles2D.emitting == false:
		queue_free()
