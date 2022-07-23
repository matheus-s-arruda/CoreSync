tool
class_name Timeline extends Node


var patterns : Array setget _update_patterns
var pointer_pattern := -1


func _init():
	CoreSync.connect("pattern", self, "syncro")


func syncro(_pattern):
	if pointer_pattern >= 0: 
		patterns[pointer_pattern].is_active = false
	
	pointer_pattern += 1
	if patterns.size() >= pointer_pattern:
		 pointer_pattern = 0
	
	patterns[pointer_pattern].is_active = true


func _update_patterns(new_array: Array):
	var new_element = patterns.size() < new_array.size()
	patterns = new_array
	
	if new_element:
		patterns[-1] = Pattern.new()


func _get_property_list():
	return [
		{
			"name" : "patterns",
			"type" : TYPE_ARRAY,
		},
	]
