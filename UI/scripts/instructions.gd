extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_main_menu_starttweening() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, 25.0).from(0.0)
