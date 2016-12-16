-- entity
local Entity = { }

function Entity.new(position, size)
	local entity = { }
	entity.Position = position;
	entity.Size = size;
	entity.Color = {255, 255, 255}
	entity.Type = "Empty"

	function entity:draw()

		local store = {love.graphics.getColor()}
		love.graphics.setColor(self.Color[1], self.Color[2], self.Color[3])
		love.graphics.polygon("fill", 
			-- top left
			self.Position.X,
			self.Position.Y,

			-- top right
			self.Position.X + (self.Size.X),
			self.Position.Y,

			-- Bottom Right
			self.Position.X + (self.Size.X),
			self.Position.Y + (self.Size.Y),

			self.Position.X,
			self.Position.Y + (self.Size.Y) 
		)
		--[[
		love.graphics.polygon("fill",
			self.Position.X - (self.Size.X/2),
			self.Position.Y - (self.Size.Y/2),

			self.Position.X + (self.Size.X/2),
			self.Position.Y - (self.Size.Y/2),

			self.Position.X - (self.Size.X/2),
			self.Position.Y + (self.Size.Y/2),

			self.Position.X + (self.Size.X/2),
			self.Position.Y + (self.Size.Y/2)
		)
		--]]
		love.graphics.setColor(store)

	end

	function entity:collidesWithPosition(otherPosition, otherSize)
		return (
		(self.Position.X < otherPosition.X + otherSize.X and 
			self.Position.X + self.Size.X > otherPosition.X) and 
		(self.Position.Y > otherPosition.Y and 
			self.Position.Y < otherPosition.Y + otherSize.Y)) or 
		((otherPosition.X < self.Position.X + self.Size.X and 
			otherPosition.X + otherSize.X > self.Position.X) and 
		(otherPosition.Y > self.Position.Y and 
			otherPosition.Y < self.Position.Y + self.Size.Y))
	end

	function entity:collidesWith(other)
		return (
		(self.Position.X < other.Position.X + other.Size.X and 
			self.Position.X + self.Size.X > other.Position.X) and 
		(self.Position.Y > other.Position.Y and 
			self.Position.Y < other.Position.Y + other.Size.Y)) or 
		((other.Position.X < self.Position.X + self.Size.X and 
			other.Position.X + other.Size.X > self.Position.X) and 
		(other.Position.Y > self.Position.Y and 
			other.Position.Y < self.Position.Y + self.Size.Y))

	end

	return entity;
end

return Entity



