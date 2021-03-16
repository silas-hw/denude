extends Actor

export var walljump_velocity = Vector2(800, -1000)
export var walldrag_multiplier = 0.8
export var Jump_Interrupted_multiplier = 0.5

onready var Animation_Player = $AnimationPlayer
onready var Player_Camera = $Camera2D
onready var Kayote_Timer = $KayoteTimer
onready var Jump_Timer = $JumpTimer
onready var Sounds = $Sounds
onready var Respawn_Location = get_parent().get_node("Respawn_Location")

var is_walldrag = false
var can_walldrag = false
var can_move = true
var is_jump_interrupted

func _physics_process(delta):
	if check_collision_with_hazard():
		can_move = false
		death()
	
	if !check_collision_with_hazard():
		can_move = true
		
	if is_on_floor():
		Kayote_Timer.start()
			
	var direction = get_direction()
	_velocity = get_new_velocity(_velocity, speed, direction, is_jump_interrupted, delta)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	Animation_Player.play(get_animation(direction, _velocity, is_jump_interrupted))

func check_collision_with_hazard():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.collision_layer == 2147483776:
			return true
	
	return false

func get_direction():
	var direction = Vector2(0, 1)
	
	if !can_move:
		return direction
	
	if Input.is_action_pressed("move_left"):
		direction.x += -1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
	if Input.is_action_just_pressed("move_jump"):
		Jump_Timer.start()
		
	is_jump_interrupted = Input.is_action_just_released("move_jump")
		
	if Kayote_Timer.time_left > 0 and Jump_Timer.time_left > 0:
		direction.y = -1
	
	return direction
	
func get_animation(direction, velocity, is_jump_interrupted):
	
	if is_walldrag:
		if direction.x == 1:
			return "Walldrag_r"
		return "Walldrag_l"
	elif velocity.y < 0 or is_jump_interrupted or velocity.y > 0 and !is_on_floor():
		return "Fall"
	elif direction.x == 1:
		return "Walk_r"
	elif direction.x == -1:
		return "Walk_l"
	
	return "Idle"
		

	
func get_new_velocity(start_velocity, speed, direction, is_jump_interrupted, delta):
	var out = start_velocity
	
	if direction.x != 0:
		out.x = lerp(out.x, speed.x*direction.x, acceleration)
	else:
		out.x = lerp(out.x, 0, friction)
	
	out.y += gravity*delta
		
	if can_walldrag and is_on_wall():
		out.y *= walldrag_multiplier
		is_walldrag = true
	else:
		is_walldrag = false

	if direction.y == -1:
		if is_walldrag:
			out = walljump_velocity
			out.x *= -direction.x
		else:
			out.y = speed.y*direction.y
	
	if is_jump_interrupted and start_velocity.y < 0:
		out.y *= Jump_Interrupted_multiplier

	return out
	
func death():
	$Sprite2/AnimationPlayer.play("Death")
	
func respawn():
	Player_Camera.set_enable_follow_smoothing(false)
	self.position = Respawn_Location.position
	Player_Camera.reset_smoothing()
	Player_Camera.set_enable_follow_smoothing(true)
	
	
	
func _on_Area_WallDrag_body_entered(body):
	can_walldrag = true
	
func _on_Area_WallDrag_body_exited(body):
	can_walldrag = false


func _on_death_body_entered(body):
	if body.name == "Player":
		death()
