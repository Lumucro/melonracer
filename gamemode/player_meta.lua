local pm = FindMetaTable("Player")

function pm:GetMelonModel()

	return self:GetPData( "mr_melonmodel", MR.DefaultMelonModel )

end

function pm:SpawnMelon( pos )

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

function pm:RespawnMelon( pos )

	if IsValid( self.melon ) then self:DestroyMelon() end

	if (tonumber(MR_ROUNDSTATE) == 1) then

		timer.Simple( MR.RespawnDelay, function()

			self:SpawnMelon( pos )

		end)

	else

		self:SpawnMelon( pos )

	end

end

function pm:DestroyMelon()

	if !IsValid( self.melon ) then return end
	self.melon:Fire("break", "0", "0")
	self:AddDeaths(1)

end

function pm:AnnounceWinner()

	net.Start("mr_notifywinner")
		net.WriteString( self:Nick() )
	net.Broadcast()

	MR_FINISH.winner = self

	for k,v in pairs(player.GetAll()) do
		v:ChatPrint( self:Nick() .. " has won this race!" )
	end

end

function pm:CompleteLap()

	if self.laps == nil then self.laps = 0 end

	self.lastcheckpoint = {checkpoint = 0}
	self.laps = self.laps + 1

	print('Laps completed: ' .. self.laps)

	net.Start("mr_notifylapcomplete")
		net.WriteUInt( self.laps , 8 )
	net.Send( self )

	if tonumber(self.laps) >= tonumber(MR.LapsForVictory) then
		self:AnnounceWinner()
	end

end

function pm:PassCheckpoint( ent )

	if self.lastcheckpoint.checkpoint == nil then return end
	if !(tonumber(MR_ROUNDSTATE) == 1) then return end

	if tonumber(ent.checkpoint) == tonumber(self.lastcheckpoint.checkpoint + 1) then
		
		if tonumber(ent.checkpoint) == tonumber(MR_FINISH.checkpoint) then
			self:CompleteLap()
		else
			self.lastcheckpoint = ent
			print('Passed checkpoint ' .. ent.checkpoint)
		end

	end

end