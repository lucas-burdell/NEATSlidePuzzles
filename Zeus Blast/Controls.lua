local Controls = { }
local EventSys = lib_EventSys
local CurrentControl = nil
local KeyTable = { }
local KeyList = " abcdefghijklmnopqrstuvwxyz[].,<>?/\\=-0987654321`updownrightleft"
local CurrentControl; -- Only one we want to update, kill all others

function Controls.new(ID) -- THERE IS A BIG MOTHERFUCKIGN DIFFERENCE BETWEEN A FUNCTION AND A METHOD LOL
	local obj = { }
	obj.DefaultKeyCallbacks = { } -- Now, I know this shouldn't be passed empty...
	obj.OverrideKeyCallbacks = { }
	Controls[ID] = obj

	function obj:AddOverrideKeyCallback(key, callback)
		local key = key:lower()
		local index;
		if KeyList:match(key) then
			if not self.OverrideKeyCallbacks[key] then
				self.OverrideKeyCallbacks[key] = { }
			end
			index = #self.OverrideKeyCallbacks[key] + 1
			self.OverrideKeyCallbacks[key][index] = callback
		end
		return index
	end

	function obj:AddKeyCallback(key, callback)
		local key = key:lower()
		local index;
		if KeyList:match(key) then
			if not self.DefaultKeyCallbacks[key] then
				self.DefaultKeyCallbacks[key] = { }
			end
			index = #self.DefaultKeyCallbacks[key] + 1
			self.DefaultKeyCallbacks[key][index] = callback
		end
		return index
	end

	function obj:Update(key, down) -- o
		if not self.OverrideKeyCallbacks[key] or #self.OverrideKeyCallbacks[key]==0 then --dafuq
			if self.DefaultKeyCallbacks[key] then
				for _, v in pairs(self.DefaultKeyCallbacks[key]) do
					v(down)
				end
			end
		else
			for _, v in pairs(self.OverrideKeyCallbacks[key]) do
				v(down)
			end
		end
	end

	return obj
end

function love.keypressed(key)
	local key = key:lower()
	if KeyList:match(key) then
		KeyTable[key] = true
		if CurrentControl then
			CurrentControl:Update(key, true)
			print(key, 'is down')
		end
	end
end

function love.keyreleased(key)
	local key = key:lower()
	if KeyList:match(key) then
		KeyTable[key] = false
		if CurrentControl then
			CurrentControl:Update(key, false)
			print(key, 'is up')
		end
	end
end

function Controls:SetCurrent(Control)
	CurrentControl = Control
end

return Controls

--[[
	function Controls.HandleKeyChange(key, tog, held)
		if not CurrentControl then return end
		if Control_Types[CurrentControl][key:lower()] then
			if DebugConsole then if tog and not held then DebugConsole:Print(key:lower()) end end
			Control_Types[CurrentControl][key:lower()](tog, Control_Keys, Control_Keys[key:lower()] == tog)
			Control_Keys[key:lower()] = tog
		end
	end

	function Controls:Update()
		for i, v in pairs(Control_Types[CurrentControl]) do
			self.HandleKeyChange(i, love.keyboard.isDown(i))
		end
	end

	function Controls.TakeControl(id)
		if not Control_Types[id] then return end
		CurrentControl = id
	end

	function Controls.new(id, ControlTable)
		if Control_Types[id] then error("Controls already set for "..tostring(id)) return end
		Control_Types[id] = ControlTable
		return ControlTable
	end

	return Controls
]]