class_name PlayerCamera

extends Camera3D

enum FACING {EAST, NORTH, WEST, SOUTH}

@export var facility : GridMap
var cameraHeight : Vector3
var movingDirection : Vector3
var movingInput : int
var turningDirection : int
var currentRotation = FACING.EAST


func _ready() -> void:
	cameraHeight = Vector3.UP * .5
	_turn_to_direction(currentRotation)
	if (facility):
		position = facility.map_to_local(Vector3i(0,0,0)) + cameraHeight


func _process(delta: float) -> void:
	movingInput = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	turningDirection = int(Input.is_action_just_pressed("ui_left")) - int(Input.is_action_just_pressed("ui_right"))
	
	if (movingInput != 0):
		var desiredSpace : Vector3 = facility.local_to_map(position)
		#print(desiredSpace)
		#print(movingInput)
		desiredSpace += movingInput * movingDirection
		#print(desiredSpace)
		
		var cellCheck : int = facility.get_cell_item(desiredSpace)
		desiredSpace = facility.map_to_local(desiredSpace)
		#print(desiredSpace)
		
		if (facility and cellCheck > -1): # and check that player's not going through wall):
			position = desiredSpace + cameraHeight + Vector3(0, 0, 0)
			#print(position)
	
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
	 
