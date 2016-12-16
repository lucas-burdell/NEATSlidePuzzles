local Camera = { }
local DebugConsole;
local EventSys = lib_EventSys

local NUM_STARGROUNDS = 5

function Camera.SetEvent(event)
	EventSys = event
end


function Camera.PassDebugConsole(console)
	DebugConsole = console
end

function Camera.new()
	local cam = { }
	cam.Position = Vector2.new(0, 0)
	cam.Zoom = Vector2.new(.5, .5)
	cam.Size = Vector2.new(love.graphics.getDimensions()) * cam.Zoom-- default size
	--cam.Size = cam.Size-- * .5
	cam.Scale = Vector2.new(love.graphics.getWidth() / cam.Size.X, love.graphics.getHeight() / cam.Size.Y)
--	cam.Size.X = cam.Size.X * 2
--	cam.Size.Y = cam.Size.Y * 2
	cam.Background = nil
	cam.BackgroundScale = Vector2.new(2, 2)
	cam.Stargrounds = { }
	for i = 1, NUM_STARGROUNDS do -- NUM STARGRONDS
		local Starground = love.graphics.newCanvas(love.graphics.getWidth() * 3, love.graphics.getHeight() * 3)
		print(Starground)
		-- create starground canvas
		love.graphics.setCanvas(Starground)
		local origin_color = {love.graphics.getColor()}
		for i = 1, math.random(150, 350) do
			local color_intensity = math.random(185, 255)
			local rec = {
				Size = Vector2.new(5, 5);
				Position = Vector2.new(math.random(Starground:getWidth() - 5), math.random(Starground:getHeight() - 5));
				Color = {color_intensity, color_intensity, color_intensity}
			}
			love.graphics.setColor(unpack(rec.Color))
			love.graphics.rectangle("fill", rec.Position.X, rec.Position.Y, rec.Size.X, rec.Size.Y)
		end
		table.insert(cam.Stargrounds, Starground)
		love.graphics.setColor(unpack(origin_color))
	end


	love.graphics.setCanvas()
	
	function cam:AddBackground(entity)
		--love.graphics.setCanvas(self.Starground)
		if not self.Background then
			self.Background = love.graphics.newCanvas()
		end
		love.graphics.setCanvas(self.Background)
		entity:Draw(
			{
				["Scale"] = self.BackgroundScale;
				["Position"] = Vector2.new(0, 0);
				["Size"] = Vector2.new(love.graphics.getWidth(), love.graphics.getHeight())
			}
		)
		love.graphics.setCanvas()
	end

	function cam:SetZoom(ZoomVec)
		cam.Zoom = ZoomVec
		cam.Size = Vector2.new(love.graphics.getDimensions()) * cam.Zoom
		cam.Scale = Vector2.new(love.graphics.getWidth() / cam.Size.X, love.graphics.getHeight() / cam.Size.Y)
	end

	function cam:DrawOnState(StageObject)
		if not StageObject then return end
		if #self.Stargrounds>0 then
			for i, v in pairs(self.Stargrounds) do
				local parallax = self.Position *  Vector2.new(-1/(love.graphics.getWidth() / (50 * i)), -1/(love.graphics.getHeight() / (50 * i)))
				love.graphics.push()
				love.graphics.origin()
				love.graphics.draw(v, parallax.X, parallax.Y, 0, .5, .5)
				love.graphics.pop()
			end
		end
		if self.Background then
			love.graphics.push()
			love.graphics.draw(self.Background, 0, 0, 0, self.BackgroundScale.X, self.BackgroundScale.Y)
			love.graphics.pop()
		end
		love.graphics.push()

		love.graphics.scale(self.Scale.X, self.Scale.Y)
		love.graphics.translate(-self.Position.X, -self.Position.Y)
		StageObject:Draw(self)
		love.graphics.pop()
	end
	return cam
end

return Camera