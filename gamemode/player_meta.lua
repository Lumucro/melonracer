local pm = FindMetaTable("Player")

function pm:GetMelonModel()

	return self:GetPData( "mr_melonmodel", MR.DefaultMelonModel )

end

function pm:RespawnMelon( pos )

	if IsValid( self.melon ) then self:DestroyMelon() end

	local ent = ents.Create( "prop_physics" )
	ent:SetModel( self:GetMelonModel() )
	ent:SetPos( pos )
	ent:SetOwner( self )
	ent:Spawn()
	ent:Activate()

	ent.ismelon = true
	self.melon = ent

	self:Spectate( OBS_MODE_CHASE )
	self:SpectateEntity( self.melon )
	self:StripWeapons()

end

function pm:DestroyMelon()

	if !IsValid( self.melon ) then return end
	self.melon:Fire("break", "0", "0")

end

function pm:PassCheckpoint( ent )

	if self.lastcheckpoint.checkpoint == nil then return end
	if !MR_ROUNDSTATE == 2 then return end

	if tonumber(ent.checkpoint) == tonumber(self.lastcheckpoint.checkpoint + 1) then
		
		print('went from checkpoint ' .. self.lastcheckpoint.checkpoint .. ' to ' .. ent.checkpoint)
		self.lastcheckpoint = ent

	else

		print('tried going from checkpoint ' .. self.lastcheckpoint.checkpoint .. ' to ' .. ent.checkpoint)

	end

end