extends NodeState

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var idle_state_time_interval: float = 5.0

#Timer to move the chicken from idle state to walk state created programatically
@onready var idle_state_timer: Timer = Timer.new()

var idle_state_timeout: bool = false

func _ready() -> void:
	#Wait for the time_interval
	idle_state_timer.wait_time = idle_state_time_interval
	#When the 5 seconds have passed, we connect the signal to the function
	idle_state_timer.timeout.connect(on_idle_state_timeout)
	#Add the programatically timer to our scene as child of state machine node
	add_child(idle_state_timer)

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	pass

func on_idle_state_timeout() -> void:
	idle_state_timeout = true

func _on_next_transitions() -> void:
	if idle_state_timeout == true:
		transition.emit("Walk")


func _on_enter() -> void:
	animated_sprite_2d.play("idle")
	#When we enter the state, timeout will be false and we start counting
	idle_state_timeout = false
	idle_state_timer.start()

func _on_exit() -> void:
	animated_sprite_2d.stop()
	idle_state_timer.stop()
