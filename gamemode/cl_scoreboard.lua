AddCSLuaFile( "shared.lua" )
AddCSLuaFile("cl_init.lua")

include( "shared.lua" )

--
local ScoreboardBase

local function CreateScoreboard(ToggleScoreboard)
    if ToggleScoreboard then
        ScoreboardBase = vgui.Create("DFrame")
        ScoreboardBase:SetTitle("")
        ScoreboardBase:SetSize(ScrW() * 0.5, ScrH() * 0.6)
        ScoreboardBase:Center()
        ScoreboardBase:ShowCloseButton(false)
        ScoreboardBase:SetDraggable(false)
        ScoreboardBase:MakePopup()
        ScoreboardBase.Paint = function(self,w,h)
            surface.SetDrawColor(45,45,45,225)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(255,255,255)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.SimpleText("Name", "Trebuchet18", w * 0.15, h * 0.03 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Kills", "Trebuchet18", w * 0.30, h * 0.03 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Deaths", "Trebuchet18", w * 0.45, h * 0.03 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Money", "Trebuchet18", w * 0.60 , h * 0.03 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Rank", "Trebuchet18", w * 0.75 , h * 0.03 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Ping", "Trebuchet18", w * 0.90 , h * 0.03 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        local ypos = 0
        local PlayerScrollPanel = vgui.Create("DScrollPanel",ScoreboardBase)
        PlayerScrollPanel:SetPos(3,ScoreboardBase:GetTall() * 0.05)
        PlayerScrollPanel:SetSize(ScoreboardBase:GetWide() - 6,ScoreboardBase:GetTall() * 0.95)
        for k,v in pairs(player.GetAll()) do
            local PlayerPanel = vgui.Create("DPanel", PlayerScrollPanel)
            PlayerPanel:SetPos(0,ypos)
            PlayerPanel:SetSize(PlayerScrollPanel:GetWide(),PlayerScrollPanel:GetTall() * 0.05)
            
            local PlayerName = v:Name()
            local PlayerMoney = v:GetNWInt("PlayerMoney")
            local PlayerRank = v:GetNWInt("PlayerRank")
            local PlayerPing = v:Ping()
            local PlayerKills = v:Frags()
            local PlayerDeaths = v:Deaths()

            if v:GetNWString("BackgroundColor") == "" then v:SetNWString("BackgroundColor", tostring(ColorRand())) end
            PlayerPanel.Paint = function(self,w,h)
                if IsValid(v) then
                    surface.SetDrawColor(255,255,255)
                    surface.DrawRect(0, 0, w, h)
                    draw.SimpleText(PlayerName, "Trebuchet18", w * 0.15 , h /2 , Color(45,45,45), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText(PlayerKills, "Trebuchet18", w * 0.30 , h /2 , Color(45,45,45), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText(PlayerDeaths, "Trebuchet18", w * 0.45 , h /2 , Color(45,45,45), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText("$"..tostring(PlayerMoney), "Trebuchet18", w * 0.6 , h /2 , Color(45,45,45), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText(PlayerRank, "Trebuchet18", w * 0.75 , h /2 , Color(45,45,45), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText(PlayerPing, "Trebuchet18", w * 0.9 , h /2 , Color(45,45,45), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
            ypos = ypos + PlayerPanel:GetTall() * 1.1
        end
    else
        if IsValid(ScoreboardBase) then
            ScoreboardBase:Remove()
        end
    end
end

hook.Add("ScoreboardShow", "OpenScoreboard", function()
    CreateScoreboard(true)
    return false
end)

hook.Add("ScoreboardHide", "CloseScoreboard", function()
    CreateScoreboard(false)
end)