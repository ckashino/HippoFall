extends TouchScreenButton

onready var globals = get_node("/root/GlobalScript")

func _ready():
	if globals.touch_controls:
		show()
	else:
		hide()
