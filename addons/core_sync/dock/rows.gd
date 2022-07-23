tool
extends VBoxContainer

const RTM_ROW = preload("res://addons/core_sync/dock/rhytm_row.tscn")

var current_beat := 0

onready var dock = get_parent()
onready var beat_layers := [
	$PanelContainer/MarginContainer/beat_1,
	$PanelContainer/MarginContainer/beat_2,
	$PanelContainer/MarginContainer/beat_3,
	$PanelContainer/MarginContainer/beat_4,
]
onready var bodies := [
	$PanelContainer/MarginContainer/beat_1/body,
	$PanelContainer/MarginContainer/beat_2/body,
	$PanelContainer/MarginContainer/beat_3/body,
	$PanelContainer/MarginContainer/beat_4/body
]
onready var panel = $PanelContainer
onready var btn_add_rhytm := $top/beats/add_rhytm
onready var btn_beat := [$top/beats/beat_1, $top/beats/beat_2, $top/beats/beat_3, $top/beats/beat_4]
onready var p_name := $top/name


func reset(pattern : Pattern):
	btn_add_rhytm.disabled = true
	panel.visible = false
	
	if pattern and pattern.is_connected("update_compass", self, "_compass_update"):
		pattern.disconnect("update_compass", self, "_compass_update")
	
	for btn in btn_beat:
		btn.disabled = true
	
	for b in bodies:
		for c in b.get_children():
			c.queue_free()


func load_pattern(pattern : Pattern):
	btn_add_rhytm.disabled = false
	btn_beat[0].disabled = false
	btn_beat[0].pressed = true
	beat_layers[0].visible = true
	panel.visible = true
	
	var idx = dock.get_parent().timeline.patterns.find(pattern)
	p_name.text = "Pattern_" + str(idx + 1)
	
	pattern.connect("update_compass", self, "_compass_update")
	_compass_update(pattern.compass)
	
	for beat in 4:
		for c in bodies[beat].get_children():
			c.queue_free()
	
	for beat in 4:
		var beat_row = pattern.beats[beat]
		for rhytm in beat_row:
			new_rhytm(rhytm, beat)


func new_rhytm(rhytm : Rhythm, beat : int):
	var rhytm_row = RTM_ROW.instance()
	bodies[beat].add_child(rhytm_row)
	
	rhytm_row.connect("edit_calls", dock, "edit_rhytm")
	rhytm_row.connect("remove_rhytm", dock, "remove_rhytm", [beat])
	rhytm_row.rhytm_update(rhytm)


func _on_add_rhytm_pressed():
	if dock.focus:
		var rhytm = Rhythm.new()
		dock.focus.beats[current_beat].append(rhytm)
		new_rhytm(rhytm, current_beat)


func _on_beat_pressed(beat):
	current_beat = beat
	for i in 4:
		if i == beat: beat_layers[i].visible = true
		else:
			beat_layers[i].visible = false
			btn_beat[i].pressed = false


func _compass_update(compass : int):
	for i in 4: btn_beat[i].disabled = i >= compass


