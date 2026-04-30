class_name HackingSpace

extends Area3D

@export var hackable : Node
@export var destructible : Node3D


func _start_hack() -> void:
	if (hackable and hackable != null): hackable._activate(true)


func _exit_tree() -> void:
	if (destructible): destructible.queue_free()
