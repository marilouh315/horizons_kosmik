extends Area2D

signal marker_detected

func _on_zone_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("marker_detected")

