extends Label

onready var Player = $AnimationPlayer

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	Player.play("text_appear")
	

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	Player.play("text_disappear")
