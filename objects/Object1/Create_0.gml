var _state_machine = new QStateMachine();

function IncrementState() : QStateMachineState() constructor
{
	_count = 0;
	
	OnBegin = function()
	{
		_count = 0;
		show_debug_message("entered increment state");
	}
	
	OnEnd = function()
	{
		show_debug_message("leaving increment state");
	}
	
	Step = function()
	{
		_count++;	
		show_debug_message($"Count {_count}");
	}
}

var increment_state = new IncrementState();

var decrement_state = new QStateMachineState();

decrement_state.count = 100;

decrement_state.OnBegin = function()
{
	count = 100;
	show_debug_message("entered decrement state");
}
decrement_state.OnEnd = function()
{
	show_debug_message("leaving decrement state");
}
decrement_state.Step = function()
{
	count--;
	show_debug_message($"Count {count}");
}

_state_machine.AddState("Increment", increment_state);
_state_machine.AddState("Decrement", decrement_state);

_state_machine.Step();
_state_machine.Step();
_state_machine.Step();
_state_machine.Step();
_state_machine.ChangeState("Decrement");
_state_machine.Step();
_state_machine.Step();
_state_machine.Step();