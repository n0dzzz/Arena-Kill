util.AddNetworkString("RecieveWeapon")

include("shared.lua")

net.Receive("RecieveWeapon", function(len, ply)
    local NetTable = net.ReadTable()
    
    ply:Give(tostring(NetTable[1]))

    ply:SetNWInt("PlayerMoney",ply:GetNWInt("PlayerMoney") - tonumber(NetTable[#NetTable]))
end)