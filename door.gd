extends StaticBody2D

func disable():
	visible = false
	get_node("CollisionShape2D").set_deferred("disabled", true)

func enable():
	visible = true
	get_node("CollisionShape2D").set_deferred("disabled", false)
