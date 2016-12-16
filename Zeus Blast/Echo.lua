local Echo = { }
local Vector2 = require("Vector2")

function Echo.new(Position, MaxLines)
	local echo = {["Position"] = Position, ["MaxLines"] = MaxLines, ["Lines"] = {} }
	function echo:Draw()
		for i, v in pairs(self.Lines) do
			love.graphics.print(v, self.Position.X, echo.Position.Y + (10 * i))
		end
	end
	function echo:Print(text)
		table.insert(self.Lines, 1, text)
		for i, v in pairs(self.Lines) do
			if i>self.MaxLines then
				self.Lines[i] = nil
			end
		end
	end
	return echo
end
return Echo