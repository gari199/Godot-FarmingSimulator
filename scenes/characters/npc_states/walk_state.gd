extends NodeState

@export var character: NonPlayableCharacter
@export var animated_sprite_2d: AnimatedSprite2D
@export var navigation_agent_2d: NavigationAgent2D
@export var min_speed: float = 10
@export var max_speed: float = 20

var speed: float

func _ready() -> void:
	#Signal that detetcs the necessity of compute safe_velocity and call our function
	navigation_agent_2d.velocity_computed.connect(on_safe_velocity_computed)
	# Tutorial10: call_deferred (again) to call a function in the next frame
	call_deferred("character_setup")

# If this function is skipped, all cows travel to the same point the first time.
# We need to wait one extra frame for the agent on every chicken to work independently.
func character_setup() -> void:
	await get_tree().physics_frame
	set_movement_target()
	
func set_movement_target() -> void:
	#Select random position in the navigation map
	var target_position: Vector2 = NavigationServer2D.map_get_random_point(navigation_agent_2d.get_navigation_map(), navigation_agent_2d.navigation_layers, true)
	print(target_position)
	navigation_agent_2d.target_position = target_position
	speed = randf_range(min_speed, max_speed)
	

func _on_process(_delta : float) -> void:
	pass
	
func _on_physics_process(_delta : float) -> void:
	# If navigation has finished, set another movement
	if navigation_agent_2d.is_navigation_finished():
		character.current_walk_cycles += 1
		set_movement_target()
		return
	
	var target_position = navigation_agent_2d.get_next_path_position()
	
	#Gets the direction our chichen is facing
	var target_direction: Vector2 = character.global_position.direction_to(target_position)
	
	# Work with avoidance enabled (getting complicated)
	# If avoidance is enabled, speed will change to safe_velocity so we dont collide.
	# If avoidance is disabled = false (no collision) move normally.
	var velocity: Vector2 = target_direction * speed
	if navigation_agent_2d.avoidance_enabled:
		animated_sprite_2d.flip_h = velocity.x < 0
		navigation_agent_2d.velocity = velocity
	else:
		character.velocity = velocity
		character.move_and_slide()

func on_safe_velocity_computed(safe_velocity: Vector2) -> void:
	animated_sprite_2d.flip_h = safe_velocity.x < 0
	character.velocity = safe_velocity
	character.move_and_slide()

func _on_next_transitions() -> void:
	if character.current_walk_cycles == character.walk_cycles:
		character.velocity = Vector2.ZERO
		transition.emit("idle")

func _on_enter() -> void:
	animated_sprite_2d.play("walk")
	character.current_walk_cycles = 0

func _on_exit() -> void:
	animated_sprite_2d.stop()
