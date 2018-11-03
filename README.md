# DZE-Elevator
Created by Axe Cop

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

4. Configuration: in `Dayz_Epoch_**.Mapname\dayz_code\init\variables.sqf`
```sqf
//elevator
ELE_MaxRange = DZE_PlotPole select 0; // maximum range the elevator can travel / stop points can be built (in meter)
ELE_Speed = 30; // speed of the elevator (meters per second)
ELE_StopWaitTime = 0; // disable the wait time if you call the elevator
ELE_RequiredBuildTools = ["ItemToolbox", "ItemCrowbar"]; // required tools for building an elevator and elevator stop
ELE_RequiredBuildItems = [["PartGeneric",2], "PartEngine", "ItemGenerator", "ItemJerrycan"]; // required items to build an elevator
ELE_RequiredBuildStopItems = [["PartGeneric",2]]; // required items to build an elevator stop
ELE_StopClass = "MetalFloor_Preview_DZ"; // elevator stop classname
```
