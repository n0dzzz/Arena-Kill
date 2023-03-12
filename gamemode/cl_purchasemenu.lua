AddCSLuaFile( "shared.lua" )
AddCSLuaFile("cl_init.lua")

include( "shared.lua" )

--

local Weapons = {
    -- {"Name", Price, Level Requirment, "Class", "Model"},

    {"Deagle", 2500, 50, "mg_deagle", "models/viper/mw/weapons/v_deagle.mdl"}, -- pistol
    {".357", 1500, 20, "mg_357", "models/viper/mw/weapons/v_357.mdl"},   
    {"Glock", 500, 5, "mg_glock", "models/viper/mw/weapons/v_glock.mdl"},

    {"MP7", 4500, 38, "mg_mpapa7", "models/viper/mw/weapons/v_mpapa7.mdl"}, -- smg
    {"MP5", 3000, 22, "mg_mpapa5", "models/viper/mw/weapons/v_mpapa5.mdl"},   
    {"ISO", 1750, 8, "mg_charlie9", "models/viper/mw/weapons/v_charlie9.mdl"},

    {"RAM-7", 4500, 44, "mg_tango21", "models/viper/mw/weapons/v_tango21.mdl"}, -- ar
    {"M4A1", 3000, 30, "mg_mike4", "models/viper/mw/weapons/v_mike4.mdl"},   
    {"FAL", 1750, 13, "mg_falima", "models/viper/mw/weapons/v_falima.mdl"},
    
    {"Jak-12", 8250, 48, "mg_aalpha12", "models/viper/mw/weapons/v_aalpha12.mdl"}, -- shotgun
    {"Model 680", 5000, 38, "mg_romeo870", "models/viper/mw/weapons/v_romeo870.mdl"},   
    {"725", 3000, 25, "mg_charlie725", "models/viper/mw/weapons/v_charlie725.mdl"},

    {"SKS", 4500, 50, "mg_sksierra", "models/viper/mw/weapons/v_sksierra.mdl"}, -- sniper
    {"SPR", 3000, 42, "mg_romeo700", "models/viper/mw/weapons/v_romeo700.mdl"},   
    {"MK2 Carbine", 1750, 33, "mg_sbeta", "models/viper/mw/weapons/v_sbeta.mdl"},
}

local Perks = {
    -- {"Name", Price, Level Requirment},

    {"Double Health", 1, 5},
    {"Resupply", 1, 14},
    {"Crossbow", 1, 24},
    {"Juggernaut", 1, 50 },

}

local function CreateGuiWeapons()
    local Frame = vgui.Create("DFrame")
    Frame:SetTitle("Weapons")
    Frame:SetDraggable(true)
    Frame:SetSize(800,500)
    Frame:SetPos(100, 150)
    Frame:MakePopup()
    Frame.Paint = function(self, w, h)
        surface.SetDrawColor(Color(45,45,45))
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(Color(255,255,255))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local DScrollPanel = vgui.Create("DScrollPanel", Frame)
    DScrollPanel:Dock(FILL)
    local YPos = 5
    for k,v in pairs(Weapons) do

        local ItemPanel = vgui.Create("DPanel", DScrollPanel)
        ItemPanel:SetPos(0,YPos)
        ItemPanel:SetBackgroundColor(Color(45,45,45))
        ItemPanel:SetSize(Frame:GetWide() -10,Frame:GetTall() * 0.2)
        local model = vgui.Create("DModelPanel", ItemPanel)
        model:SetPos(10,0)
        model:SetModel(tostring(v[5]))
        model:SetSize(100,100)
        model:SetFOV(40)
        model:SetCamPos(Vector(50, 0, 0))
        model:SetLookAt(Vector(0, 0, 0))
        function model:LayoutEntity(ent)
            ent:SetAngles(Angle(0, RealTime()*100,  0))
        end
        
        local ItemLabel = vgui.Create("DLabel", ItemPanel)
        ItemLabel:SetPos((ItemPanel:GetWide() * 0.4) - 80, 0)
        ItemLabel:SetSize(1000,100)
        ItemLabel:SetColor(Color(255,255,255))
        ItemLabel:SetFont("Trebuchet18")
        ItemLabel:SetText(tostring(v[1]))

        local ItemLabel = vgui.Create("DLabel", ItemPanel)
        ItemLabel:SetPos((ItemPanel:GetWide() * 0.6) - 80, 0)
        ItemLabel:SetSize(1000,100)
        ItemLabel:SetColor(Color(255,255,255))
        ItemLabel:SetFont("Trebuchet18")
        ItemLabel:SetText("Level Requirment: " .. tostring(v[3]))

        local ItemButton = vgui.Create("DButton", ItemPanel)
        ItemButton:SetFont("Trebuchet18")
        ItemButton:SetPos(ItemPanel:GetWide() - 140, 30)
        ItemButton:SetSize(95,40)
        ItemButton:SetText("$"..tostring(v[2]))
        ItemButton:SetColor(Color(255,255,255))
        ItemButton.Paint = function(self, w, h)
            ItemButton:SetColor(Color(255,255,255))
            surface.SetDrawColor(Color(255,255,255))
            surface.DrawOutlinedRect(0, 0, w, h,2)
            
            if self:IsHovered() then
                surface.SetDrawColor(Color(0,250,0))
                surface.DrawOutlinedRect(0, 0, w, h,2)
                ItemButton:SetColor(Color(0,250,0))
            end
        end

        function ItemButton:DoClick()
            if LocalPlayer():GetNWInt("PlayerMoney") >= v[2] and LocalPlayer():GetNWInt("PlayerRank") >= v[3]  then
                for index,weapon in pairs(LocalPlayer():GetWeapons()) do
                    if weapon:GetClass() == v[4] then
                        notification.AddLegacy("You already have that weapon.", 2, 2)
                        surface.PlaySound("physics/surfaces/sand_impact_bullet1.wav")
                        return
                    end
                end

                net.Start("RecieveWeapon")
                    net.WriteTable({v[4],v[1],v[2]})
                net.SendToServer()
                surface.PlaySound("buttons/bell1.wav")
                notification.AddLegacy("You successfully purchased ".. v[1] .. ".", 0, 2)
            else
                notification.AddLegacy("You don't have enough money or are too low level for that.", 1, 2)
                surface.PlaySound("physics/surfaces/sand_impact_bullet1.wav")
            end
        end


        YPos = YPos + ItemPanel:GetTall() * 1.1 
    end
