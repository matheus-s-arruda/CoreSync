tool
extends PanelContainer

const ITEM = preload("res://addons/core_sync/dock/event_iten.tscn")

var current_rhytm
onready var pattern = get_parent()
onready var body = $VBoxContainer/ScrollContainer/body


func load_rhytm(rhytm : Rhythm):
	current_rhytm = rhytm
	
	for c in body.get_children():
		c.queue_free()
	
	for call in rhytm.calls:
		create(call, call.call)
	
	visible = true


func close():
	current_rhytm = null
	visible = false
	for c in body.get_children():
		c.queue_free()


func create(call : RhythmCall, _name : String):
	var item = ITEM.instance()
	body.add_child(item)
	
	var edit = item.get_node("edit")
	edit.connect("pressed", self, "edit_call", [edit, call])
	edit.text = _name
	item.get_node("remove")


func edit_call(item : Button, call : RhythmCall):
	item.text = call.call
	pattern.get_parent().editor_interface.edit_resource(call)


func _on_add_event_pressed():
	if current_rhytm:
		var call = RhythmCall.new()
		current_rhytm.calls.append(call)
		create(call, "set")


func _on_close_pressed():
	close()

