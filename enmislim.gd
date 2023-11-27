# ennemimark.gd

extends Area2D

signal marker_detected

func _on_ennemimark_body_entered(body):
	if body.is_in_group("joueur"):
		emit_signal("marker_detected", global_position)
