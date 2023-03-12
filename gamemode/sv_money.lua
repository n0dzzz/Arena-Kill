AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

--

hook.Add("PlayerInitialSpawn", "StartMoney", function(ply)
   
    ply:SetNWInt("PlayerMoney", 1000)

end)

hook.Add("PlayerDeath", "PlayerDeathMoneyAdd", function(victim, inflictor, attacker)
    
    attacker:SetNWInt("PlayerMoney", attacker:GetNWInt("PlayerMoney") + 250 + attacker:GetNWInt("PlayerRank") * 2.5)

end)