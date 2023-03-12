util.AddNetworkString("EndGame")

include("shared.lua")

local EndGameVar = true
local WinnerName

net.Receive("EndGame",function(len,ply)
    if EndGameVar then
        EndGameVar = false
        for k,v in pairs(player.GetAll()) do

            if(v:Frags() >= 45) then
                WinnerName = v:GetName()
            end

            v:PrintMessage( HUD_PRINTCENTER, "Game Over " .. WinnerName .. " Wins!" )
            
        end
        timer.Simple(5, function()
            RunConsoleCommand("changelevel", game.GetMap())
        end)
    end
end)
