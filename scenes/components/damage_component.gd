class_name DamageComponent
extends Node2D

@export var max_damage: int = 1
@export var current_damage: int = 0

signal max_damage_reached

func apply_damage(damage: int) -> void:
	#clamp(variable, min, max): return a value > min and < max. No if current damage <0... etc
	current_damage = clamp(current_damage + damage, 0, max_damage)
	
	if current_damage == max_damage:
		max_damage_reached.emit()
