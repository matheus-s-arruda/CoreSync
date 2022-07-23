tool
extends VBoxContainer


var timeline : Timeline setget _handle_activity
var editor_interface


onready var pattern = $pattern
onready var timeline_node = $timeline


func change_pattern_focus(p : Pattern):
	pattern.focus = p
	pattern.edit_event.close()


func remove_pattern(p : Pattern):
	var idx = timeline.patterns.find(p)
	
	if idx != -1:
		if pattern.focus == p:
			pattern.focus = null
		timeline.patterns.remove(idx)
		
		timeline_node.reset()
		timeline_node.load_patterns()


func _handle_activity(value):
	timeline_node.reset()
	pattern.focus = null
	
	timeline = value
	if value:
		timeline_node.load_patterns()




