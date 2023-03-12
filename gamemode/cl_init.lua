include( "shared.lua" )
include( "cl_hud.lua" )
include( "cl_scoreboard.lua" )
include( "cl_purchasemenu.lua" )
--

print("[ " .. util.DateStamp() .. " ] " .. "Arena Kill Game Started on Map " .. game.GetMap())

timer.Create("Announcments", 300, 0, function()

    print("Arena Kill developed by n0dzzz")
    print("github.com/n0dzzz")

end)

hook.Add("Think", "CheckWin", function()
    
    if (LocalPlayer():Frags() >= 2) then
        LocalPlayer():SetNWString("WinnerName", LocalPlayer():GetName())
        net.Start("EndGame")
        net.SendToServer()
    end

end)