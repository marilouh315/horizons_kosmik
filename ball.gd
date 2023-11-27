extends CharacterBody2D

const SPEED = 500
var degat = 10

func getDegat():
	return degat

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	var new_position = global_position + SPEED * direction * delta
	var collision = move_and_collide(new_position - global_position)
	
	if collision:
		if collision.get_collider().has_method("toucher"):
			collision.get_collider().toucher(degat)
		queue_free()
