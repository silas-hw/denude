extends Actor

var direction = null

func _ready():
	set_physics_process(false)
	print(self.position)

func _physics_process(delta):
	direction = get_direction(direction)
	_velocity = get_new_velocity(_velocity, direction, speed, delta)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
func get_direction(direction):
	var out = direction
	if direction == null:
		out = Vector2(-1, 0)
	elif is_on_wall():
		out.x = -direction.x
		
	return out
	
func get_new_velocity(start_velocity, direction, speed, delta):
	var out = start_velocity
	
	out.x = speed.x*direction.x
	out.y += gravity*delta

	return out
