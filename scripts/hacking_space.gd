class_name HackingSpace

extends Area3D

@export var hackable : Node


func _start_hack() -> void:
	if (hackable): hackable._activate(true)
