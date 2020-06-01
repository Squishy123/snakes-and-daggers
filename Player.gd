extends KinematicBody2D

export (int) var speed = 500
export (int) var jump_speed = -1000
export (int) var gravity = 2300

export (float, 0, 1.0) var friction = 0.35
export (float, 0, 1.0) var acceleration = 0.75

var velocity = Vector2()
var hDir = 0
var vDir = 0

func handle_movement(delta):
	hDir = 0
	if Input.is_action_pressed("ui_right"):
		hDir = 1
	if Input.is_action_pressed("ui_left"):
		hDir = -1
	
	# Friction/acceleration
	if hDir != 0:
		velocity.x = lerp(velocity.x, hDir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed
			vDir = 1
	
	if velocity.y == 0:
		vDir = 0
	
	# Animation
	if vDir == 0:
		if hDir == 0:
			$AnimatedSprite.animation = "idle"
		else:
			$AnimatedSprite.animation = "walk"
	else: 
		if vDir == 1:
			$AnimatedSprite.animation = "jump"
		elif vDir == -1:
			if $AnimatedSprite.animation != "double_jump":
				$AnimatedSprite.animation = "double_jump"
			

func _physics_process(delta):
	handle_movement(delta)

