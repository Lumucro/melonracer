include( 'shared.lua' )
include( 'cl_hud.lua' )

melonracer = {}
melonracer.roundstate = "Initializing"
melonracer.roundtimer = 0
melonracer.curlap = 0
melonracer.laps = 0
melonracer.winner = ""

net.Receive( "mr_roundstate", function()

	local rs = net.ReadUInt( 8 )

	if rs == 0 then
		melonracer.roundstate = "Preparing to race"
	elseif rs == 1 then
		melonracer.roundstate = "Race in progress"
	else
		melonracer.roundstate = "Map has ended"
	end

	print('ROUNDSTATE')
	print(rs)
	print(melonracer.roundstate)

end) 

net.Receive( "mr_notifydeath", MelonDied) 

net.Receive( "mr_notifylapcomplete", function()
	
	melonracer.curlap = net.ReadUInt( 8 )

end) 

net.Receive( "mr_getlaps", function()
	
	melonracer.laps = net.ReadUInt( 8 )

end) 

net.Receive( "mr_notifywinner", function()
	
	melonracer.winner = net.ReadString()

end) 

function MelonDied()



end

concommand.Add("melon", function()

	print(melonracer)
	PrintTable(melonracer)

end)