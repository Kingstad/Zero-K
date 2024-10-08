local scarSets = VFS.Include("gamedata/scars.lua", nil, VFS.GAME)

return {
	FACTORY_COST = 700,
	FACTORY_BUILDPOWER = 10,

	FACTORY_PLATE_COST = 150,
	FACTORY_PLATE_HEALTH = 1000,
	FACTORY_PLATE_RANGE = 420, -- same as Caretaker, for no particular reason

	SCAR_SET = scarSets,

	BURST_RELIABLE   = '0',
	BURST_UNRELIABLE = '1',
}
