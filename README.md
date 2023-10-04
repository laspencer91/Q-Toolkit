# Q-Toolkit
A library of tools and functions to increase the enjoyment of development in GameMaker.

[QStateMachine](#qstatemachine)

# QStateMachine

[QStateMachine Class](#qstatemachine-class) | [QStateMachineState Base Class](#qstatemachinestate-base-class)

## Description

The `QStateMachine` module provides a finite state machine (FSM) for managing a set of states and transitioning between them. It is a fundamental part of the Q-Toolkit library for GameMaker.

```javascript
// Create a QStateMachine instance
var qsm = new QStateMachine();

// Create the IdleState behavior. It is recommended that this code lives in its own file.
function IdleState() : QStateMachineState() constructor
{
	OnBegin = function()
	{
		show_message("Idle State OnBegin");
	}
	
	OnEnd = function()
	{
		show_message("Idle State OnEnd");
	}
	
	Step = function()
	{
		show_message("Idle State Step");
	}
}

// Add an instance of IdleState to the state machine.
// Since this is the first state added, it will be the default, and the OnBegin function will be called.
qsm.AddState("IdleState", new IdleState());

// Execute the current state's step function. 
// This would typically go into an objects Step event.
qsm.Step();
```

## QStateMachine Class

### Overview

Creates a new instance of a finite state machine (FSM) using the QStateMachine class.

```javascript
qsm = new QStateMachine();
```

### Methods

#### AddState(_state_id, _q_state)

- Adds a state to the state machine.

##### Parameters

- **_state_id** (string, real, any): The identifier (name or id) of the state.
- **_q_state** (Struct.QStateMachineState): The state object to be added.


```javascript
qsm.AddState("IdleState", qsm_state_idle);
```

#### ChangeState(_state_id)

- Changes the current state of the state machine.

##### Parameters

- **_state_id** (string, real, any): The identifier (name or id) of the state to change to.


```javascript
qsm.ChangeState("WalkState");
```

#### Step()

- Executes the step function of the current state.


```javascript
qsm.Step();
```

## QStateMachineState Base Class


`QStateMachineState` is a base class for states used by a `QStateMachine`. Three methods must be implemented: `OnBegin()`, `OnEnd()`, and `Step()`.

```javascript
// Inheritting the QStateMachineState constructor will ensure correct behavior within the QStateMachine.
function IdleState() : QStateMachineState() constructor
{
	OnBegin = function()
	{
		show_message("Idle State OnBegin");
	}
	
	OnEnd = function()
	{
		show_message("Idle State OnEnd");
	}
	
	Step = function()
	{
		show_message("Idle State Step");
	}
}
```

### Methods

#### OnBegin()

- Code to be executed when the StateMachine transitions TO this state.

#### OnEnd()

- Code to be executed when the StateMachine transitions AWAY from this state.

#### Step()

- Code to be executed on each step while in this state.


