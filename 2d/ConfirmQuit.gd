extends Control

var saved = false

func _ready():
	# The following may also be done via Project settings (application/project/auto_accept_quit)
	get_tree().set_auto_accept_quit(false)


func _on_QuitButton_pressed():
	try_to_quit()


func _unhandled_input(event): # Or use: func _unhandled_key_input(event) maybe?
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			try_to_quit()


# Listen for notification of quit request such as after user clicked on x of window
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		try_to_quit()


func try_to_quit():
	if saved:
		quit()
	else:
		$ConfirmationDialog.popup_centered()


func _on_ConfirmationDialog_confirmed():
	quit()


func quit():
	# Usually we write: get_tree().quit() instead of the following code
	get_tree().set_auto_accept_quit(true)
	var _e = get_tree().change_scene("res://Home.tscn")
