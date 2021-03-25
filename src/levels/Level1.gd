extends Level

func _ready():
	RespawnLocation = $Respawn_Location
	
func _on_Checkpoint_body_entered(body):
	RespawnLocation.position = body.position
