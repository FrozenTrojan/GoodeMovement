extends CharacterBody2D

const JUMP_VELOCITY = -350.0
const WALK = 150
const RUN = 300
const ACCELERATION = 10
var SPEED = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var sprinting = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var sprint_pressed = Input.is_action_just_pressed('sprint')

	if (direction == 0):
		SPEED -= ACCELERATION

	if sprint_pressed:
		sprinting = true
	elif Input.is_action_just_released('sprint'):
		sprinting = false

	if sprinting:
		if(SPEED <= RUN):
			SPEED += ACCELERATION
		velocity.x = direction * SPEED
	else:
		if(SPEED <= WALK):
			SPEED += ACCELERATION
		velocity.x = direction * SPEED

	move_and_slide()
