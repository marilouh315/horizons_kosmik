extends AnimatedSprite2D

func _process(delta):
	if not is_playing():
		hide()
	else :
		show()
