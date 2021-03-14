extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
	
	if Input.is_action_just_pressed("unpause"):
		get_tree().paused = false
