extends Level

func _ready():
	RespawnLocation = $Respawn_Location
	
func update_respawn_location(pos):
	RespawnLocation.position = pos
	
func _on_Checkpoint_1_body_entered(body):
	update_respawn_location(body.position)


func _on_Checkpoint_2_body_entered(body):
	update_respawn_location(body.position)
