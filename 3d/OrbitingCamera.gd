extends Position3D

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
