extends Control

enum { NO_ACTION, NEW, OPEN, SAVE, SAVE_AS, QUIT, ABOUT, SUB_MENU }

onready var file_menu = find_node("FileMenu").get_popup()
onready var file_dialog = find_node("FileDialog")
onready var about_menu = find_node("AboutMenu").get_popup()

var menu_action = NO_ACTION

var settings = { "last_dir": "", "current_file": "" }

func _ready():
	settings.last_dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var _e = file_dialog.connect("file_selected", self, "_on_FileDialog_file_selected")
	configure_menu()


func configure_menu():
	file_menu.add_item("New", NEW, KEY_MASK_CTRL | KEY_N)
	file_menu.add_item("Open", OPEN, KEY_MASK_CTRL | KEY_O)
	file_menu.add_separator()
	file_menu.add_item("Save", SAVE, KEY_MASK_CTRL | KEY_S)
	file_menu.add_item("Save As...", SAVE_AS, KEY_MASK_CTRL | KEY_MASK_SHIFT | KEY_S)
	file_menu.add_separator()
	file_menu.add_submenu_item("Sub Menu", "../SubMenu")
	file_menu.add_separator()
	file_menu.add_item("Quit", QUIT, KEY_MASK_CTRL | KEY_Q)
	file_menu.connect("id_pressed", self, "_on_FileMenu_id_pressed")

	about_menu.add_item("About", ABOUT)
	about_menu.connect("id_pressed", self, "_on_AboutMenu_id_pressed")
	
	var sub_menu = find_node("SubMenu")
	sub_menu.add_item("Submenu Item...", SUB_MENU)
	sub_menu.connect("id_pressed", self, "_on_SubMenu_id_pressed")


func _on_FileMenu_id_pressed(id):
	menu_action = id
	match id:
		NEW:
			settings.current_file = ""
			$Label.set_text("New file")
		OPEN:
			do_action()
		SAVE:
			do_action()
		SAVE_AS:
			menu_action = SAVE
			settings.current_file = ""
			do_action()
		QUIT:
			var _e = get_tree().change_scene("res://Home.tscn")


func do_action():
	match menu_action:
		OPEN:
			file_dialog.current_dir = settings.last_dir
			file_dialog.current_file = settings.current_file
			file_dialog.mode = FileDialog.MODE_OPEN_FILE
			file_dialog.popup_centered()
		SAVE:
			if settings.current_file == "":
				file_dialog.current_dir = settings.last_dir
				file_dialog.current_file = ""
				file_dialog.mode = FileDialog.MODE_SAVE_FILE
				file_dialog.popup_centered()
			else:
				save_file()
				


func _on_FileDialog_file_selected(path):
	if file_ok(path):
		settings.current_file = path.get_file()
		if menu_action == SAVE:
			save_file()
		else:
			$Label.set_text("Load file: " + settings.last_dir + "/" + settings.current_file)


func file_ok(path):
	var ok = true
	if path.rstrip("/") == path.get_base_dir():
		$Label.set_text("No filename was specified")
		ok = false
	settings.last_dir = path.get_base_dir()
	return ok


func save_file():
	$Label.set_text("Save file: " + settings.last_dir + "/" + settings.current_file)


func _on_SubMenu_id_pressed(id):
	$Label.set_text("Sub menu ID: %d pressed" % id)


func _on_AboutMenu_id_pressed(id):
	$Label.set_text("About menu ID: %d pressed" % id)
