#First interactable component.
#First use Case: the door must react opening and closing when player enters/exits is

#This component is on collision Layer 3 and Collision Mask 2( interacts with the player)

class_name InteractableComponent
extends Area2D

signal interactable_activated
signal interactable_deactivated


func _on_body_entered(body: Node2D) -> void:
	interactable_activated.emit()


func _on_body_exited(body: Node2D) -> void:
	interactable_deactivated.emit()
