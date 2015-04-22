function PushMelon( ply, force )

	if !ply:Alive() || !IsValid( ply ) then return end
	if !IsValid( ply.melon ) then return end

	local angle = ply:GetAimVector()
	local velocity = force * angle				
	local physobj = ply.melon:GetPhysicsObject()

	physobj:ApplyForceCenter( velocity )
	//physobj:AddAngleVelocity( velocity )

end

function GM:PlayerInitialSpawn( ply )

	net.Start("mr_getlaps")
		net.WriteUInt( MR.LapsForVictory, 8 )
	net.Send( ply )

	net.Start("mr_roundstate")
		net.WriteUInt( MR_ROUNDSTATE, 8 )
	net.Send( ply )

	if MR_ROUNDSTATE == 1 then
		ply:SetTeam( 1 )
	else
		ply:SetTeam( 0 )
	end

	ply.lastcheckpoint = {checkpoint = 0}

end

function GM:PlayerSpawn( ply )

	if !IsValid( ply.melon ) then

		// Create a melon entity and have the player spectate it
		ply:RespawnMelon( ply:GetPos() )

	end

end

function GM:DoPlayerDeath( ply )

	ply:DestroyMelon()

end

function GM:PlayerDisconnected( ply )

	// Clean up the player's melon
	ply:DestroyMelon()

end