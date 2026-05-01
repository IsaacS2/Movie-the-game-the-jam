extends Node2D

signal starttweening

func _ready() -> void:
	$CenterContainer/SettingsMenu/fullscreen.button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else false
	$CenterContainer/SettingsMenu/mainvolslider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_level.tscn")


func _on_extras_pressed() -> void:
	$CenterContainer/MainButtons.visible = false
	$Title.visible = false
	$Gallery.visible = true



func _on_help_pressed() -> void:
	$CenterContainer/MainButtons.visible = false
	$Title.visible = false
	$Instructions.visible = true
	$Instructions/TweenTextTrigger.visible = true
	


func _on_settings_pressed() -> void:
	$CenterContainer/MainButtons.visible = false
	$CenterContainer/SettingsMenu.visible = true


func _on_back_pressed() -> void:
	$CenterContainer/MainButtons.visible = true
	$CenterContainer/SettingsMenu.visible = false


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_mainvolslider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)


func _on_tween_text_trigger_screen_entered() -> void:
	starttweening.emit()


func _on_starttweening() -> void:
	pass # Replace with function body.




func _on_back_that_bring_title_pressed() -> void:
	$CenterContainer/MainButtons.visible = true
	$Title.visible = true
	$Instructions.visible = false
	$Instructions/TweenTextTrigger.visible = false
	$Gallery.visible = false
	
func _on_trailer_pressed() -> void:
	OS.shell_open("https://www.youtube.com/watch?v=Te0-HgJzyw8")
