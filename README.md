# DZE-Elevator

Report post 
Posted November 12, 2013 (edited)
I had an idea about doing an elevator script to extend the base building a little or just for some fun with ArmA/Epoch! :D

 

Here is a video of the current prototype: (and don't laugh I got stuck after I fell from the roof  :P)


Just recorded another video to show how to call an elevator, I've placed 4 stops around the house, looks kinda funny yeah :D


If anyone is wondering, I use the preview version of the metal floor to display the stop points of the elevator.. some item has to be present so you can call the elevator there and the positions get saved to the database. This item can be changed in the config but the preview items have no collisions so you can just travel through it and it's easy to see where the elevator can stop.

 

Everything is saved to the database without any need to modify the server files or database structure. It only updates the "CharacterID" field in the "object_data" table like safes or locked door also do in Epoch, I don't want to bore you with the technical details but I encoded the elevator and stop point ID's in an 8 digit long code, always starting with "6976" (that is ASCII code for "EL" :P), the next 3 digits are the elevator ID and the last the elevator stop ID. Meaning you can have up to 10 stops per elevator (0-9) for now. It looks like this (without the "-"), just in case you want to find an elevator in the database or whatever.

ID 8 digits: EL-ID-STID = 6976-###-#
e.g the ID's of an elevator with 2 additional stop points: 69760010 -> 69760011 -> 69760012

 

The elevator can be build similar to the in-place upgrade system from Epoch, so just look at a metal floor (item can also be changed in the config) and you will get an option "Upgrade to Elevator" and "Upgrade to Elevator Stop", the elevator stop can only be build if there is an elevator in range (max. range for the elevator to travel can be changed, default 25m), you have to select an elevator first (the select action will be available if you look at an elevator, also new built elevator are selected by default).

Once you have built an elevator with at least 1 stop point you can just look at it and select "Activate Elevator: Next Stop" or "Activate Elevator: Previous Stop", it will then find and move to the next/previous stop. If there is no stop in range you get a message and nothing happens, the menu could be hidden if there is no next stop for the elevator but in the first version the actions are always shown.

You can also call the elevator at any stop point, it will travel along the way, stopping at every stop point and wait there (default 5 sec. can be changed in the config).

 

Installation and configuration

Ok now to the installation and configuration of the elevator script. The script is only client side, so very easy to add to your mission file!

You can get the current scripts here: https://github.com/vos/dayz/tree/master/elevator just download the whole folder and extract it to your mission file.

To enable the script on your server add this line to your init.sqf at the end of the block "if (!isDedicated) then {" (so just above the next "};" should be fine):

["elevator"] execVM "elevator\elevator_init.sqf";
Assuming your have the elevator folder with the scripts in your mission root, the only parameter of the script "elevator" is the folder relative to your mission file, it's needed to load the other scripts from that folder. You can change it to "scripts\elevator" if your put the elevator-folder there for example.

 

That is all you have to do to install the elevator script on your server, there are some config variables you can change, take a look at the file "elevator_init.sqf" where it says "global variables", you can change the values there, but I would suggest changing it in your init.sqf like the Epoch settings, e.g.:

ELE_MaxRange = 100; // maximum range the elevator can travel / stop points can be built (in meter)
ELE_Speed = 5; // speed of the elevator (meters per second)
ELE_StopWaitTime = 0; // disable the wait time if you call the elevator
...
["elevator"] execVM "elevator\elevator_init.sqf";
Added building requirements and upgrade animation to build the elevator and elevator stops. Default requirements are:

ELE_RequiredBuildTools = ["ItemToolbox", "ItemCrowbar"]; // required tools for building an elevator and elevator stop
ELE_RequiredBuildItems = [["PartGeneric",4], "PartEngine", "ItemGenerator", "ItemJerrycan"]; // required items to build an elevator
ELE_RequiredBuildStopItems = [["PartGeneric",4]]; // required items to build an elevator stop
You will get the default messages from Epoch if you are missing the tools or items.

 

There are no access restrictions yet! Any player can built or use an elevator with this version, so keep that in mind if you want to use it on a live server. I already have some ideas to use the default car keys to use an elevator, that should work.. unless your have some better ideas for access control? :)

 

Just one more thing, as I use the "MetalFloor_Preview_DZ" for the elevator stop by default, if you want to keep it like that you have to add that class to your allowed objects in Epoch, otherwise Epoch will delete it right after you upgrade a metal floor to a stop point. To do that the class needs to be added to the file "dayz_code\init\variables.sqf", at line 466 there is a list "dayz_allowedObjects", just add "MetalFloor_Preview_DZ" to that list and copy the file to your mission folder as usual (the file is referenced in the init.sqf). if you don't want to do that just replace the stop class with this config variable:

ELE_StopClass = "MetalFloor_Preview_DZ";
Replace the classname with whatever you like, I didn't test any other but the elevator will just travel there and you can call the elevator with looking at that object.

 

Remember this is still work in progress, there might be bugs and maybe the elevator ID gets changed so already built elevators might not work after an update, but you can already play around with the script and tell me what you think, Ideas are welcome... :)
