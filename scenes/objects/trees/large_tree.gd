extends Sprite2D
#We import both hurt and damage components for the signals
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage) -> void:
	damage_component.apply_damage(hit_damage)
	
func on_max_damage_reached() -> void:
	print("Max Damage reached")
	$Timer.start()

#Personally added timer so the tree falls when the axe comes down.
#Before that, tree was dissapearing right after clicking the mouse and looked bad.
func _on_timer_timeout() -> void:
	call_deferred("add_log_scene")
	queue_free()

func add_log_scene()-> void:
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)
