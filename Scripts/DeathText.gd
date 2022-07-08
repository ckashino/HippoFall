extends Label

func _ready():
	hide()

func _input(event):
	if event is InputEventMouseButton and visible:
		get_node("/root/GlobalScript").score = 0
		get_node("/root/GlobalScript").health = 3
		get_tree().paused = false
		hide()
		get_tree().change_scene("res://Scenes/MainGameNode.tscn")
		
