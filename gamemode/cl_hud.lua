surface.CreateFont( "MelonRacerFontS", {
	font = "Trebuchet MS",
	size = 20,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


surface.CreateFont( "MelonRacerFont", {
	font = "Trebuchet MS",
	size = 28,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local ScreenW = ScrW() / 2
local ScreenH = ScrH()

local function PaintDeathHUD()



end

hook.Add("HUDPaint", "VBaseHUD", function()

	draw.RoundedBox( 0, ScreenW-104, 0, 208, 68, Color(150, 200, 150, 255) )
	draw.RoundedBox( 0, ScreenW-100, 0, 200, 64, Color(150, 255, 150, 255) ) 

	draw.SimpleText( melonracer.roundstate .. "(" .. melonracer.roundtimer .. ")", "MelonRacerFontS", ScreenW, 5, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
	draw.SimpleText( 'Lap ' .. melonracer.curlap .. ' of ' .. melonracer.laps, "MelonRacerFont", ScreenW, 26, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 

end)