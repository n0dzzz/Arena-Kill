AddCSLuaFile( "shared.lua" )
AddCSLuaFile("cl_init.lua")

include( "shared.lua" )

--

local Hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudWeapon"] = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( Hide[ name ] ) then
		return false
	end
end )

hook.Add("HUDPaint", "ArenaHud", function()
    
    draw.RoundedBox(4, 0, surface.ScreenHeight() - 30, surface.ScreenWidth(), 30, Color(45,45,45, 144))
    draw.RoundedBox(4 + 3, 0 + 2.5, surface.ScreenHeight() - 28, surface.ScreenWidth() * (LocalPlayer():GetNWInt("PlayerRankProgress") / LocalPlayer():GetNWInt("MaxPlayerRankProgress")) , 30 - 4, Color(255,255,255, 195))

    draw.SimpleTextOutlined("To set walk bind type in your console ] bind key \"+walk\" ", "Trebuchet18", surface.ScreenWidth() * 0.14, surface.ScreenHeight() * 0.02, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 0.5, 0.5, Color(45,45,45))
    draw.SimpleTextOutlined("First to 45 kills wins", "Trebuchet18", surface.ScreenWidth() * 0.062, surface.ScreenHeight() * 0.045, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 0.5, 0.5, Color(45,45,45))

    draw.SimpleTextOutlined("[Walk Bind] " .. "Open Purchase Menu", "Trebuchet18", surface.ScreenWidth() * 0.09, surface.ScreenHeight() * 0.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 0.5, 0.5, Color(45,45,45))

    draw.SimpleTextOutlined("Level " .. LocalPlayer():GetNWInt("PlayerRank"), "Trebuchet24", surface.ScreenWidth() * 0.04, surface.ScreenHeight() - 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 2,2, Color(45,45,45))

    draw.SimpleTextOutlined("$" .. LocalPlayer():GetNWInt("PlayerMoney") , "Trebuchet24", surface.ScreenWidth() * 0.96, surface.ScreenHeight() - 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 2,2, Color(45,45,45))

    draw.SimpleTextOutlined("Health: " .. LocalPlayer():Health(), "Trebuchet24", surface.ScreenWidth() * 0.35, surface.ScreenHeight() - 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 2,2, Color(45,45,45))

    draw.SimpleTextOutlined("Armor: " .. LocalPlayer():Armor(), "Trebuchet24", surface.ScreenWidth() * 0.65, surface.ScreenHeight() - 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 2,2, Color(45,45,45))

    if (IsValid(LocalPlayer():GetActiveWeapon())) then
        draw.SimpleTextOutlined(LocalPlayer():GetActiveWeapon():GetPrintName() .. " : " .. LocalPlayer():GetActiveWeapon():Clip1() .. " / " .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Trebuchet24", surface.ScreenWidth() * 0.5, surface.ScreenHeight() - 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 2,2, Color(45,45,45))
    end

end)
