tool
extends PanelContainer

signal edit_calls(calls)
signal remove_rhytm(rhytm)

var rhytm : Resource

onready var r_name : LineEdit = $HBoxContainer/name


func rhytm_update(_rhytm : Rhythm):
	r_name.text = _rhytm.self_name
	rhytm = _rhytm
	
	for step in 16:
		var node : String = "HBoxContainer/steps/Panel/HBoxContainer/step_" + str(step + 1)
		get_node(node).pressed = rhytm.row[step]


func _on_remove_pressed():
	emit_signal("remove_rhytm", rhytm)
	queue_free()


func _on_step_toggled(is_active : bool, step : int):
	rhytm.row[step] = is_active


func _on_name_text_entered(new_text):
	r_name.text = new_text


func _on_calls_pressed():
	emit_signal("edit_calls", rhytm)


