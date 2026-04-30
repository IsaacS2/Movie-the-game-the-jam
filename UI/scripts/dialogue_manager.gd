extends CanvasLayer
@onready var dialogue_box: Control = $DialogueBox
@onready var dialogue_text: RichTextLabel = $DialogueBox/DialogueText


var dialogue_lines: Array[String] = []
var current_line_index: int = 0
var is_dialogue_active: bool = false

func _ready() -> void:
	dialogue_box.visible = false
	
	start_dialogue(["Freezing the game... ",
							"And unfreezing it now"])


func start_dialogue(lines : Array[String]):
	#Pause the game so the player can't move
	get_tree().paused = true
	dialogue_lines = lines
	current_line_index = 0
	is_dialogue_active = true
	dialogue_box.visible = true
	dialogue_text.text = dialogue_lines[current_line_index]
	
	
func _input(event):
	if not is_dialogue_active:
		return
	if event.is_action_pressed("ui_accept"):
		advance_dialogue()

func advance_dialogue():
	if current_line_index < dialogue_lines.size() -1:
		current_line_index +=1
		dialogue_text.text = dialogue_lines[current_line_index]
	else:
		#unpasue the game when done
		get_tree().paused = false
		
		is_dialogue_active = false
		dialogue_box.visible = false
