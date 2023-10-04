/// Creates a new instance of a finite state machine (FSM) using the QStateMachine class.
/// The FSM is used to manage a set of states and transition between them.
function QStateMachine() constructor
{
	// Initialize the states container as a ds_map.
	states = ds_map_create();
	
	// Initialize the current state as undefined.
	current_state = undefined;
	
	/// Add a state to the state machine. 
    /// @param {string,real,any} _state_id - The identifier (name or id) of the state.
    /// @param {Struct.QStateMachineState} _q_state - The state object to be added.
	AddState = function(_state_id, _q_state)
	{
		ds_map_add(states, _state_id, _q_state);
		if (is_undefined(current_state))
		{
			current_state = _q_state;
			current_state.OnBegin();
		}
	}
	
	/// Change the current state of the state machine.
    /// @param {string,real,any} _state_id - The identifier (name or id) of the state to change to.
	ChangeState = function(_state_id)
	{
		// Find the new state in the states ds_map.
		var _state = ds_map_find_value(states, _state_id);
		
		if (is_undefined(_state))
		{
			show_debug_message($"The state {_state_id} does not exist in this machine.");
			return;
		}
		
        // Play the OnEnd() function for the current state if it is not undefined.
		if (!is_undefined(current_state))
		{
			current_state.OnEnd();	
		}
		
		// Set the current state to the new state and call OnBegin().
		current_state = _state;
		current_state.OnBegin();
	}
	
	/// Execute the step function of the current state.
	Step = function()
	{
		if (!is_undefined(current_state))
		{
			current_state.Step();	
		}	
	}
}

/// A base class - State which can be used by a QStateMachine. Three methods
/// must be implemented: OnBegin(), OnEnd(), and Step()
function QStateMachineState() constructor
{
	/// Code to be executed when the StateMachine transitions TO this state.
	OnBegin = function()
	{
		show_message("State OnBegin Unimplemented");
	}
	
	/// Code to be executed when the StateMachine transitions AWAY this state.
	OnEnd = function()
	{
		show_message("State OnEnd Unimplemented");	
	}
	
	/// Code to be executed each Step.
	Step = function()
	{
		show_message("State OnUpdate Unimplemented");	
	}
}