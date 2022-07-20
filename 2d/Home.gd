extends CenterContainer

func _on_FileMenuButton_pressed():
	var _e = get_tree().change_scene("res://FileMenu.tscn")


func _on_ConfirmQuitButton_pressed():
	var _e = get_tree().change_scene("res://ConfirmQuit.tscn")


func _on_GraphButton_pressed():
	var _e = get_tree().change_scene("res://Graph.tscn")
