extends Position3D

export var ROTATION_SPEED = 0.01
export var PANNING_SPEED = 0.05
export var ZOOMING_SPEED = 0.05

enum { ROTATING, PANNING, ZOOMING }

var moving = false

func _process(delta):
	if (Input.is_key_pressed(KEY_DOWN)):
		$XAxis.rotate_x(delta)
	if (Input.is_key_pressed(KEY_UP)):
		$XAxis.rotate_x(-delta)
	if (Input.is_key_pressed(KEY_RIGHT)):
		$XAxis/YAxis.rotate_y(delta)
	if (Input.is_key_pressed(KEY_LEFT)):
		$XAxis/YAxis.rotate_y(-delta)
	if (Input.is_key_pressed(KEY_Z)):
		$XAxis/YAxis/Camera.translation.z += delta
	if (Input.is_key_pressed(KEY_X)):
		$XAxis/YAxis/Camera.translation.z -= delta
	if (Input.is_key_pressed(KEY_W)):
		$XAxis/YAxis/Camera.translation.y -= delta
	if (Input.is_key_pressed(KEY_A)):
		$XAxis/YAxis/Camera.translation.x += delta
	if (Input.is_key_pressed(KEY_S)):
		$XAxis/YAxis/Camera.translation.y += delta
	if (Input.is_key_pressed(KEY_D)):
		$XAxis/YAxis/Camera.translation.x -= delta

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			moving = true
		else:
			moving = false
	if event is InputEventMouseMotion and moving:
		var mode = ROTATING
		if Input.is_key_pressed(KEY_SHIFT):
			mode = PANNING
		if Input.is_key_pressed(KEY_CONTROL):
			mode = ZOOMING
		match mode:
			PANNING:
				$XAxis/YAxis/Camera.translation.x += event.relative.x * PANNING_SPEED
				$XAxis/YAxis/Camera.translation.y += event.relative.y * PANNING_SPEED
			ROTATING:
				$XAxis.rotate_x(event.relative.y * ROTATION_SPEED)
				$XAxis/YAxis.rotate_y(event.relative.x * ROTATION_SPEED)
			ZOOMING:
				$XAxis/YAxis/Camera.translation.z += event.relative.y * ZOOMING_SPEED