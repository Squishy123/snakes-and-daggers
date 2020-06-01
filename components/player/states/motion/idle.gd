extends Node

var fsm: Node = null

export (int) var jump_speed = -1000
export (int) var gravity = 2300

func enter():
	fsm.sprites.animation = "idle"


func handle_movement(delta):
	if Input.is_action_pressed("ui_up"):
		if get_node('../../').is_on_floor():
			fsm.change_to("jump")
		

func physics_process(delta):
	handle_movement(delta)
	fsm.velocity.y += gravity * delta
	fsm.velocity = get_node('../../').move_and_slide(fsm.velocity, Vector2.UP)
