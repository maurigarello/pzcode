local function checkitemisok(itemtype,item)
    if itemtype==nil then return false end
    local itemz = ScriptManager.instance:getItem(itemtype)
    -- print(itemz)

    -- print(instanceof(itemz, "Moveable"))

    if itemz then
        if itemz:getCount() >1 then
            return false
        
        elseif instanceof(item, "DrainableComboItem") and item:getUsedDelta() ~=1 then
            return false
        elseif (instanceof(item, "HandWeapon") or instanceof(item, "Clothing")) and luautils.round(item:getCondition(),3)~=luautils.round(item:getConditionMax(),3) then
            return false
        elseif instanceof(item, "Food") and tonumber(string.format("%.2f", 100-item:getAge()/item:getOffAgeMax()*100)) < 50 then
            return false
        else
            return true
        end
        
    else
        return false
    end
    


end




local function OnlineshopOnPlayerUpdate(player)
    local inventory = player:getInventory():getItems()
    local itemlist = {}
    for i = 0, inventory:size() -1 do
        local item = inventory:get(i)
        local itemType = item:getFullType()
        local isBroken = item:isBroken()
        if not ( item:isEquipped() or item:isFavorite() ) and checkitemisok(itemType,item) then
            if itemlist[itemType]==nil then
                itemlist[itemType] = {itemtype = itemType,price = 0,quantity = 0,tag = "playerinv",spclo = 3}
                
            end
            if itemlist[itemType].itemtable==nil then
                itemlist[itemType].itemtable={}
            end
            table.insert(itemlist[itemType].itemtable,item)
            itemlist[itemType].quantity = itemlist[itemType].quantity+1
        end

    end

    local playerusername = player:getUsername()
    local noindex=0
    for k , v in pairs(Onlineshopinfo.baseplayershop) do
        if v.username ==playerusername then
            itemlist[k] = v
            itemlist[k].spclo = 2
            noindex=noindex+1
        end
    end
    Onlineshopinfo.currentupitem = noindex
    Onlineshopinfo.playerinv=itemlist
end

Events.OnPlayerUpdate.Add(OnlineshopOnPlayerUpdate)




--getmoneytoplayer2(catcat,2000)


local function Onlineshop_OnGameStart()
    sendClientCommand("Onlineshopstart","true",{getPlayer():getUsername()})
    -- sendClientCommand("Onlineshopsgiftupdate","true",{getPlayer():getUsername()})
    -- Events.EveryTenMinutes.Remove(Onlineshop_OnGameStart)
    
end
Events.EveryTenMinutes.Add(Onlineshop_OnGameStart)



local function Onlineshop_EveryDays()
    sendClientCommand("Onlineshop_EveryDays","true",{getPlayer():getUsername()})
end

local function Onlineshop_EveryOneMinute()
    if Onlinetest.instance then
        Onlinetest.instance:update_()
    end
	
end

Events.EveryOneMinute.Add(Onlineshop_EveryOneMinute)

Events.EveryDays.Add(Onlineshop_EveryDays)