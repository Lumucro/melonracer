ENT.Type = "brush"
AddCSLuaFile( "checkpoint.lua" )

function ENT:StartTouch( ent )

	if !IsValid(ent) || !ent.ismelon then return end
	ent:GetOwner():PassCheckpoint( self )

end