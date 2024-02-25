extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Rock"):
		$"ColorRect".color = Color(0, 0.639, 0.31)
		get_tree().call_group("Door", "disable")



func _on_body_exited(body):
	if body.is_in_group("Rock"):
		$"ColorRect".color = Color(0.996, 0, 0.051)
		get_tree().call_group("Door", "enable")

