extends Node2D
onready var globals = get_node("/root/GlobalScript")

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/MainGameNode.tscn")



func _on_CheckBox_toggled(button_pressed):
	globals.touch_controls = button_pressed
	print(globals.touch_controls)