end

local function CreateGuiPerks()
    local Frame = vgui.Create("DFrame")
    Frame:SetTitle("Perks")
    Frame:SetDraggable(true)
    Frame:SetSize(400,500)
    Frame:SetPos(950, 150)
    Frame:MakePopup()
    Frame.Paint = function(self, w, h)
        surface.SetDrawColor(Color(45,45,45))
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(Color(255,255,255))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local DScrollPanel = vgui.Create("DScrollPanel", Frame)
    DScrollPanel:Dock(FILL)
    local YPos = 5
    for k,v in pairs(Perks) do

        local ItemPanel = vgui.Create("DPanel", DScrollPanel)
        ItemPanel:SetPos(0,YPos)
        ItemPanel:SetBackgroundColor(Color(45,45,45))
        ItemPanel:SetSize(Frame:GetWide() -10,Frame:GetTall() * 0.2)
        
        local ItemLabel = vgui.Create("DLabel", ItemPanel)
        ItemLabel:SetPos((ItemPanel:GetWide() * 0.4) - 150, 0)
        ItemLabel:SetSize(150,100)
        ItemLabel:SetColor(Color(255,255,255))
        ItemLabel:SetFont("Trebuchet18")
        ItemLabel:SetText(tostring(v[1]))

        local ItemLabel = vgui.Create("DLabel", ItemPanel)
        ItemLabel:SetPos((ItemPanel:GetWide() * 0.6) - 60, 0)
        ItemLabel:SetSize(150,100)
        ItemLabel:SetColor(Color(255,255,255))
        ItemLabel:SetFont("Trebuchet18")
        ItemLabel:SetText("Level Requirment: " .. tostring(v[3]))

        local ItemButton = vgui.Create("DButton", ItemPanel)
        ItemButton:SetFont("Trebuchet18")
        ItemButton:SetPos(ItemPanel:GetWide() - 60, 30)
        ItemButton:SetSize(45,40)
        ItemButton:SetText("$"..tostring(v[2]))
        ItemButton:SetColor(Color(255,255,255))
        ItemButton.Paint = function(self, w, h)
            ItemButton:SetColor(Color(255,255,255))
            surface.SetDrawColor(Color(255,255,255))
            surface.DrawOutlinedRect(0, 0, w, h,2)
            
            if self:IsHovered() then
                surface.SetDrawColor(Color(0,250,0))
                surface.DrawOutlinedRect(0, 0, w, h,2)
                ItemButton:SetColor(Color(0,250,0))
            end
        end

        function ItemButton:DoClick()
            if LocalPlayer():GetNWInt("PlayerMoney") >= v[2] and LocalPlayer():GetNWInt("PlayerRank") >= v[3]  then

                net.Start("RecievePerk")
                    net.WriteTable({v[1],v[2],v[3]})
                net.SendToServer()

                surface.PlaySound("buttons/bell1.wav")
                notification.AddLegacy("You successfully purchased ".. v[1] .. ".", 0, 2)
            else
                notification.AddLegacy("You don't have enough money or are too low level for that.", 1, 2)
                surface.PlaySound("physics/surfaces/sand_impact_bullet1.wav")
            end
        end


        YPos = YPos + ItemPanel:GetTall() * 1.1 
    end
end

hook.Add( "KeyPress", "PurchaseMenuOpen", function( ply, key )
	if ( key == IN_WALK ) then
		CreateGuiWeapons()
        CreateGuiPerks()
	end
end )