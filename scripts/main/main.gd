extends Control



export(Resource) var rhythm


func _process(_delta):
	$Label.text = str(CoreSync.tick)
	$Label2.text = str(CoreSync.step)
	$Label3.text = str(CoreSync.beat)



func _on_Button_pressed():
	CoreSync.active = !CoreSync.active
#	$AudioStreamPlayer3.play()


