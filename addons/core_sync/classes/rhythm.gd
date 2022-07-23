tool
class_name Rhythm extends Resource

var calls : Array setget _update_callss
var row := [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]

var self_name : String = "Rhytm"
var is_active := false


func _init():
	resource_local_to_scene = true


func syncro(step):
	if not is_active: return
	print("XXXXX")
	
	if row[step]:
		for call in calls:
			call.execute()


func _update_callss(new_array : Array):
	var new_element = calls.size() < new_array.size()
	calls = new_array
	
	if new_element:
		calls[-1] = RhythmCall.new()


func _get_property_list():
	return [
		{
			"name" : "calls",
			"type" : TYPE_ARRAY,
		},
		{
			"name" : "row",
			"type" : TYPE_ARRAY,
		},
		{
			"name" : "self_name",
			"type" : TYPE_STRING,
		},
	]
