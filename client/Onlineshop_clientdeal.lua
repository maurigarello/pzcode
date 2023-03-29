local function scrollingupdate()
    -- print("clientfunction")
    if Onlinetest.instance then
        if Onlineshopinfo.currentshop.index == "basesysshop" then
            Onlineshopinfo.currentshop.content = Onlineshopinfo.basesysshop
        elseif Onlineshopinfo.currentshop.index == "baseplayershop" then
            Onlineshopinfo.currentshop.content = Onlineshopinfo.baseplayershop
        elseif Onlineshopinfo.currentshop.index == "playerinv" then
            Onlineshopinfo.currentshop.content = Onlineshopinfo.playerinv
        elseif Onlineshopinfo.currentshop.index == "giftbag" then
            Onlineshopinfo.currentshop.content = Onlineshopinfo.giftbag
        elseif Onlineshopinfo.currentshop.index == "fuwuqigonggao" then
            Onlineshopinfo.currentshop.content = Onlineshopinfo.fuwuqigonggao 
        end
        Onlinetest.instance:update_()
        -- print("clientupdateinsetance")
    end
    
end


local function Os_OnServerCommand(module, command, arguments)
    local player=getPlayer()
    if module=="os_sysshopupdate" then
        
        Onlineshopinfo.basesysshop = arguments or {}
        scrollingupdate()
        -- print("clientsys")
    elseif module=="os_baseplayershopupdate" then
        Onlineshopinfo.baseplayershop = arguments or {}
        scrollingupdate()
    elseif module=="os_giftbagupdate" then
        -- print("giftlistupdate")
        local giftlist = arguments[player:getUsername()]
        -- print(giftlist)
        Onlineshopinfo.giftbag={}
        for i,v in pairs(giftlist) do
            -- print(i)
            Onlineshopinfo.giftbag[i] = {
                itemtype = i,price = 0,quantity=v,username = "Admin" ,uptime =getText("IGUI_libao")
            }
        
        end
        scrollingupdate()
    elseif module=="os_fuwuqigonggaoupdate" then
        Onlineshopinfo.fuwuqigonggao = arguments or {}
        scrollingupdate()
    elseif module=="os_playermoneyupdate" then
        Onlineshopinfo.currentmoney = arguments[player:getUsername()] or 0
        -- print("money:  ",Onlineshopinfo.currentmoney)
        scrollingupdate()
    elseif module=="os_getplayeritem" then
        player:getInventory():AddItems(arguments[1],arguments[2])
        scrollingupdate()
        -- print(arguments[1],type(arguments[2]))
    elseif module=="os_allinfoupdate" then
        scrollingupdate()
    end
end
Events.OnServerCommand.Add(Os_OnServerCommand)