extends Node

export (int) var jump_speed = -1000
export (int) var gravity = 2300

var fsm


func enter():
	fsm.sprites.animation = "jump"
	fsm.velocity.y = jump_speed
	exit()


func exit():
	fsm.back()
