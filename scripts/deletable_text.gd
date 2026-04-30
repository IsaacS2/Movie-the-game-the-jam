extends Label

@onready var timer: Timer = $Timer


var playerNode : PlayerCamera
var startingString : String
var currentStringCount : int
var isActive : bool = false

func _ready() -> void:
	var playerList = get_tree().get_nodes_in_group("player")
	startingString = text
	
	if (playerList.size() > 0):
		playerNode = playerList[0]
		
	currentStringCount = text.length()


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("ui_text_backspace") and isActive):
		if (currentStringCount > 0):
			currentStringCount -= 1
			print("currentstringlength: " + str(currentStringCount))
			print("key process")
			text = startingString.substr(0, currentStringCount)
			
			if (text.length() <= 0):
				timer.start(0.5)


func _activate(setActive : bool) -> void:
	isActive = setActive
	if (isActive): 
		print("activating")
		print(get_parent())
		get_parent().visible = true
		playerNode.immobile = true
	else: 
		get_parent().visible = false
		visible = false
		playerNode._return_movement()
		get_parent().queue_free()


func _on_timer_timeout() -> void:
	_activate(false)
