include( 'shared.lua' )
include( 'config.lua' )
include( 'player.lua' )
include( 'player_meta.lua' )

MR_ROUNDSTATE = 2

function GM:PlayerDeathSound() 

	return false

end

function GM:Think()

	for k, v in pairs(player.GetAll()) do
			
		if v:KeyDown(IN_FORWARD) then
			PushMelon( v, MR.DefaultForwardThrust )
		elseif v:KeyDown(IN_BACK) then
			PushMelon( v, MR.DefaultReverseThrust )
		end	
		
	end

end

function GM:EntityTakeDamage( target, dmg ) 

	if target.ismelon && dmg:GetDamage() >= target:Health() then
		target:GetOwner():RespawnMelon( target:GetPos() )
	end

	return dmg

end

function GM:EntityKeyValue( ent, key, value ) 

	if ent:GetClass() == "checkpoint" && key == "number" then
		
		ent.checkpoint = value

	end

	return true

end