extends Spatial

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		queue_free()
