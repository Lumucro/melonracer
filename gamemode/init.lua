include( 'shared.lua' )
include( 'config.lua' )
include( 'player.lua' )
include( 'player_meta.lua' )

AddCSLuaFile( 'shared.lua' ) 
AddCSLuaFile( 'cl_hud.lua' )

util.AddNetworkString("mr_roundstate")
util.AddNetworkString("mr_getlaps")
util.AddNetworkString("mr_notifydeath")
util.AddNetworkString("mr_notifylapcomplete")
util.AddNetworkString("mr_notifywinner")

MR_FINISH = {checkpoint = 0, winner = nil}
MR_ROUNDSTATE = 0
MR_PAUSE = false

local function SendRoundState()

	net.Start("mr_roundstate")
		net.WriteUInt( MR_ROUNDSTATE, 8 )
	net.Broadcast()

end

local function NotifyDeath( ply )

	net.Start("mr_notifydeath")
		net.WriteBool( true )
	net.Send( ply )

end

function GM:Initialize()

	timer.Simple( MR.RacePrepareTime, function()

		StartRace()

	end)

end

function GM:PlayerDeathSound() 

	return false

end

function GM:Think()

	if MR_FINISH.winner != nil then return end // Game has ended
	if MR_PAUSE then return end // Game is paused

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
		
		NotifyDeath( target:GetOwner() )
		target:GetOwner():RespawnMelon( target:GetPos() )
		target:GetOwner():AddDeaths(1)

	end

	return dmg

end

function GM:EntityKeyValue( ent, key, value ) 

	if ent:GetClass() == "checkpoint" && key == "number" then
		
		ent.checkpoint = value

		if tonumber(value) > tonumber(MR_FINISH.checkpoint) then
			MR_FINISH = ent
		end

	end

	return true

end

function StartRace()

	for k,v in pairs(player.GetAll()) do

		v:KillSilent()
		v:SetFrags(0)
		v:SetDeaths(0)

	end

	MR_PAUSE = true
	MR_ROUNDSTATE = 1
	SendRoundState()

	timer.Simple(3, function()
		MR_PAUSE = false
	end)

end

function EndRace()

	print('Race ended!')

end