extends Node2D

func _ready():
	$AnimationPlayer.play("text_float")
	
func _process(delta):
	if Input.is_action_pressed("key_space"):
		$AnimationPlayer.play("start")
		
func load_game():
	get_tree().change_scene("res://src/levels/Level1.tscn")
