extends Position3D

export var ROTATION_SPEED = 0.01
export var PANNING_SPEED = 0.05
export var ZOOMING_SPEED = 0.05

enum { ROTATING, PANNING, ZOOMING }

var moving = false
var amount


func _process(delta):
	delta *= 4
	var b = transform.basis
	if (Input.is_key_pressed(KEY_DOWN)):
		rotate(b.x.normalized(), delta)
	if (Input.is_key_pressed(KEY_UP)):
		rotate(b.x.normalized(), -delta)
	if (Input.is_key_pressed(KEY_RIGHT)):
		rotate(b.y.normalized(), delta)
	if (Input.is_key_pressed(KEY_LEFT)):
		rotate(b.y.normalized(), -delta)
	if (Input.is_key_pressed(KEY_Z)):
		$Camera.translation.z += delta
	if (Input.is_key_pressed(KEY_X)):
		$Camera.translation.z -= delta
	if (Input.is_key_pressed(KEY_W)):
		$Camera.translation.y -= delta
	if (Input.is_key_pressed(KEY_A)):
		$Camera.translation.x += delta
	if (Input.is_key_pressed(KEY_S)):
		$Camera.translation.y += delta
	if (Input.is_key_pressed(KEY_D)):
		$Camera.translation.x -= delta


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			moving = true
		else:
			moving = false
	if event is InputEventMouseMotion and moving:
		var mode = ROTATING
		if Input.is_key_pressed(KEY_CONTROL):
			mode = ZOOMING
		match mode:
			ROTATING:
				var b = transform.basis
				rotate(b.x.normalized(), event.relative.y * ROTATION_SPEED)
				rotate(b.y.normalized(), event.relative.x * ROTATION_SPEED)
			ZOOMING:
				$Camera.translation.z += event.relative.y * ZOOMING_SPEED
