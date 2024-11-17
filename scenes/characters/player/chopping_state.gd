extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	#If there is no animation playing, we switch back to Idle state
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")

#Play the animation only when entering the state. Ths why here and not in physics_process
func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite_2d.play("chopping_back")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2d.play("chopping_right")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2d.play("chopping_front")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2d.play("chopping_left")
	#Dont really understadn this last else
	else:
		animated_sprite_2d.play("chopping_front")


func _on_exit() -> void:
	animated_sprite_2d.stop()
