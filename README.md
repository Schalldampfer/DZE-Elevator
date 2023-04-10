# DZE-Elevator
Created by Axe Cop
Updated for DayZ Epoch 1.0.7.1 by Treuce

# Installation and configuration

1. Coppy&paste elevator folder into `DayZ_Epoch_**.Mapname\scripts`

2. Add this line
```sqf
["scripts\elevator"] execVM "scripts\elevator\elevator_init.sqf";
```
into
```sqf
if (!isDedicated) then { *** };
``` 
block in your `DayZ_Epoch_**.Mapname\init.sqf`

3. Add these lines

```sqf
s_player_elevator_next = -1;
s_player_elevator_previous = -1;
s_player_elevator_select = -1;
s_player_elevator_upgrade = -1;
s_player_elevator_upgrade_stop = -1;
s_player_elevator_call = -1;
s_player_elevator_id = -1;
```
into
```sqf
dayz_resetSelfActions = { *** };
``` 
block in your `Dayz_Epoch_**.Mapname\dayz_code\init\variables.sqf`
and
```sqf
DZE_maintainClasses = DZE_maintainClasses + [ELE_StopClass];
DZE_isRemovable = DZE_isRemovable + [ELE_StopClass];
DayZ_SafeObjects = DayZ_SafeObjects + [ELE_StopClass];
```
out of the block

4. In `Dayz_Epoch_**.Mapname\dayz_code\compile\fn_selfActions.sqf`, Put these below :

```sqf
	//Elevator Ations
	if ((player distance _cursorTarget) < ELE_Size) then {
		// has target
		if (_typeOfCursorTarget == ELE_PlatformClass) then {
			// elevator actions
			if ([_cursorTarget] call ELE_fnc_isElevator) then {
				if (s_player_elevator_next < 0 && {[_cursorTarget] call ELE_fnc_hasNextStop}) then {
					s_player_elevator_next = player addAction ["<t color=""#ffffff"">Activate Elevator: Next Stop</t>", "scripts\elevator\elevator_actions.sqf", ["next",_cursorTarget], 5, false];
				};
				if (s_player_elevator_previous < 0 && {[_cursorTarget] call ELE_fnc_hasPreviousStop}) then {
					s_player_elevator_previous = player addAction ["<t color=""#ffffff"">Activate Elevator: Previous Stop</t>", "scripts\elevator\elevator_actions.sqf", ["previous",_cursorTarget], 5, false];
				};
				if (s_player_elevator_select < 0) then {
					s_player_elevator_select = player addAction ["<t color=""#ffffff"">Select Elevator</t>", "scripts\elevator\elevator_actions.sqf", ["select",_cursorTarget], 2, false];
				};
			} else {
				if (s_player_elevator_upgrade < 0) then {
					s_player_elevator_upgrade = player addAction ["Upgrade to Elevator", "scripts\elevator\elevator_build.sqf", ["build",_cursorTarget], 0, false];
				};
				if (s_player_elevator_upgrade_stop < 0) then {
					s_player_elevator_upgrade_stop = player addAction ["Upgrade to Elevator Stop", "scripts\elevator\elevator_build.sqf", ["build_stop",_cursorTarget], 0, false];
				};
			};
		};
		// elevator stop actions
		if ([_cursorTarget] call ELE_fnc_isElevatorStop) then {
			if (s_player_elevator_call < 0) then {
				s_player_elevator_call = player addAction ["<t color=""#ffffff"">Call Elevator</t>", "scripts\elevator\elevator_actions.sqf", ["call",_cursorTarget], 5, false];
			};
		};
		// debug actions
		if (s_player_elevator_id < 0 && ELE_Debug) then {
			s_player_elevator_id = player addAction ["Show Elevator ID", "scripts\elevator\elevator_actions.sqf", ["id",_cursorTarget], 0, false];
		};
	};
```
after
```sqf
	//Allow player to fill Fuel can
	if (_hasEmptyFuelCan && _isFuel && _isAlive) then {
		if (s_player_fillfuel < 0) then {
			s_player_fillfuel = player addAction [localize "str_actions_self_10", "\z\addons\dayz_code\actions\jerry_fill.sqf",_cursorTarget, 1, false, true];
		};
	} else {
		player removeAction s_player_fillfuel;
		s_player_fillfuel = -1;
	};
```

5. In `Dayz_Epoch_**.Mapname\dayz_code\compile\fn_selfActions.sqf`, Put these below :

```sqf
	player removeAction s_player_elevator_next;
	s_player_elevator_next = -1;
	player removeAction s_player_elevator_previous;
	s_player_elevator_previous = -1;
	player removeAction s_player_elevator_select;
	s_player_elevator_select = -1;
	player removeAction s_player_elevator_upgrade;
	s_player_elevator_upgrade = -1;
	player removeAction s_player_elevator_upgrade_stop;
	s_player_elevator_upgrade_stop = -1;
	player removeAction s_player_elevator_call;
	s_player_elevator_call = -1;
	player removeAction s_player_elevator_id;
	s_player_elevator_id = -1;
```
after
```sqf
	player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	player removeAction s_player_manageDoor;
	s_player_manageDoor = -1;
```

6. Configuration: in `Dayz_Epoch_**.Mapname\configVariables.sqf`. Customize and add below:

```sqf
//elevator
ELE_MaxRange = DZE_PlotPole select 0; // maximum range the elevator can travel / stop points can be built (in meter)
ELE_Speed = 30; // speed of the elevator (meters per second)
ELE_StopWaitTime = 0; // disable the wait time if you call the elevator
ELE_RequiredBuildTools = ["ItemToolbox", "ItemCrowbar"]; // required tools for building an elevator and elevator stop
ELE_RequiredBuildItems = [["PartGeneric",2], "PartEngine", "ItemGenerator", "ItemJerrycan"]; // required items to build an elevator
ELE_RequiredBuildStopItems = [["PartGeneric",2]]; // required items to build an elevator stop
ELE_StopClass = "MetalFloor_Preview_DZ"; // elevator stop classname
ELE_PlatformClass = "MetalFloor_DZ";
ELE_Classes = [ELE_StopClass] + [ELE_PlatformClass];
```
before lines you added in 3.

7. In `dayz_server\compile\server_SwapObject.sqf` on line `70` replace:
   ```sqf
   _setGlobal = [false,true] select ((_class in DZE_isLockedStorageUpgrade) || (_class in DZE_DoorsLocked));`
   ```
   with:
   ```sqf
   _setGlobal = [false,true] select ((_class in DZE_isLockedStorageUpgrade) || (_class in DZE_DoorsLocked) || (_class in ELE_Classes));
   ```
	This is for the server to set the new, elevator generated CharacterID globally, so the players actually see it as an elevator.
8. In `dayz_server\system\server_monitor.sqf` on line `271` replace:
   ```sqf
   _setGlobal = [false,true] select ((_type in DZE_LockedStorage) || (_type in DZE_DoorsLocked));
   ```
   with:
   ```sqf
	_setGlobal = [false,true] select ((_type in DZE_isLockedStorageUpgrade) || (_type in DZE_DoorsLocked) || (_type in ELE_Classes));
   ```
9. In `dayz_server\system\server_monitor.sqf` on line `204` replace:
   ```sqf
	_object setVariable ["ObjectID", _idKey];
   ```
   with:
   ```sqf
	_object setVariable ["ObjectID", _idKey, true];
   ```
10. In `dayz_server\init\server_functions.sqf` on line `89` paste the following:
   ```sqf
	if ((typeOf _object) in ELE_Classes) then {		
		_allowed = true;
	};
   ```