extends Control
@onready var Speaker : Label = $VBoxContainer/Speaker
@onready var dialogue : RichTextLabel =  $VBoxContainer/Dialogue
@onready var _continue : Button = $Box/Continue

func display_line(line : String, speaker : String):
	Speaker.visible = (speaker != "")
	Speaker.text = speaker
	dialogue.bbcodetext = line
	open()
	_continue.grab_focus()
func open():
	visible = true
	
func close():
	visible = false

func _on_continue_pressed() -> void:
	close()
