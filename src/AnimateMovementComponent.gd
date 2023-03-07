class_name AnimateMovementComponent
extends Node

@export var character: CharacterBody3D
@export var animation: AnimationTree
@export var speed_path: String
@export var max_speed: float = 10.0

func _ready():
	animation.active = true

func _physics_process(delta):
	var actual_speed = character.velocity.length()
	animation.set(speed_path, actual_speed / max_speed)
