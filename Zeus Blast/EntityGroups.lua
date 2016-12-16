local Entity_Group = { }
local Groups = { }
local PrimaryTagGroups = { }
local EventSys = lib_EventSys

function Entity_Group.SetEvent(event)
	EventSys = event
end

function Entity_Group.GetEGroupWithTags(...)
	local tags = {...}
	local groups;
	for _, tag in pairs(tags) do
		for __, group in pairs(groups or Groups) do
			for i, v in pairs(group.Tags) do
				if v==tag then
					if not groups then groups = { } end
					table.insert(groups, group)
				end
			end
		end
	end
	return groups
end

function Entity_Group.new(Options, ...)
	local egroup = { }
	egroup.Entities = {...}
	egroup.Tags = {Options.Tags and unpack(Options.Tags) or nil}
	egroup.PrimaryTag = Options.PrimaryTag or "Generic"
	if not PrimaryTagGroups[egroup.PrimaryTag] then
		PrimaryTagGroups[egroup.PrimaryTag] = {egroup}
	else
		table.insert(PrimaryTagGroups, egroup)
	end
