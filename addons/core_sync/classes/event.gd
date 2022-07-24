tool
extends Node

export(NodePath) onready var node = get_node(node)
export var call : String = "set"
export var args := []


func execute():
	node.callv(call, args)
