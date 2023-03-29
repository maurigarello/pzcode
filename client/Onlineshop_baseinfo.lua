Onlineshopinfo = {} 
Onlineshopinfo.basesysshop = {
    -- ["Base.Apple"] = {price = 10,quantity = 10000,tag = "System"},
    -- ["Base.Katana"] = {price = 100,quantity = 1000,tag = "System"},
    -- ["Base.Banana"] = {price = 5,quantity = 1000,tag = "System"}

}

Onlineshopinfo.baseplayershop = {
    -- ["Base.Apple"] = {price = 1000 ,quantity = 10000,tag = "System"},


}

Onlineshopinfo.playerinv = {


}

Onlineshopinfo.giftbag = {


}

Onlineshopinfo.fuwuqigonggao = {


}
--init
Onlineshopinfo.currentshop = {index="basesysshop",content={}}

Onlineshopinfo.currentmoney = 0

Onlineshopinfo.currentupitem = 0

----礼包系统

Onlineshopinfo.giftbagserver = {
    {--每日礼包
        typename = "daily_gift",
        itemlist = {
            {"Base.Apple",1},
            {"Base.Banana",1}
        },
        isallplayer = true,
        playerlist ={},
        info = {"every day"}
    },
    {--普通礼包(一次性)
        typename = "normal_gift",
        itemlist = {




            {"Base.Banana",1},
            {"Base.Katana",1}



            
    },
        isallplayer = false,
        playerlist ={"admis"},
        info = {"normal"}
    }
}

Onlineshopfunction = Onlineshopfunction or {}

function Onlineshopfunction.getmoneytoplayer(money)
    sendClientCommand("os_addmoney","true",{
        getPlayer():getUsername(),
        money
    })
end

function Onlineshopfunction.getmoneytoplayer2(name,money)
    sendClientCommand("os_addmoney","true",{
        name,
        money
    })
end

function Onlineshopfunction.uploadservergift()
    sendClientCommand("uploadservergift","true",Onlineshopinfo.giftbagserver)
end

function Onlineshopfunction.removeallinfozksl()
    sendClientCommand("removeallinfozksl","true",{
    })
end



local function showWindowToolbar()
    Simpleonline.OnOpenPanel()
end
local toolbarButton
local function addToolbarButton()
    if toolbarButton then
        return
    end

    print("newbutton")
    toolbarButton = ISButton:new(0, ISEquippedItem.instance.movableBtn:getY() + ISEquippedItem.instance.movableBtn:getHeight() + 350, 50, 50, "", nil, showWindowToolbar);
    toolbarButton:setImage(getTexture("media/textures/onlineshopbutton.png"));
    toolbarButton:setDisplayBackground(false);
    toolbarButton.borderColor = { r = 1, g = 1, b = 1, a = 0.1 };

    ISEquippedItem.instance:addChild(toolbarButton);
    ISEquippedItem.instance:setHeight(math.max(ISEquippedItem.instance:getHeight(), toolbarButton:getY() + 400));


end

local function button_EveryOneMinute()
    addToolbarButton()

    
	-- Your code here
end





local function OnLoad()
    addToolbarButton()
end

local function newgame_OnLoad()
    Events.OnPlayerMove.Add(button_EveryOneMinute)
    if toolbarButton then
        Events.OnPlayerMove.Remove(button_EveryOneMinute)
    end

end

Events.OnLoad.Add(OnLoad)
Events.OnNewGame.Add(newgame_OnLoad)

-- local function onCustomUIKeyPressed(key)
--     -- print(key)
--     if key == 21 then
--         Simpleonline.OnOpenPanel()
--     end
-- end

-- Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)


function Onlineshopfunction.OnPlayerDeath(playerObj)
    toolbarButton=nil
    if Simpleonline.instance then
        Simpleonline.instance:setVisible(false);
        Simpleonline.instance:removeFromUIManager();
        Simpleonline.instance = nil;
        
    end
end

Events.OnPlayerDeath.Add(Onlineshopfunction.OnPlayerDeath)




