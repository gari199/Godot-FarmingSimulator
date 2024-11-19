extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

#Tutorial 6: we add this export to add the hit box when hitting with the axe
#and the positions of the hit box when chopping
@export var hit_component_collision_shape: CollisionShape2D

func _ready() -> void:
	#We start with it disabled at (0, 0)
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0, 0)

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	#If there is no animation playing, we switch back to Idle state
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")

#Play the animation only when entering the state. This why here and not in physics_process
func _on_enter() -> void:
	#Enable hit component when chopping
	hit_component_collision_shape.disabled = false
	
	if player.player_direction == Vector2.UP:
		animated_sprite_2d.play("chopping_back")
		hit_component_collision_shape.position = Vector2(0, -18)
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2d.play("chopping_right")
		hit_component_collision_shape.position = Vector2(9, 0)
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2d.play("chopping_front")
		hit_component_collision_shape.position = Vector2(0, 3)
	elif player.player_direction == Vector2.LEFT:
		hit_component_collision_shape.position = Vector2(-9, 0)
		animated_sprite_2d.play("chopping_left")
	#Dont really understand this last else
	else:
		animated_sprite_2d.play("chopping_front")
		

func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.disabled = true
