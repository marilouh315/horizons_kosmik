extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -280.0
const GRAVITY = 500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var doublesaut = true
var bougeversdroite = true
var vie = 100
var enemy_scene = preload("res://scenes/ennemi.tscn")

func _ready():
	add_to_group("joueur")
	$ennemimark.connect("body_entered", self, "_on_marker_detected")
	
func _on_marker_detected(body):
	if body.is_in_group("ennemimark"):
		var enemy_instance = enemy_scene.instance()
		enemy_instance.global_position = body.global_position
		get_tree().current_scene.add_child(enemy_instance)
		print("Ennemi apparu sur le marqueur !")
		
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

