extends KinematicBody

export var mouse_sens = 0.5

onready var camera = $Camera
onready var character_mover = $CharacterMover
onready var anim = get_node("PlayerAnimationPlayer")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	character_mover.init(self)

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		queue_free()
		get_tree().change_scene("res://MainMenu.tscn")
		
	var move_vec = Vector3()
	if Input.is_action_pressed("move_forwards"):
		move_vec += Vector3.FORWARD

	if Input.is_action_pressed("move_backwards"):
		move_vec += Vector3.BACK

	if Input.is_action_pressed("move_left"):
		move_vec += Vector3.LEFT

	if Input.is_action_pressed("move_right"):
		move_vec += Vector3.RIGHT

	character_mover.set_move_vec(move_vec)
	if Input.is_action_just_pressed("jump"):
		character_mover.jump()
		
	var target_dir = Vector2(0, 0)
	if Input.is_action_pressed("move_forwards"):
		target_dir.y += 1
	if Input.is_action_pressed("move_backwards"):
		target_dir.y += 1
	if Input.is_action_pressed("move_left"):
		target_dir.x += 1
	if Input.is_action_pressed("move_right"):
		target_dir.x += 1
	
	set_anim(target_dir)
		
func set_anim(dir):
	if dir == Vector2(0, 0) and anim.current_animation != "vanya_idle":
		anim.play("vanya_idle", 0.1)
	elif dir == Vector2(0, 1) and anim.current_animation != "vanya_walk" and anim.get_playing_speed() > 0:
		anim.play("vanya_walk", 0.1)
	elif dir == Vector2(1, 1) and anim.current_animation != "vanya_walk" and anim.get_playing_speed() > 0:
		anim.play("vanya_walk", 0.1)
	elif dir == Vector2(-1, 1) and anim.current_animation != "vanya_walk" and anim.get_playing_speed() > 0:
		anim.play("vanya_walk", 0.1)
	elif dir == Vector2(1, 0) and anim.current_animation != "vanya_walk":
		anim.play("vanya_walk", 0.1)
	elif dir == Vector2(-1, 0) and anim.current_animation != "vanya_walk":
		anim.play("vanya_walk", 0.1)
	elif dir == Vector2(0, -1) and anim.current_animation != "vanya_walk" and anim.get_playing_speed() < 0:
		anim.play_backwards("vanya_walk", 0.1)
	elif dir == Vector2(1, -1) and anim.current_animation != "vanya_walk" and anim.get_playing_speed() < 0:
		anim.play_backwards("vanya_walk", 0.1)
	elif dir == Vector2(-1, -1) and anim.current_animation != "vanya_walk" and anim.get_playing_speed() < 0:
		anim.play_backwards("vanya_walk", 0.1)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= mouse_sens * event.relative.x
		camera.rotation_degrees.x -= mouse_sens * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
		
#	if(get_node("RayCast").is_colliding()):
#		var col = get_node("RayCast").get_collider()
#		print(col.name)
		

			
			
