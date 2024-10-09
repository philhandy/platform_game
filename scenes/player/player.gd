extends CharacterBody2D

const GRAVITY = 600
const SPEED = 250
const JUMP_FORCE = 300
const SLOW_DOWN_TIME = 0.2

func _ready():
	%Image.play('idle')

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

func _process(delta):
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

func _on_area_2d_area_entered(area):
	if area.is_in_group('trap'):
		print('hit')
	if area.is_in_group('fire'):
		print('fire')
