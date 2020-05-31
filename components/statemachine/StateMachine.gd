extends Node

const DEBUG = true

export(NodePath) var INITIAL_STATE

var state: Node

var history = [] 

# Set the initial state to the first child node
func _ready():
	state = get_node(INITIAL_STATE)
	_enter_state()

# Set the current state to a new state
func change_to(new_state):
	history.append(state.name)
	state = get_node(new_state)
	_enter_state()

# Return to the previous state
func back():
	if history.size() > 0:
		state = get_node(history.pop_back())
		_enter_state()

# Enter the current state
func _enter_state():
	if DEBUG:
		print("<DEBUG> ENTERING STATE: ", state.name, " </DEBUG>")
	
	state.fsm = self # Give the state a reference to this state machine script
	state.enter()

# Route game loop function calls to current state handler method if it exists 
func _process(delta):
	if state.has_method("process"):
		state.process(delta)

func _physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)

func _input(event):
	if state.has_method("input"):
		state.input(event)

func _unhandled_input(event):
	if state.has_method("unhandled_input"):
		state.unhandled_input(event)

func _unhandled_key_input(event):
	if state.has_method("unhandled_key_input"): 
		state._unhandled_key_input(event)

func _notification(what):
	if state && state.has_method("notification"):
		state.notification(what)
