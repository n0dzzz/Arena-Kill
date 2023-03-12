AddCSLuaFile("sv_healthspawns.lua")
AddCSLuaFile("sv_money.lua")
AddCSLuaFile("sv_rank.lua")
AddCSLuaFile( "sv_purchasemenu.lua" )
AddCSLuaFile( "sv_perks.lua" )
AddCSLuaFile( "sv_endgame.lua" )

include( "shared.lua" )
include( "sv_healthspawns.lua" )
include( "sv_money.lua" )
include( "sv_rank.lua" )
include( "sv_purchasemenu.lua" )
include( "sv_perks.lua" )
include( "sv_endgame.lua" )
--

hook.Add("PlayerSpawn", "SpawnStartup", function(ply)

    ply:UnSpectate()
    ply:StripWeapons()
    local sboxweapons = GetConVar("sbox_weapons")
    sboxweapons:SetBool(false)

    GetConVar("mgbase_sv_customization"):SetBool(true)
    ply:Give("mg_m1911") 
    ply:Give("item_ammo_pistol_large") 
    ply:PrintMessage(HUD_PRINTCONSOLE, "bind m \"+walk\" ")
end)