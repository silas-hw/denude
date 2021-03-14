extends HSlider

export var audio_bus_name = "sfx"

onready var _bus = AudioServer.get_bus_index(audio_bus_name)


func _ready():
	value = db2linear(AudioServer.get_bus_volume_db(_bus))
	
func _on_SFX_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
