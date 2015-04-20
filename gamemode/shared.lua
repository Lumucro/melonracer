/*
	GAMEMODE INFO
*/

DEFINE_BASECLASS( "gamemode_base" )

GM.Name = "Melonracer"
GM.Author = "Remake by Lumucro"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:CreateTeams()
	
	team.SetUp( 0, "Player", Color(188, 143, 143) )
	team.SetUp( 1, "Spectator", Color(220, 220, 220) )

end

function GM:Initialize()

	self.BaseClass.Initialize( self )

end