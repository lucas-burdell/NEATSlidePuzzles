-- Main Menu

local mainmenu = { }
local time = 0
local Entities = lib_Entities
local cam = lib_Camera
local stage = lib_Stages
local EventSys = lib_EventSys
local obj_selection = 1

mainmenu.cam = cam.new()
mainmenu.stage = stage.new("mainmenu")

function mainmenu:Update(dt)
	time = time + dt
	if time<=5 then
		foreground_transparency = time/5
	elseif time<5.5 and time>=5 then
		foreground_transparency = 1
	end
	-- THIS IS STILL PRETTY GROSS