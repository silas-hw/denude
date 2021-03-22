extends Node2D

onready var can_player_toggle = true
onready var player_in_tile = false
onready var Animation_Player = $AnimationPlayer
onready var Player = get_parent().get_node("Player")

onready var TileSets = [$World_Shadow1, $World_Shadow2]

func _physics_process(delta):
	if Input.is_action_just_pressed("key_w") and can_player_toggle and Player.can_move:
		can_player_toggle = false
		toggle_tiles_collision()
		$sound_snap.play()
			
		Animation_Player.play("World_Shadow_Cooldown")
			
func toggle_tiles_collision():
	var state
	for tile_set in TileSets:
		if !tile_set.state:
			tile_set.set_collision_layer(16)
		
			tile_set.modulate = Color(0.26, 0.26, 0.26, 1)
			tile_set.state = true
		else:
			
			if player_in_tile:
				Player.death()
				
			tile_set.set_collision_layer(0)
		
			tile_set.modulate = Color(1, 1, 1, 0.4)
			tile_set.state = false
			
func _on_Cooldown_timeout():
	can_player_toggle = true


func _on_Player_Detection_body_entered(body):
	can_player_toggle = false
	player_in_tile = true


func _on_Player_Detection_body_exited(body):
	can_player_toggle = true
	player_in_tile = false
