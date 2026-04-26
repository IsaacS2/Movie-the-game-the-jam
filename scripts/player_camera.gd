class_name PlayerCamera

extends Camera3D

enum FACING {EAST, NORTH, WEST, SOUTH}

@onready var playerArea: Area3D = $PlayerArea
@onready var label: Label = $Label
@export var facility : GridMap
var hackArea : HackingSpace
var cameraHeight : Vector3
var movingDirection : Vector3
var movingInput : int
var turningDirection : int
var currentRotation = FACING.EAST
var immobile : bool = false
var canHack : bool = false
var checkArea : bool = false

func _ready() -> void:
	cameraHeight = Vector3.UP * .5
	_turn_to_direction(currentRotation)
	if (facility):
		position = facility.map_to_local(Vector3i(0,0,0)) + cameraHeight


func _process(_delta: float) -> void:
	if (!immobile):
		if (canHack):
			hackArea._start_hack()
		
		movingInput = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
		turningDirection = int(Input.is_action_just_pressed("ui_left")) - int(Input.is_action_just_pressed("ui_right"))
		
		if (movingInput != 0):
			var desiredSpace : Vector3 = facility.local_to_map(position) # get map position
			desiredSpace += movingInput * movingDirection
			
			var cellCheck : int = facility.get_cell_item(desiredSpace) # check new map cell
			desiredSpace = facility.map_to_local(desiredSpace) # get local position
			
			if (facility and cellCheck > -1): # and check that player's not going through wall):
				position = desiredSpace + cameraHeight + Vector3(0, 0, 0)
				checkArea = true
		
		elif (turningDirection != 0):
			currentRotation += turningDirection
			# full clockwise rotation, return to facing east
			if (currentRotation > FACING.SOUTH):
				currentRotation = FACING.EAST
			# counter-clockwise rotation, face south
			if (currentRotation < FACING.EAST):
				currentRotation = FACING.SOUTH
			
			_turn_to_direction(currentRotation)
		
		movingInput = 0
		turningDirection = 0


func _physics_process(delta: float) -> void:
	if (checkArea):
		_check_for_areas()


func _turn_to_direction(newDirection : FACING) -> void:
	currentRotation = newDirection
	
	match currentRotation:
		FACING.EAST:
			movingDirection = Vector3(0, 0, 1)
		FACING.NORTH:
			movingDirection = Vector3(1, 0, 0)
		FACING.WEST:
			movingDirection = Vector3(0, 0, -1)
		FACING.SOUTH:
			movingDirection = Vector3(-1, 0, 0)
	
	print(currentRotation)
	
	transform.basis = Basis()
	transform.basis = Basis(Vector3.UP, (PI * currentRotation) / 2) * transform.basis


func _check_for_areas() -> void:
	if (playerArea.has_overlapping_areas()):
		var area = playerArea.get_overlapping_areas()[0]
		if (area is HackingSpace):
			hackArea = area
			canHack = true
			label.visible = true
			return
	
	canHack = false
	label.visible = false
