extends Node2D


export(Resource) var test
export(Resource) var testerr
export(Resource) var call



func start():
	CoreSync.active = !CoreSync.active
	$AudioStreamPlayer.play()



func change():
	$Icon.rotation = randf()
	
	

