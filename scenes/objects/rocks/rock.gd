extends Sprite2D
#We import both hurt and damage components for the signals
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage) -> void:
	damage_component.apply_damage(hit_damage)
	
func on_max_damage_reached() -> void:
	$Timer.start()

#Personally added timer so the tree falls when the axe comes down.
#Before that, tree was dissapearing right after clicking the mouse and looked bad.
func _on_timer_timeout() -> void:
	call_deferred("add_stone_scene")
	queue_free()

func add_stone_scene()-> void:
	var stone_instance = stone_scene.instantiate() as Node2D
	stone_instance.global_position = global_position
	get_parent().add_child(stone_instance)
