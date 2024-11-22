extends NodeState

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var timer: Timer = Timer.new()

var timer_countdown: float = 5.0
var timer_timeout: bool = false

func _ready() -> void:
	timer.wait_time = timer_countdown
	timer.timeout.connect(timer_timeout_reached)
	# If node not added, nothing works as it would virtually not exist.
	add_child(timer)
	
func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass

func timer_timeout_reached() -> void:
	timer_timeout = true

func _on_next_transitions() -> void:
	if timer_timeout == true:
		transition.emit("walk")


func _on_enter() -> void:
	animated_sprite_2d.play("idle")
	timer_timeout = false
	timer.start()

func _on_exit() -> void:
	animated_sprite_2d.stop()
	timer.stop()
