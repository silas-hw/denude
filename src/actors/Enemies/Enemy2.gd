extends Actor

onready var IdleTimer = $IdleTimer
onready var snap = Vector2(position.x, 0)

var direction = 1

func _physics_process(delta):
	if !is_on_ceiling() and !is_on_floor():
		IdleTimer.start()
		
	direction = get_direction()
	_velocity = calculate_new_velocity(_velocity, direction, speed)
	_velocity = move_and_slide_with_snap(_velocity, snap, FLOOR_NORMAL)
	
func get_direction():
		
	if IdleTimer.time_left > 0 and (is_on_ceiling() or is_on_floor()):
		return 0
	
	if is_on_ceiling():
		return 1
	elif is_on_floor():
		return -1
		
	if direction == 0:
		return 1
		
	return direction
	
func calculate_new_velocity(start_velocity, direction, speed):
	var out = start_velocity
	
	out.y = direction*speed.y
	out.x = 0
	
	return out
