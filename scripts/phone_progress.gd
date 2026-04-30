extends TextureProgressBar

@onready var timer: Timer = $Timer
@onready var label: Label = $"../Label"
var playerNode : PlayerCamera
var timePressed : float
var correctTime : int
var leniencyRange : int = 10
var timeMultiplier : int = 30
var isActive : bool = false
var recording : bool = false

func _ready() -> void:
	var playerList = get_tree().get_nodes_in_group("player")
	
	if (playerList.size() > 0):
		playerNode = playerList[0]
	correctTime = value
	value = 0


func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_accept") and isActive and value > 20):
		recording = true
		timePressed = value
		modulate = Color.BLUE
	
	if (value < max_value and isActive):
		value += delta * timeMultiplier
		
		if (value >= max_value): 
			if (recording and timePressed > correctTime - leniencyRange and timePressed < correctTime + leniencyRange):
				timer.start(0.5)
			else: _restart()


func _activate(setActive : bool) -> void:
	isActive = setActive
	if (isActive): # show ui
		print("activating")
		print(get_parent())
		get_parent().visible = true
		playerNode.immobile = true
	else: # hide and delete ui
		get_parent().visible = false
		visible = false
		recording = false
		playerNode._return_movement()
		get_parent().queue_free()


func _restart() -> void:
	value = 0
	recording = false
	modulate = Color.WHITE
	label.text = "try again!"


func _on_timer_timeout() -> void:
	_activate(false)
