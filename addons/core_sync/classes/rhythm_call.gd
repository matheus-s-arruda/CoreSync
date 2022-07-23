tool
class_name RhythmCall extends Resource

var node_path : NodePath
var call : String = "set"
var args := []


func _init():
	resource_local_to_scene = true


func execute():
	get_local_scene().get_node(node_path).callv(call, args)


func _get_property_list():
	return [
		{
			"name" : "call",
			"type" : TYPE_STRING,
		},
		{
			"name" : "args",
			"type" : TYPE_ARRAY,
		},
		{
			"name" : "node_path",
			"type" : TYPE_NODE_PATH
		},
	]
