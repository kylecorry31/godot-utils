class_name FaceForwardComponent
extends Node

@export var character: CharacterBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Look in the direction of motion
	# TODO: Make this smooth
	var global_position = character.global_position
	var velocity = character.velocity
	if velocity.is_zero_approx():
		return
	var look_position = Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z)
	character.look_at(look_position, Vector3.UP)
