extends Node

signal step(step)
signal beat(beat)
signal pattern(pattern)

const BPM := 204
const BPM_MS := float(60_000) / float(BPM) / 4
const MAX_STEP = 15 # 16 steps, de 0 a 15

var tick : int = 1
var step : int = -1
var beat : int = -1
var pattern : int = -1
var active := false setget _update_core
var _time_fit := 0


func _ready():
	set_process(false)


func _process(_delta):
	var t = OS.get_ticks_msec() - _time_fit
	var _tick = int( float(t) / BPM_MS)
	
	if _tick != tick:
		tick = _tick
		step = step + 1 if step < MAX_STEP else 0
		
		if not step:
			beat = beat + 1 if beat < 3 else 0
			
			if not beat:
				pattern = pattern + 1 if pattern < 3 else 0
				
				emit_signal("pattern", pattern)
			emit_signal("beat", beat)
		emit_signal("step", step)


func _update_core(value : bool):
	active = value
	set_process(active)
	if active:
		step = -1
		beat = -1
		pattern = -1
		_time_fit = OS.get_ticks_msec() - AudioServer.get_time_to_next_mix()
