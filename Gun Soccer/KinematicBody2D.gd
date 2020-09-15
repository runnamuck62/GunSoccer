extends KinematicBody2D

var speed = 400
var motion = Vector2()
var bullet = preload("res://bullet.tscn")
var bullet1_speed = 1000
var bullet2_speed = 2000
var fire_rate = .05
var can_fire = true

func _process(delta):
	look_at(get_global_mouse_position())
	
	if can_fire:
		if Input.is_action_pressed('fire'):
			var bullet_instance = bullet.instance()
			bullet_instance.position = $BulletPoint.get_global_position()
			bullet_instance.rotation_degrees = rotation_degrees
			bullet_instance.apply_central_impulse(Vector2(bullet1_speed,0).rotated(rotation + rand_range(-.1,.1)))
			get_tree().get_root().add_child(bullet_instance)
			can_fire = false
			yield(get_tree().create_timer(fire_rate),"timeout")
			can_fire = true
		if Input.is_action_just_pressed('fire2'):
			var bullet_instance = bullet.instance()
			bullet_instance.position = $BulletPoint.get_global_position()
			bullet_instance.rotation_degrees = rotation_degrees
			bullet_instance.weight = 30
			bullet_instance.apply_central_impulse(Vector2(bullet2_speed,0).rotated(rotation))
			get_tree().get_root().add_child(bullet_instance)
		
			

func _physics_process(delta):
	motion.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	motion.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	motion = motion.normalized()
	motion = move_and_slide(motion * speed)
