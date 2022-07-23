tool
extends HBoxContainer

var focus : Pattern setget _handle_active

onready var rows = $rows
onready var edit_event = $edit_event


func edit_rhytm(rhytm : Rhythm):
	edit_event.load_rhytm(rhytm)


func remove_rhytm(rhytm : Rhythm, beat : int):
	edit_event.close()
	
	var idx = focus.beats[beat].find(rhytm)
	if idx != -1:
		focus.beats[beat].remove(idx)


func _handle_active(value : Pattern):
	if not value:
		edit_event.close()
		
		if focus:
			rows.reset(focus)
			focus = null
	
	elif value != focus:
		if focus:
			rows.reset(focus)
			
		focus = value
		rows.load_pattern(focus)


