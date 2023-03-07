class_name MapUtils

static func random_position(xMin: float, xMax: float, zMin: float, zMax: float) -> Vector3:
	return Vector3(randf_range(xMin, xMax), 0.0, randf_range(zMin, zMax))

static func random_position_around_point(center: Vector3, radius: float) -> Vector3:
	var distance = randf_range(0, radius)
	var direction = randf_range(0, 2 * PI)
	return position_around_point(center, distance, direction)
	
static func position_around_point(center: Vector3, radius: float, direction: float) -> Vector3:
	var x = radius * cos(direction)
	var z = radius * sin(direction)
	return Vector3(center.x + x, center.y, center.z + z)
	
static func nearest_position(position: Vector3, target: Vector3, radius: float = 0) -> Vector3:
	var distance = position.distance_to(target) - max(radius, 0)
	return position.move_toward(target, distance)

static func position_around_point_in_direction(center: Vector3, centerRotation: float, direction: float = 0, radius: float = 0) -> Vector3:
	var worldRotation = PI - (centerRotation - PI/2)
	return position_around_point(center, radius, worldRotation - direction)
