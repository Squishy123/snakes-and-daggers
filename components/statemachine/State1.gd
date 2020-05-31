# Example State1

extends Node

var fsm 

func enter():
	print("Hello from State 1!")
	yield(get_tree().create_timer(2.0), "timeout")
	exit("State2")

func exit(next_state):
	fsm.change_to(next_state)

# Optional game loop handlers
func process(delta):
	return delta

func physics_process(delta):
	return delta

func input(event):
	return event

func unhandled_input(event):
	return event

func unhandled_key_input(event):
	return event

func notification(what, flag = false):
	return [what, flag]
