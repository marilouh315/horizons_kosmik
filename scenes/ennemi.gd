extends CharacterBody2D

const GRAVITY = 500.0
const SPEED = 10.0
var direction = Vector2.LEFT 

func _ready():
	pass

func _process(delta):
	velocity.x = direction.x * SPEED
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta  
		
		position += velocity * delta
	
	
	if position.x <= -200 or position.x >= 200:
		direction.x = -direction.x
	move_and_slide()
