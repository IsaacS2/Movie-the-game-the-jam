extends Node3D

func _ready():
	# Clear the viewport.
	var viewport = $ScreenView
	$ScreenView.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)
	#
	## Let two frames pass to make sure the vieport is captured.
	#await get_tree().idle_frame
	#await get_tree().idle_frame
	
	$ScreenMesh.material_override.albedo_texture = viewport.get_texture()
