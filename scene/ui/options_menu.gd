extends CanvasLayer

@onready var window_mode_button = %WindowModeButton
@onready var sfx_slider = %SFXSlider
@onready var music_slider = %MusicSlider


func _ready():
	update_optioins()

func update_optioins():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_mode_button.text = "Fullscreen"
	else:
		window_mode_button.text = "Windowed"
		
	sfx_slider.value = get_volume_percent(2)
	music_slider.value = get_volume_percent(1)

func get_volume_percent(bus_index: int):
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)

func _on_window_mode_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	update_optioins()

func _on_back_button_pressed():
	queue_free()


func _on_sfx_slider_value_changed(value):
	var volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(2, volume_db)


func _on_music_slider_value_changed(value):
	var volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(1, volume_db)
