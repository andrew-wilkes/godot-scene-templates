extends Control

onready var graph = $GraphEdit
onready var gnode = $GraphNode

export var SPAWN_STEP = Vector2(20, 20)
var spawn_offset = SPAWN_STEP
var selected_nodes = {}

func _ready():
	# Add buttons to the menu box
	# We save a bit of code here for node relocation
	graph.get_zoom_hbox().add_child($AddButton.duplicate())
	$AddButton.queue_free()
	graph.get_zoom_hbox().add_child($HomeButton.duplicate())
	$HomeButton.queue_free()
	gnode.offset = Vector2(100, 100)
	graph.add_child(gnode.duplicate())
	gnode.hide()


func _on_AddButton_pressed():
	var node = gnode.duplicate()
	node.show()
	node.offset += spawn_offset
	spawn_offset += SPAWN_STEP
	graph.add_child(node)


# There is a documentation bug here where "slot" should say "port" since ports are indexes of active slots
func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	graph.connect_node(from, from_slot, to, to_slot)


func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	graph.disconnect_node(from, from_slot, to, to_slot)


func _on_GraphEdit_node_selected(node):
	selected_nodes[node] = true


func _on_GraphEdit_node_unselected(node):
	selected_nodes[node] = false


func _on_GraphEdit_delete_nodes_request(_nodes):
	# This list of _nodes is not relevant in our case
	# It is indicating what nodes have cancel boxes checked
	if selected_nodes.size() > 0:
		# Want to keep our original model of the node.
		# Normally we would implement a generator.
		# We don't need to iterate over keys here since it is done by default with Dictionaries
		for node in selected_nodes: 
			if selected_nodes[node]:
				remove_connections_to_node(node)
				node.queue_free()
	selected_nodes = {}


func remove_connections_to_node(node):
	for con in graph.get_connection_list():
		if con.to == node.name or con.from == node.name:
			graph.disconnect_node(con.from, con.from_port, con.to, con.to_port)
	

func _on_HomeButton_pressed():
	var _e = get_tree().change_scene("res://Home.tscn")
