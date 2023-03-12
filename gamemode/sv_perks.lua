util.AddNetworkString("RecievePerk")

net.Receive("RecievePerk", function(len, ply)
	local NetTable = net.ReadTable()
	if NetTable[1] == "x2 Health" then 
        ply:SetHealth(200) 
    end

	if NetTable[1] == "Resupply" then
		ply:Give("item_ammo_357_large")
        ply:Give("item_ammo_ar2_large")
        ply:Give("item_box_buckshot")
        ply:Give("item_ammo_pistol_large")
        ply:Give("item_ammo_smg1_large")
        ply:Give("item_battery")
        ply:Give("item_battery")
        ply:Give("item_battery")
        ply:Give("item_battery")
        ply:Give("item_healthkit")
        ply:Give("item_healthkit")
        ply:Give("item_healthkit")
	end

	if NetTable[1] == "Crossbow" then
		ply:Give("mg_crossbow")
		ply:Give("item_ammo_crossbow")
	end

	if NetTable[1] == "Second Chance" then		
        ply:SetNWBool("SecondChancePerk", true)     
	end

	if NetTable[1] == "Juggernaut" then
		ply:SetHealth(500)
	end
    
	ply:SetNWInt("MoneyAmount", ply:GetNWInt"MoneyAmount" - tonumber(NetTable[#NetTable]))
end)