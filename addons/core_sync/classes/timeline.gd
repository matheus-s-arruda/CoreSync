tool
extends Node


export(Array, NodePath) var track : Array

var pointer_pattern := -1
var pattern_size := 0
var patterns : Array


func _init():
	CoreSync.connect("pattern", self, "syncro")


func _ready():
	for path in track:
		patterns.append( get_node(path) )
		pattern_size += 1


func syncro(_pattern):
	pointer_pattern = (pointer_pattern + 1) % pattern_size
	patterns[pointer_pattern - 1].is_active = false
	patterns[pointer_pattern].is_active = true


