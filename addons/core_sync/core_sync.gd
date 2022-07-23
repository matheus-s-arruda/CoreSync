tool
extends EditorPlugin

const DOCK = preload("res://addons/core_sync/dock/dock.tscn")

var dock

var editor_interface


func handles(object):
	if object is Timeline:
		return true
	
	elif object is Node:
		if dock:
			dock.timeline = null
			hide_bottom_panel()
	
	return false


func edit(object):
	if object is Timeline:
		dock.timeline = object
		make_bottom_panel_item_visible(dock)


func _enter_tree():
	dock = DOCK.instance()
	editor_interface = get_editor_interface()
	dock.editor_interface = editor_interface
	
	add_control_to_bottom_panel(dock, "Row")


func _exit_tree():
	if dock:
		remove_control_from_bottom_panel(dock)
		dock.free()
		dock = null




