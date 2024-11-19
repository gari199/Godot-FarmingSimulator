class_name HurtComponent
extends Area2D

@export var tool: DataTypes.Tools = DataTypes.Tools.None

signal hurt

func _on_area_entered(area: Area2D) -> void:
	#Declare the hit component
	var hit_component = area as HitComponent
	#If we are using a tool, emit hurt signal with hit damage parameter from hitComponent
	if tool == hit_component.current_tool:
		hurt.emit(hit_component.hit_damage)
		
