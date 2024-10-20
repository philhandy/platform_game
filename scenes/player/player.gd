extends CharacterBody2D

const GRAVITY = 600
const SPEED = 250
const JUMP_FORCE = 300
const SLOW_DOWN_TIME = 0.2

var alive

func _ready():
	%Image.play('idle')
	alive = true

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

func _process(delta):
	if not alive:
		return
	var new_velocity = 0.0
	if Input.is_action_pressed('Left'):
		new_velocity -= SPEED
	if Input.is_action_pressed('Right'):
		new_velocity += SPEED
	if new_velocity == 0.0 and velocity.x != 0.0:
		# should be slowing down
		var slow_down = delta * (SPEED / SLOW_DOWN_TIME)
		if velocity.x > 0.0:
			new_velocity = max(velocity.x - slow_down, 0.0)
		else:
			new_velocity = min(velocity.x + slow_down, 0.0)
	
	if velocity.x != 0.0 and is_on_floor():
		%Image.play('running')
	else:
		%Image.play('idle')
		
	if Input.is_action_pressed('Jump'):
		if is_on_floor():
			velocity.y -= JUMP_FORCE
			
	if not is_on_floor():
		if velocity.y > 0.0:
			%Image.play('fall')
		else:
			%Image.play('jump')
			
	velocity.x = new_velocity
	
	# flip image if needed
	if velocity.x > 0.0:
		%Image.flip_h = false
	else:
		%Image.flip_h = true

func player_death():
	velocity.y -= JUMP_FORCE
	alive = false
	collision_layer = 2
	collision_mask = 2

func _on_area_2d_area_entered(area):
	if not alive:
		return
	if area.is_in_group('trap'):
		player_death()
	if area.is_in_group('fire'):
		player_death()
