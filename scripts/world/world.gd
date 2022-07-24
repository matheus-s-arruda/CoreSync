extends Node2D




func _process(_delta):
	$CanvasLayer/Label.text = str(CoreSync.tick)
	$CanvasLayer/Label2.text = str(CoreSync.step)
	$CanvasLayer/Label3.text = str(CoreSync.beat)


func start():
	CoreSync.active = !CoreSync.active
	if CoreSync.active: $AudioStreamPlayer.play()
	else: $AudioStreamPlayer.stop()


func move():
	$Icon.position = Vector2(450, 370) + (Vector2(randf() - 0.5, randf() - 0.5) * 50)
	$Icon.rotation = (randf() - 0.5) * PI
	$Icon.scale = Vector2(0.75, 0.75) + Vector2(randf() - 0.5, randf() - 0.5)

