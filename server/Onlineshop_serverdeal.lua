-- if not isServer() then return end


local function Os_OnClientCommand(module, command, player,arguments)

    local gametime = getGameTime()
    -- if gametime:getModData().Onlineshopinfo==nil then
    --     gametime:getModData().Onlineshopinfo={}
    -- end

    if module=="os_sysshopsell" then
        -- if gametime:getModData().Onlineshopinfo.basesysshop == nil then
        --     gametime:getModData().Onlineshopinfo.basesysshop={}
        -- end
        gametime:getModData().Onlineshopinfo.basesysshop[arguments[1]] = {itemtype = arguments[2],price = arguments[3],quantity=-1,username="Admin",uptime =arguments[4] }
        sendServerCommand("os_sysshopupdate", "true",gametime:getModData().Onlineshopinfo.basesysshop)
    elseif module=="os_buyone" then
        -- if gametime:getModData().Onlineshopinfo.playermoney ==nil then
        --     gametime:getModData().Onlineshopinfo.playermoney ={}
        -- end
        
        gametime:getModData().Onlineshopinfo.playermoney[arguments[1]] = gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]-arguments[3]
        sendServerCommand(player,"os_getplayeritem", "true",{arguments[2],1}) 
        sendServerCommand(player,"os_playermoneyupdate", "true",gametime:getModData().Onlineshopinfo.playermoney) 
    elseif module=="os_buyall" then
        if gametime:getModData().Onlineshopinfo.playermoney ==nil then
            gametime:getModData().Onlineshopinfo.playermoney ={}
        end
        if gametime:getModData().Onlineshopinfo.playermoney[arguments[1]] ==nil then
            gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]=0
        end
        if gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]< arguments[3] then return end
        gametime:getModData().Onlineshopinfo.playermoney[arguments[1]] = gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]-arguments[3]
        sendServerCommand(player,"os_getplayeritem", "true",{arguments[2],arguments[4]}) 
        sendServerCommand(player,"os_playermoneyupdate", "true",gametime:getModData().Onlineshopinfo.playermoney) 
    elseif  module=="os_addmoney" then
        
        if gametime:getModData().Onlineshopinfo.playermoney[arguments[1]] ==nil then
            gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]=0
        end
        gametime:getModData().Onlineshopinfo.playermoney[arguments[1]] = gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]+arguments[2]
        sendServerCommand(player,"os_playermoneyupdate", "true",gametime:getModData().Onlineshopinfo.playermoney) 
    elseif module=="os_removesys" then
        -- table.remove(gametime:getModData().Onlineshopinfo.basesysshop,arguments[1])
        gametime:getModData().Onlineshopinfo.basesysshop[arguments[1]]=nil
        sendServerCommand("os_sysshopupdate", "true",gametime:getModData().Onlineshopinfo.basesysshop)
        -- print(arguments[1])
    elseif module=="Onlineshopstart" then
        if gametime:getModData().Onlineshopinfo==nil then
            gametime:getModData().Onlineshopinfo={basesysshop={},baseplayershop={},playerinv={},giftbag={},playermoney={},fuwuqigonggao={},currentshop={index = "basesysshop",content={}}}
        end
        -- if gametime:getModData().Onlineshopinfo.playermoney ==nil then
        --     gametime:getModData().Onlineshopinfo.playermoney ={}
        -- end
        if gametime:getModData().Onlineshopinfo.playermoney[arguments[1]] ==nil then
            gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]=100
        end
        if gametime:getModData().Onlineshopinfo.giftbag ==nil then gametime:getModData().Onlineshopinfo.giftbag ={} end
        if gametime:getModData().Onlineshopinfo.giftbag[arguments[1]]==nil then
            gametime:getModData().Onlineshopinfo.giftbag[arguments[1]] = {}
        end
        -- print()
        sendServerCommand("os_sysshopupdate", "true",gametime:getModData().Onlineshopinfo.basesysshop)
        sendServerCommand("os_baseplayershopupdate", "true",gametime:getModData().Onlineshopinfo.baseplayershop)
        sendServerCommand("os_giftbagupdate", "true",gametime:getModData().Onlineshopinfo.giftbag)
        sendServerCommand("os_fuwuqigonggaoupdate", "true",gametime:getModData().Onlineshopinfo.fuwuqigonggao)
        sendServerCommand(player,"os_playermoneyupdate", "true",gametime:getModData().Onlineshopinfo.playermoney) 
    elseif module=="removeallinfozksl" then
        gametime:getModData().Onlineshopinfo=nil


    elseif module=="os_playershopsell" then
        if gametime:getModData().Onlineshopinfo.baseplayershop ==nil then
            gametime:getModData().Onlineshopinfo.baseplayershop={}
        end
        gametime:getModData().Onlineshopinfo.baseplayershop[arguments[1]] = {itemtype = arguments[3],price = arguments[4],quantity=arguments[5],username = arguments[2] ,uptime =arguments[6] }
        sendServerCommand("os_baseplayershopupdate", "true",gametime:getModData().Onlineshopinfo.baseplayershop)
        


    elseif module=="os_buyoneplayershop" then

        local selectitem = gametime:getModData().Onlineshopinfo.baseplayershop[arguments[2]]
        if selectitem==nil then return end
        local itemtype_ = selectitem.itemtype
        local price_ = selectitem.price
        local player_ = selectitem.username
        if selectitem.quantity >1 then
            gametime:getModData().Onlineshopinfo.baseplayershop[arguments[2]].quantity = gametime:getModData().Onlineshopinfo.baseplayershop[arguments[2]].quantity-1
        else
            gametime:getModData().Onlineshopinfo.baseplayershop[arguments[2]]=nil
        end
        gametime:getModData().Onlineshopinfo.playermoney[arguments[1]] = gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]-price_
        gametime:getModData().Onlineshopinfo.playermoney[player_] = gametime:getModData().Onlineshopinfo.playermoney[player_]+price_

        sendServerCommand(player,"os_getplayeritem", "true",{itemtype_,1})
        sendServerCommand("os_playermoneyupdate", "true",gametime:getModData().Onlineshopinfo.playermoney)
        sendServerCommand("os_baseplayershopupdate", "true",gametime:getModData().Onlineshopinfo.baseplayershop)
    elseif module=="os_buyallplayershop" then
        -- print("buyallserver")
        local selectitem = gametime:getModData().Onlineshopinfo.baseplayershop[arguments[2]]
        if selectitem==nil then return end
        local itemtype_ = selectitem.itemtype
        local price_ = selectitem.price
        local player_ = selectitem.username
        local buynumber = arguments[3]
        if gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]-price_*buynumber <0 then return end
        gametime:getModData().Onlineshopinfo.playermoney[arguments[1]] = gametime:getModData().Onlineshopinfo.playermoney[arguments[1]]-price_*buynumber
        gametime:getModData().Onlineshopinfo.playermoney[player_] = gametime:getModData().Onlineshopinfo.playermoney[player_]+price_*buynumber
        if selectitem.quantity >buynumber then
            gametime:getModData().Onlineshopinfo.baseplayershop[arguments[2]].quantity = gametime:getModData().Onlineshopinfo.baseplayershop[arguments[2]].quantity-buynumber
        elseif selectitem.quantity ==buynumber then
            gametime:getModData().Onlineshopinfo.baseplayershop[arguments[2]]=nil
        else
            -- print("buyallserverreturn")
            return
        end

        
        

        sendServerCommand(player,"os_getplayeritem", "true",{itemtype_,arguments[3]})
        sendServerCommand("os_playermoneyupdate", "true",gametime:getModData().Onlineshopinfo.playermoney)
        sendServerCommand("os_baseplayershopupdate", "true",gametime:getModData().Onlineshopinfo.baseplayershop)
    elseif module=="uploadservergift" then
        if gametime:getModData().Onlineshopinfo.giftbagserver ==nil then
            gametime:getModData().Onlineshopinfo.giftbagserver={}
        end
        if gametime:getModData().Onlineshopinfo.giftbag == nil then
            gametime:getModData().Onlineshopinfo.giftbag={}
        end

        for k,v in ipairs(arguments) do
            -- print(v.typename)
            if v.typename =="daily_gift" then
                gametime:getModData().Onlineshopinfo.giftbagserver.daily_gift=v.itemlist
            elseif v.isallplayer==false then
                if gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift==nil then
                    gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift={}
                end
                for z,x in ipairs(v.playerlist) do
                    -- print(x)
                    if gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift[x]  ==nil then
                        gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift[x]={}
                    end
                    for c,b in ipairs(v.itemlist) do
                        -- print(b[1])
                        -- print(ScriptManager.instance:getItem(b[1]))
                        
                        if ScriptManager.instance:getItem(b[1]) then
                            if gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift[x][b[1]]==nil then
                                gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift[x][b[1]]=0
                            end
                            gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift[x][b[1]]=gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift[x][b[1]]+b[2] 
                        end
                        
                    end
                    gametime:getModData().Onlineshopinfo.giftbag[x] = gametime:getModData().Onlineshopinfo.giftbagserver.nromalgift[x]


                    -- {itemtype = arguments[3],price = arguments[4],quantity=arguments[5],username = arguments[2] ,uptime =arguments[6] }



                    
                end
            end
        end
        


    elseif module=="Onlineshop_EveryDays" then
        if gametime:getModData().Onlineshopinfo.giftbagserver ==nil then
            gametime:getModData().Onlineshopinfo.giftbagserver={}
        end
        if gametime:getModData().Onlineshopinfo.giftbagserver.daily_gift ==nil then
            gametime:getModData().Onlineshopinfo.giftbagserver.daily_gift={}
        end
        for k,v in ipairs(gametime:getModData().Onlineshopinfo.giftbagserver.daily_gift) do

            if ScriptManager.instance:getItem(v[1]) then
                if gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][v[1]] ==nil then
                    gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][v[1]]=0
                end
                gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][v[1]]=gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][v[1]]+v[2]
            end
        end
        sendServerCommand(player,"os_giftbagupdate", "true",gametime:getModData().Onlineshopinfo.giftbag)

    elseif module=="os_buyonegiftbag" then
        if gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][arguments[2]]==nil then return end
        if gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][arguments[2]] and gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][arguments[2]]>1 then
            gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][arguments[2]] =gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][arguments[2]]-1
            
        else
            gametime:getModData().Onlineshopinfo.giftbag[arguments[1]][arguments[2]]=nil
            
        end
        sendServerCommand(player,"os_giftbagupdate", "true",gametime:getModData().Onlineshopinfo.giftbag)
        sendServerCommand(player,"os_getplayeritem", "true",{arguments[2],1})
        




    end





end
Events.OnClientCommand.Add(Os_OnClientCommand)