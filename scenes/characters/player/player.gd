class_name Player
extends CharacterBody2D

var player_direction: Vector2

#Comes from Datatypes class and sets "None" as default tool.
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@onready var hit_component: HitComponent = $HitComponent


func _ready() -> void:
	ToolManager.tool_selected.connect(equip_tool)

func equip_tool(tool: DataTypes.Tools) -> void:
	current_tool = tool
	hit_component.current_tool = tool 
