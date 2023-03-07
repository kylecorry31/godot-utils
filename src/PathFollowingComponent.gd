class_name PathFollowingComponent
extends Node

@export var navigation: NavigationAgent3D
@export var character: CharacterBody3D
@export var speed: float = 1.0
@export var acceleration: float = 150.0
@export var acceptance_radius: float = 1.0

signal end_reached()

var _was_at_end = false

func _ready():
	navigation.connect("velocity_computed", _on_velocity_computed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var next_location = navigation.get_next_path_position()
	var direction = get_position().direction_to(next_location)
	var new_velocity = direction * speed
	
	if is_at_end():
		if not _was_at_end:
			end_reached.emit()
			_was_at_end = true
		new_velocity = Vector3.ZERO
	
	navigation.set_velocity(character.velocity.move_toward(new_velocity, delta * acceleration))
		
func _on_velocity_computed(safe_velocity: Vector3):
	character.velocity = safe_velocity
	character.move_and_slide()

func set_destination(target: Vector3):
	if target != navigation.target_position:
		_was_at_end = false
	navigation.target_position = target

func cancel():
	set_destination(get_position())

func get_end_position() -> Vector3:
	return navigation.get_final_position()

func get_position() -> Vector3:
	return character.global_position

func distance_to_end() -> float:
	return get_position().distance_to(get_end_position())

func is_at_end() -> bool:
	return distance_to_end() <= acceptance_radius

func can_reach_destination() -> bool:
	return navigation.is_target_reachable()
