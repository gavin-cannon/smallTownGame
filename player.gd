extends CharacterBody2D

@onready var animated_sprite = $"AnimatedSprite2D"
var push_force = 80.0
var last_direction
var audio_player:AudioStreamPlayer

func _ready():
	animated_sprite.play("idleDown")
	audio_player = get_tree().get_nodes_in_group("AudioPlayerJewel")[0]
	#var test = load("res://smallTownGame.tscn")
	#get_node("CollisionShape2D").add_child(test.instantiate())
	
func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	print(direction)
	if direction == Vector2.UP:
		animated_sprite.flip_h = false
		animated_sprite.play("walkUp")
		last_direction = Vector2.UP
	elif direction == Vector2.DOWN:
		animated_sprite.flip_h = false
		animated_sprite.play("walkDown")
		last_direction = Vector2.DOWN
	elif direction == Vector2.LEFT:
		animated_sprite.play("walkRight")
		animated_sprite.flip_h = true
		last_direction = Vector2.LEFT
	elif direction == Vector2.RIGHT:
		animated_sprite.flip_h = false
		animated_sprite.play("walkRight")
		last_direction = Vector2.RIGHT
		
	elif direction == Vector2.ZERO:
		if last_direction == Vector2.UP:
			animated_sprite.flip_h = false
			animated_sprite.play("idleUp")
		elif last_direction == Vector2.DOWN:
			animated_sprite.flip_h = false
			animated_sprite.play("idleDown")
		elif last_direction == Vector2.RIGHT:
			animated_sprite.flip_h = false
			animated_sprite.play("idleRight")
		elif last_direction == Vector2.LEFT:
			animated_sprite.flip_h = true
			animated_sprite.play("idleRight")
	
	velocity = direction * 600
	#print(velocity)
	print(position)
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	
	#if velocity.length() > 0.0:
		#%HappyBoo.play_walk_animation()
	#else:
		#%HappyBoo.play_idle_animation()		


func _on_area_2d_area_entered(area):
	if area.is_in_group("Jewel"):
		area.queue_free()
		audio_player.play()
