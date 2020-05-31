# Example State2

extends Node

var fsm

func enter():
	print("Hello from State2!")
	yield(get_tree().create_timer(2.0), "timeout")
	exit()

func exit():
	fsm.back()
