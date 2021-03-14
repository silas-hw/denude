extends CenterContainer

func _ready():
	hide()
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		show()
	
	if Input.is_action_just_pressed("unpause"):
		hide()
