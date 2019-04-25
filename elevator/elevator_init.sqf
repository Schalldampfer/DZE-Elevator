if (isServer || isDedicated) exitWith {
	diag_log "Error: Elevator script should NOT be started on the server";
};

// global variables
if (isNil "ELE_PlatformClass") then { ELE_PlatformClass = "MetalFloor_DZ" };
if (isNil "ELE_StopClass") then { ELE_StopClass = "MetalFloor_Preview_DZ" };
if (isNil "ELE_MaxRange") then { ELE_MaxRange = 25 }; // m
if (isNil "ELE_Size") then { ELE_Size = 4 }; // m
if (isNil "ELE_Speed") then { ELE_Speed = 2 }; // m/s
if (isNil "ELE_StopWaitTime") then { ELE_StopWaitTime = 5 }; // s
if (isNil "ELE_UpdatesPerSecond") then { ELE_UpdatesPerSecond = 60 }; // animation updates per second
if (isNil "ELE_RequiredBuildTools") then { ELE_RequiredBuildTools = ["ItemToolbox", "ItemCrowbar"] }; // required tools for building an elevator and elevator stop
if (isNil "ELE_RequiredBuildItems") then { ELE_RequiredBuildItems = [["PartGeneric",4], "PartEngine", "ItemGenerator", "ItemJerrycan"] }; // required items to build an elevator
if (isNil "ELE_RequiredBuildStopItems") then { ELE_RequiredBuildStopItems = [["PartGeneric",4]] }; // required items to build an elevator stop
if (isNil "ELE_Debug") then { ELE_Debug = false }; // debug flag
DZE_maintainClasses = DZE_maintainClasses + [ELE_StopClass];
DZE_isRemovable = DZE_isRemovable + [ELE_StopClass];
DayZ_SafeObjects = DayZ_SafeObjects + [ELE_StopClass];
ELE_elevator = nil;
if (!isNil "Custom_Buildables") then { Custom_Buildables set [count Custom_Buildables, ELE_StopClass]; };

// global functions
call compile preprocessFileLineNumbers ("scripts\elevator\vector.sqf");
call compile preprocessFileLineNumbers ("scripts\elevator\ac_functions.sqf");
call compile preprocessFileLineNumbers ("scripts\elevator\elevator_functions.sqf");

diag_log "Elevator script initialized";

