extends CharacterBody2D

var Bullet = preload("res://ball.tscn")
var speed = 200

func get_input():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("tirer"):
		shoot()
 
func shoot():
	var b = Bullet.instantiate()
	b.global_position = $Markerball.global_position
	b.rotation = rotation + get_parent().rotation
	get_tree().root.add_child(b)
func _physics_process(delta):
	get_input()
	look_at(get_global_mouse_position())
	move_and_slide()
