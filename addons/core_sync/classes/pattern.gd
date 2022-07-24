tool
extends Node

export(int, 1, 4) var compass := 4
export(Array, NodePath) var beat_1 : Array
export(Array, NodePath) var beat_2 : Array
export(Array, NodePath) var beat_3 : Array
export(Array, NodePath) var beat_4 : Array

var is_active := false
var compass_count := 0
var beats := [[], [], [], []]


func _init():
	CoreSync.connect("beat", self, "syncro")


func _ready():
	var paths = [beat_1, beat_2, beat_3, beat_4]
	for i in 4:
		for path in paths[i]:
			beats[i].append(get_node(path))


func syncro(beat : int):
	if not is_active:
		for beat in beats:
			update_rhythms(beat, false)
		return
	
	match compass:
		1: update_rhythms(beats[0], true)
		2:
			update_rhythms(beats[(beat - 1) % 2], false)
			update_rhythms(beats[beat % 2], true)
		3:
			compass_count = compass_count + 1 if compass_count < 11 else 0
			update_rhythms(beats[(compass_count -1) % 3], false)
			update_rhythms(beats[compass_count % 3], true)
		4:
			update_rhythms(beats[beat - 1], false)
			update_rhythms(beats[beat], true)


func update_rhythms(rhythms : Array, active : bool):
	for rhythm in rhythms:
		rhythm.is_active = active
