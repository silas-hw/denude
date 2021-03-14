extends Level

func _ready():
	RespawnLocation = $Respawn_Location
	
	CheckpointPositions = [
	$Checkpoints/Checkpoint_1.position
]

func _on_Checkpoint_1_body_entered(body):
	RespawnLocation.position = CheckpointPositions[0]
