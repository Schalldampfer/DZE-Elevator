private ["_args","_option","_obj","_id","_elevatorStop","_dist"];

if (dayz_actionInProgress) exitWith { "Upgrade already in progress." call dayz_rollingMessages; };
dayz_actionInProgress = true;

player removeAction s_player_elevator_upgrade;
s_player_elevator_upgrade = 1;
player removeAction s_player_elevator_upgrade_stop;
s_player_elevator_upgrade_stop = 1;

_args = _this select 3;
_option = _args select 0;
switch (_option) do {
	case "build": {
		_obj = _args select 1;
		_id = [_obj] call ELE_fnc_generateElevatorId;
		if (_id == "") exitWith { "Invalid elevator ID generated" call dayz_rollingMessages;};
		if ((ELE_RequiredBuildTools call AC_fnc_hasTools) && {ELE_RequiredBuildItems call AC_fnc_checkAndRemoveRequirements}) then {
			["Medic", ELE_MaxRange] call AC_fnc_doAnimationAndAlertZombies;
			ELE_elevator = [_obj, _id] call AC_fnc_swapObject;
			"Elevator Machine Built" call dayz_rollingMessages; 
		};
	};
	case "build_stop": {
		_obj = _args select 1;
		if (isNil "ELE_elevator") exitWith { "No elevator selected" call dayz_rollingMessages;};
		_dist = _obj distance ELE_elevator;
		if (_dist > ELE_MaxRange) exitWith { format ["Elevator Stop is to far away from Elevator (%1 > %2)", _dist, ELE_MaxRange] call dayz_rollingMessages;};
		_id = [ELE_elevator] call ELE_fnc_getNextStopId;
		if (_id == "") exitWith { "Elevator Stop already exists or to many (max. 9 per Elevator)" call dayz_rollingMessages; };
		if ((ELE_RequiredBuildTools call AC_fnc_hasTools) && {ELE_RequiredBuildStopItems call AC_fnc_checkAndRemoveRequirements}) then {
			["Medic", ELE_MaxRange] call AC_fnc_doAnimationAndAlertZombies;
			_elevatorStop = [_obj, _id, ELE_StopClass] call AC_fnc_swapObject;
			"Elevator Stop Built" call dayz_rollingMessages;
			sleep 2;
			"YOU MUST MOVE THE ELEVATOR TO THIS STOP BEFORE UPGRADING YOUR NEXT STOP" call dayz_rollingMessages; 
		};
	};
};

dayz_actionInProgress = false;
s_player_elevator_upgrade = -1;
s_player_elevator_upgrade_stop = -1;