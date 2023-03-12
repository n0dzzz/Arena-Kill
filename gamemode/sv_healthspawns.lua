AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

--

timer.Create("HealthSpawnsTimer", 30, 0, function()

    local Spawns = ents.FindByClass("info_player_start")
    local Ran = math.random(#Spawns)
    local Option = math.random( 1, 4)
    local LargeHealthKit = ents.Create("item_healthkit")
    local SmallHealthKit = ents.Create("item_healthvial")
    local ArmorKit = ents.Create("item_battery")

    local PistolAmmo = ents.Create("item_ammo_pistol_large")
    local HeavyAmmo = ents.Create("item_ammo_357_large")
    local SmgAmmo= ents.Create("item_ammo_smg1_large")
    local ShotgunAmmo = ents.Create("item_box_buckshot")
    local ArAmmo = ents.Create("item_ammo_ar2_large")

    if (Option == 1) then
        LargeHealthKit:SetPos(Spawns[Ran]:GetPos() + Vector(0, math.random( 0, 50), 0))
        LargeHealthKit:Spawn()
    end

    if (Option == 2) then
        SmallHealthKit:SetPos(Spawns[Ran]:GetPos() + Vector(0, math.random( 50, 100), 0))
        SmallHealthKit:Spawn()
    end

    if (Option == 3) then
        ArmorKit:SetPos(Spawns[Ran]:GetPos() + Vector(0, math.random( 0, 50), 50))
        ArmorKit:Spawn()
    end

    if (Option == 4) then
        PistolAmmo:SetPos(Spawns[Ran]:GetPos() + Vector(0, math.random( 25, 50), 0))
        PistolAmmo:Spawn()

        HeavyAmmo:SetPos(Spawns[Ran]:GetPos() + Vector(0, math.random( 25, 50), 0))
        HeavyAmmo:Spawn()

        SmgAmmo:SetPos(Spawns[Ran]:GetPos() + Vector(0, math.random( 25, 50), 0))
        SmgAmmo:Spawn()

        ShotgunAmmo:SetPos(Spawns[Ran]:GetPos() + Vector(0, math.random( 25, 50), 0))
        ShotgunAmmo:Spawn()

        ArAmmo:SetPos(Spawns[Ran]:GetPos() + Vector(0, math.random( 25, 50), 0))
        ArAmmo:Spawn()
    end

end)