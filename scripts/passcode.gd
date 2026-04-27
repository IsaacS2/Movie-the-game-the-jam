extends Label

@onready var timer: Timer = $Timer
@export var passcodeString : String

var playerNode : PlayerCamera
var currentStringCount : int = 0
var isActive : bool = false

func _ready() -> void:
	var playerList = get_tree().get_nodes_in_group("player")
	
	if (playerList.size() > 0):
		playerNode = playerList[0]


func _input(event: InputEvent) -> void:
	if (event is InputEventKey and isActive):
		if (currentStringCount < passcodeString.length()):
			currentStringCount += 1
			print("key process")
			text = passcodeString.substr(0, currentStringCount)
			
			if (text.length() >= passcodeString.length()):
				timer.start(0.5)

func _activate(setActive : bool) -> void:
	isActive = setActive
	if (isActive): 
		print("activating")
		text = ""
		print(get_parent())
		get_parent().visible = true
		playerNode.immobile = true
	else: 
		get_parent().visible = false
		playerNode._return_movement()
		get_parent().queue_free()


func _on_timer_timeout() -> void:
	_activate(false)
