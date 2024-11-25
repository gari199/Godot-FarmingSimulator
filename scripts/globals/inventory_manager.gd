#  Tutorial 15
extends Node

var inventory: Dictionary = Dictionary()

signal inventory_changed

func add_collectable(collectable_name: String) -> void:
	inventory.get_or_add(collectable_name)
	# If nothing in the inventory matches the collectable_name,
	# we set it to 1. Otherwise we sum one.
	if inventory[collectable_name] == null:
		inventory[collectable_name] = 1
	else:
		inventory[collectable_name] += 1

	inventory_changed.emit()
