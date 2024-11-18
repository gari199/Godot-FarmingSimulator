extends StaticBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

func _ready() -> void:
	#The interactable component connects to the signal emited on them when body_enter/exited and uses the functions
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	#Per default, collision layer = 1. Player interacts with this layer though (cant pass)
	collision_layer = 1
	
func on_interactable_activated() -> void:
	animated_sprite_2d.play("open_door")
	#We change the collision to 2 when opening so the player con go through.
	collision_layer = 2
	
func on_interactable_deactivated() -> void:
	animated_sprite_2d.play("close_door")
	#Change back the layer when player has exited
	collision_layer = 1
