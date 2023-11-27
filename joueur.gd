extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 800.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var doublesaut = true
var bougeversdroite = true

func _ready():
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		doublesaut = true
		
	var movement = Vector2(0, 0)
	var direction = Input.get_axis("a", "d")
	
	if direction != 0:
		velocity.x = direction * SPEED
			
	if Input.is_action_just_pressed("w"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			$mouvement.play("jump")
		elif doublesaut:
			velocity.y = JUMP_VELOCITY
			$mouvement.play("jump2")
			doublesaut = false
	# Handle Jump.
	if Input.is_action_just_pressed("w") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$mouvement.play("jump")
	if Input.is_action_just_pressed("w") and not is_on_floor() and doublesaut:
		velocity.y = JUMP_VELOCITY
		$mouvement.play("jump2")
		doublesaut = false

	if direction:
		$mouvement.flip_h = (direction < 0)
		velocity.x = direction * SPEED
		if is_on_floor() and not Input.is_action_just_pressed("w"):
			$mouvement.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not Input.is_action_just_pressed("w"):
			$mouvement.play("rien")
			
	move_and_slide()

