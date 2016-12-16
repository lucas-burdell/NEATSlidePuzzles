local Stages = { }
local StagesArray = { }
local States = require("States")
local EventSys;

function Stages.SetEvent(event)
	EventSys = event
	print("CAMERA IS:",lib_Camera)
end

function Stages.new(id)
	if StagesArray[id] then return StagesArray[id] end
	local map = States.new(id)
	map.Size = Vector2.new(1000, 1000)
	map.BackgroundCanvas = nil;
	map.ID = id
	StagesArray[id] = map
	return map
end
return Stages