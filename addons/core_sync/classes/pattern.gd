tool
class_name Pattern extends Resource

signal update_compass(compass)

var compass : int = 4 setget _update_compass

var beat_1 := []
var beat_2 := []
var beat_3 := []
var beat_4 := []
var beats := [beat_1, beat_2, beat_3, beat_4]

var is_active := false


func _init():
	resource_local_to_scene = true
	CoreSync.connect("beat", self, "syncro")


func syncro(beat):
	if not is_active: return
	
	print(beat_1)
	
	for rtm in beats[(beat + 3) % 4]:
		rtm.is_active = false
	
	for rtm in beats[beat]:
		rtm.is_active = true


func update_rhythms(rhythms : Array, active : bool):
	for rhythm in rhythms:
		rhythm.is_active = active


func _update_compass(value : int):
	compass = clamp(value, 1, 4)
	emit_signal("update_compass", compass)


func _get_property_list():
	return [
		{
			"name" : "compass",
			"type" : TYPE_INT,
		},
		{
			"name" : "beat_1",
			"type" : TYPE_ARRAY,
		},
		{
			"name" : "beat_2",
			"type" : TYPE_ARRAY,
		},
		{
			"name" : "beat_3",
			"type" : TYPE_ARRAY,
		},
		{
			"name" : "beat_4",
			"type" : TYPE_ARRAY,
		},
	]
