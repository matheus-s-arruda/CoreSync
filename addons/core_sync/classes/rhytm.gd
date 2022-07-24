tool
extends Node


export var row := [
	false, false, false, false, false, false, false, false,
	false, false, false, false, false, false, false, false ] setget _rows

var is_active := false
onready var events := get_children()


func _init():
	CoreSync.connect("step", self, "syncro")


func syncro(step):
	if not is_active: return
	
	if row[step]:
		for call in events:
			call.execute()


func _rows(new_array : Array):
	if new_array.size() != 16: return
	row = new_array
