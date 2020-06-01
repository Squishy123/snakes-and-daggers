extends Node

signal state_changed(current_state)

const DEBUG = true

export(NodePath) var INITIAL_STATE

var current_state: Node

var history = [] 

# Set the initial state to the first child node
func _ready():
	current_state = get_node(INITIAL_STATE)
	_enter_state()

# Set the current state to a new state
func change_to(new_state):
	history.append(current_state.name)
	current_state = get_node(new_state)
	emit_signal("state_changed", current_state)
	_enter_state()

# Return to the previous state
func back():
	if history.size() > 0:
		current_state = get_node(history.pop_back())
		emit_signal("state_changed", current_state)
		_enter_state()

# Enter the current state
func _enter_state():
		current_state.fsm = self # Give the state a reference to this state machine script
		current_state.enter()

# Route game loop function calls to current state handler method if it exists 
func _process(delta):
	if current_state.has_method("process"):
		current_state.process(delta)

func _physics_process(delta):
	if current_state.has_method("physics_process"):
		current_state.physics_process(delta)

func _input(event):
	if current_state.has_method("input"):
		current_state.input(event)

func _unhandled_input(event):
	if current_state.has_method("unhandled_input"):
		current_state.unhandled_input(event)

func _unhandled_key_input(event):
	if current_state.has_method("unhandled_key_input"): 
		current_state.unhandled_key_input(event)

func _notification(what):
	if current_state && current_state.has_method("notification"):
		current_state.notification(what)

func on_state_changed(changed_state):
	if DEBUG:
		print("<DEBUG> STATE CHANGED: ", changed_state.name, " </DEBUG>")
