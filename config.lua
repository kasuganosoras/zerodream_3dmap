Config = {
	debug          = false, -- Enable or disable the DEBUG mode.
	showPlayer     = true,  -- Display the player self position?
	showPlayers    = true,  -- Display other players position?
	updateInterval = 100,   -- The interval time of the map refresh.
	-- Hotkey setting
	hotKeySettings = {
		fivem = "F1", -- The default key to open the map
		html  = 112,  -- JavaScript KeyCode, 112 = F1
	},
	-- Player self position label setting
	playerPosition = {
		text     = "My Location",
		font     = "Arial",
		fontSize = 80
	},
	-- GPS waypoint label setting
	playerWaypoint = {
		text     = "🚩 Waypoint",
		font     = "Arial",
		fontSize = 80
	},
	-- The other player label setting
	multPlayerMark = {
		font     = "Arial",
		fontSize = 80
	},
	-- Labels
	marks = {
		-- The full-config label example
		{
			name       = "lobby",        -- The label name, only use in the internal, not display name.
			text       = "⭐ Game Lobby", -- The text should be display on the label, support emoji
			x          = -272.18,        -- World position X
			y          = -955.78,        -- World position Y
			z          = 165.0,          -- World position Z
			font       = "Arial",        -- Label font name
			fontSize   = 80,             -- Label font size, unit is "px"
			width      = nil,            -- Label width, unit is "px", leave this as nil to calculate the width automatically.
			height     = nil,            -- Label height, unit is "px", leave this as nil to calculate the height automatically.
			color      = nil,            -- Label text color, support the css format like #FFFFFF, rgb(255,0,0) or rgba(255,255,255,0.6).
			background = nil             -- Label background color, support the css format too.
		},
		-- You can add more labels.
		{
			name       = "maze_bank",
			text       = "🏢 Maze Bank",
			x          = -75.24,
			y          = -818.5,
			z          = 346.18,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "central_park",
			text       = "🏞 Central Park",
			x          = 176.86,
			y          = -965.15,
			z          = 59.24,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "car_shop",
			text       = "🚗 Car Shop",
			x          = -51.01,
			y          = -1113.63,
			z          = 56.02,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "cinema",
			text       = "📽 Cinema",
			x          = 302.57,
			y          = 205.34,
			z          = 161.59,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "drift_road",
			text       = "🚘 Drift Road",
			x          = 808.82,
			y          = 1275.43,
			z          = 390.08,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "jail",
			text       = "⛓ Jail",
			x          = 1692.45,
			y          = 2593.25,
			z          = 100.21,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "mountain",
			text       = "⛰ Mount Chiliad",
			x          = 491.0,
			y          = 5578.2,
			z          = 845.2,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "hemp",
			text       = "🌿 Hemp",
			x          = 2443.54,
			y          = 4973.32,
			z          = 85.15,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "police_1",
			text       = "👮🏻‍♂️ Police station",
			x          = 447.12,
			y          = -990.86,
			z          = 78.16,
			font       = "Arial",
			fontSize   = 80,
		},
		{
			name       = "airport",
			text       = "✈ Airport",
			x          = -1228.1,
			y          = -2945.5,
			z          = 80.49,
			font       = "Arial",
			fontSize   = 80,
		}
	}
}
