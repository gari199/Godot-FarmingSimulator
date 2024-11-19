# Tutoria6: collectable comonent for all collectables
class_name ColletacleComponent
extends Area2D

@export var collectable_name: String

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Collected")
		# We get the parent as the component will be attached to different items (log, fruits..)
		# and those are the ones who have to dissapear
		get_parent().queue_free()
		
