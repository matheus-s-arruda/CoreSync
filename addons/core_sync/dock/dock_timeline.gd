tool
extends HBoxContainer

const ITEM = preload("res://addons/core_sync/dock/event_iten.tscn")

onready var dock = get_parent()
onready var list = $row_edit/ScrollContainer/row_edit/body
onready var btn_create = $row_edit/ScrollContainer/row_edit/create


func reset():
	btn_create.disabled = true
	for c in list.get_children():
		c.queue_free()


func load_patterns():
	btn_create.disabled = false
	for p in dock.timeline.patterns:
		create_btn(p)


func create_btn(pattern):
	var item = ITEM.instance()
	var edit = item.get_node("edit")
	var remove = item.get_node("remove")
	
	list.add_child(item)
	edit.text = "pattern " + str(list.get_child_count())
	edit.connect("pressed", dock, "change_pattern_focus", [pattern])
	remove.connect("pressed", dock, "remove_pattern", [pattern])


func _on_create_pattern_pressed():
	var p = Pattern.new()
	dock.timeline.patterns.append(p)
	create_btn(p)
	
