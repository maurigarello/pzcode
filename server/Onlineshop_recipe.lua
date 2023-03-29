


function Recipe.OnCreate.os_getplayermoney(items, result, player)
    for i=1,items:size() do
        local itemz = items:get(i-1)
        local itemtype = itemz:getFullType()
        print(itemtype)
        if itemtype=="Base.CreditCard" then
            Onlineshopfunction.getmoneytoplayer2(itemz:getName(),100)
            

        elseif itemtype=="Base.CreditCard1000" then
            Onlineshopfunction.getmoneytoplayer2(itemz:getName(),1000)
            
        end
    end
end

function Recipe.OnCreate.os_getyourselfmoney(items, result, player)
    for i=1,items:size() do
        local itemz = items:get(i-1)
        local itemtype = itemz:getFullType()
        if itemtype=="Base.CreditCard" then
            Onlineshopfunction.getmoneytoplayer(100)
            

        elseif itemtype=="Base.CreditCard1000" then
            Onlineshopfunction.getmoneytoplayer(1000)
            
        end
    end
end

function Recipe.OnCreate.uploaddailygift(items, result, player)
    local itemz = items:get(0)
    local itemlist ={}
    local giftlisttable={
        {--每日礼包
        typename = "daily_gift",
        itemlist = {
        },
        isallplayer = true,
        playerlist ={},
        info = {"every day"}
    }
    }

    if itemz then
        local invconitem = itemz:getItemContainer():getItems()
        for i=1,invconitem:size() do
            if itemlist[invconitem:get(i-1):getFullType()] == nil then
                itemlist[invconitem:get(i-1):getFullType()]=0
                
            end
            itemlist[invconitem:get(i-1):getFullType()] =itemlist[invconitem:get(i-1):getFullType()]+1

        end
    end

    for k,v in pairs(itemlist) do
        table.insert(giftlisttable[1].itemlist,{k,v})
    end
    -- Onlineshopfunction.uploadservergift(giftlisttable)
    sendClientCommand("uploadservergift","true",giftlisttable)


    
end

function Recipe.OnCreate.uploadnormalgift(items, result, player)
    local itemz = items:get(0)
    local itemlist ={}
    local giftlisttable={
        {--普通礼包(一次性)
        typename = "normal_gift",
        itemlist = {  
        },
        isallplayer = false,
        playerlist ={},
        info = {"normal"}
    }
    }
    local playername = itemz:getName()

    if itemz then
        local invconitem = itemz:getItemContainer():getItems()
        for i=1,invconitem:size() do
            if itemlist[invconitem:get(i-1):getFullType()] == nil then
                itemlist[invconitem:get(i-1):getFullType()]=0
                
            end
            itemlist[invconitem:get(i-1):getFullType()] =itemlist[invconitem:get(i-1):getFullType()]+1

        end
    end

    for k,v in pairs(itemlist) do
        table.insert(giftlisttable[1].itemlist,{k,v})
    end
    giftlisttable[1].playerlist={playername}
    sendClientCommand("uploadservergift","true",giftlisttable)


    
end