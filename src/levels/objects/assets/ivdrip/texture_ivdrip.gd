extends TextureRect

onready var Sound = $AudioStreamPlayer2D

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	Sound.stop()
	hide()
