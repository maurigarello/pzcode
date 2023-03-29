--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISOnlineshopcore = ISPanel:derive("ISOnlineshopcore");
--ISOnlineshopcore.instance = nil;


function ISOnlineshopcore.OnOpenPanel(_class,_x, _y, _w, _h, _title)
    if _class.instance==nil then
        _class.instance = _class:new(_x, _y, _w, _h, _title);
        _class.instance:initialise();
        _class.instance:instantiate();
        ISDebugMenu.RegisterClass(_class);
    end

    _class.instance:addToUIManager();
    _class.instance:setVisible(true);

    return _class.instance;
end

function ISOnlineshopcore:initialise()
    ISPanel.initialise(self);
end

function ISOnlineshopcore:registerPanel(_buttonTitle, _panelClass)
    self.panelInfo = self.panelInfo or {};

    table.insert(self.panelInfo, {
        buttonTitle = _buttonTitle,
        panelClass = _panelClass,
    });
end

function ISOnlineshopcore:createChildren()
    ISPanel.createChildren(self);

    local x,y = 20,10;

    --local tX = self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, self.panelTitle) / 2)
    local a
    a, self.paneltitlepanel = ISDebugUtils.addLabel(self, self.panelTitle, self.width/2, y, self.panelTitle, UIFont.Medium, true);
    self.paneltitlepanel.center = true;
    local headerY = a + 10;

    local x,y = 10, headerY;
    local w,h = 180, 20;
    local margin = 10;

    local obj;

    for k,v in ipairs(self.panelInfo) do
        y, obj = ISDebugUtils.addButton(self,v.buttonTitle,x,y,w,h,getText("IGUI_shop"..v.buttonTitle),ISOnlineshopcore.onClick);
        v.button = obj;
        y = y+margin;
    end

    self.playermodel = ISCharacterScreenAvatar:new(x, y,w, w*2)
	self.playermodel:setVisible(true)
	self:addChild(self.playermodel)
	self.playermodel:setOutfitName("Foreman", false, false)
	self.playermodel:setState("idle")
	self.playermodel:setDirection(IsoDirections.S)
	self.playermodel:setIsometric(false)

    -- y, self.moneylabel = ISDebugUtils.addLabel(self, "money", x, y+margin+200,"money", UIFont.Medium, true)

    local FONT_HGT = getTextManager():getFontHeight(UIFont.Medium);
    self.moneylabel = ISLabel:new(x, y+margin+200, FONT_HGT, "money", 1, 1, 0, 1.0, UIFont.Large, true);
    self.moneylabel:initialise();
    self.moneylabel:instantiate();
    self:addChild(self.moneylabel);
  
    x,y = 200, headerY;
    local Xwide = 50
    w,h = self.width-210, self.height-headerY-Xwide;

    self.panels = {};

    local options;
    for k,v in ipairs(self.panelInfo) do
        if k ==1 or k==5 then
        options = v.panelClass:new(x, y, w, h);
        options:initialise();
        options:instantiate();
        options:setAnchorRight(true);
        options:setAnchorLeft(true);
        options:setAnchorTop(true);
        options:setAnchorBottom(true);
        options.moveWithMouse = true;
        options.doStencilRender = true;
        options:addScrollBars();
        options.vscroll:setVisible(true);
        self:addChild(options);
        options:setScrollChildren(true);
        options.onMouseWheel = ISDebugUtils.onMouseWheel;

        v.panel = options;
        --self.climateOptions = options;
        table.insert(self.panels, self.climateOptions);

        if k>1 then
            options:setEnabled(false);
            options:setVisible(false);
        else
            Onlinetest.instance = options
        
        end
        end
    end

    

    local buttonhei = self.height-Xwide+margin

    local currentindex = Onlineshopinfo.currentshop.index




    local a,b,c
    ISDebugUtils.addButton(self,"close",10,buttonhei,180,30,getText("IGUI_CraftUI_Close"),ISOnlineshopcore.onClick);
    a,self.button_buy = ISDebugUtils.addButton(self,"buy",x+margin,buttonhei,180,30,getText("IGUI_osBuy"),ISOnlineshopcore.onClick)
    a,self.button_all = ISDebugUtils.addButton(self,"buyall",x+2*margin+180,buttonhei,180,30,getText("IGUI_osBuyall"),ISOnlineshopcore.onClick)
    a,self.button_sell = ISDebugUtils.addButton(self,"sell",x+3*margin+360,buttonhei,180,30,getText("IGUI_osSell"),ISOnlineshopcore.onClick)

end


local function checktableisnil(tablez)
    local content = tablez
    if content==nil then
        return true
    end
    local isnil=true
    for k,v in pairs(content) do
        isnil=false
    end
    if isnil then
        return true
    else
        return false
    end
    
end

function ISOnlineshopcore:prerender()
	ISPanel.prerender(self)
    self.playermodel:setCharacter(self.character_)


    self.paneltitlepanel:setName(self.panelTitle.."-"..getText("IGUI_shop"..Onlineshopinfo.currentshop.index))
    self.moneylabel:setName("ID :"..self.character_:getUsername().."\n"..getText("IGUI_yuea").."\n".."$"..tostring(Onlineshopinfo.currentmoney).."\n"..getText("IGUI_yishangjia").."\n"..tostring(Onlineshopinfo.currentupitem).."/10".."\n"..getText("IGUI_quanxian")..self.character_:getAccessLevel())
    local permission = (self.character_:getAccessLevel() == "Admin")
    local playermoney = Onlineshopinfo.currentmoney
    local currentindex = Onlineshopinfo.currentshop.index
    local item
    local onlinescrollingList = Onlinetest.instance
    -- print(onlinescrollingList.selected)
    local onlinescrollingListselect = onlinescrollingList.selected
    if onlinescrollingListselect and onlinescrollingListselect >0 then
        if onlinescrollingList.items[onlinescrollingListselect] then
            item = onlinescrollingList.items[onlinescrollingListselect].item 
        end  
    end

    



    

 
    if currentindex == "basesysshop" then
        
        if permission then
            if onlinescrollingList.selected==0 then
                self.button_buy:setEnable(false)
            else
                self.button_buy:setEnable(true)
            end
            
            self.button_all:setEnable(false)
            self.button_sell:setEnable(true)
        else

            if item then
                if tonumber(item.price) > playermoney then
                    self.button_buy:setEnable(false)
                    self.button_all:setEnable(false)  
                else
                    self.button_buy:setEnable(true)
                    self.button_all:setEnable(true)
                    
                end
            else 
                self.button_buy:setEnable(false)
                self.button_all:setEnable(false)
        
            end
            self.button_sell:setEnable(false)
        end   
    elseif currentindex == "baseplayershop" then
        if item then
            if tonumber(item.price) > playermoney then
                self.button_buy:setEnable(false)
                self.button_all:setEnable(false)  
            else
                self.button_buy:setEnable(true)
                self.button_all:setEnable(true)
                
            end
        else 
            self.button_buy:setEnable(false)
            self.button_all:setEnable(false)
    
        end
        self.button_sell:setEnable(false)
    elseif currentindex == "playerinv" then
        
        if item and item.uptime and tonumber(item.price) < playermoney then
            self.button_sell:setEnable(false)
            self.button_buy:setEnable(true)
            self.button_all:setEnable(true)
        elseif item and  item.uptime==nil and Onlineshopinfo.currentupitem <= 10 then
            self.button_sell:setEnable(true)
            self.button_buy:setEnable(false)
            self.button_all:setEnable(false)
        else
            self.button_sell:setEnable(false)
            self.button_buy:setEnable(false)
            self.button_all:setEnable(false)
        end
    
    elseif currentindex == "giftbag" then
        self.button_buy:setEnable(true)
        self.button_all:setEnable(false)
        self.button_sell:setEnable(false)
        
    else
        self.button_buy:setEnable(false)
        self.button_all:setEnable(false)
        self.button_sell:setEnable(false)
    end

    if checktableisnil(Onlineshopinfo.currentshop.content) then
        self.button_buy:setEnable(false)
        self.button_all:setEnable(false)
        if currentindex == "playerinv" then
            self.button_sell:setEnable(false)
        end
    end
    
    
end

local function gentradeid()
    local gametime = getGameTime()

    local year = tostring(gametime:getYear())
    local month = tostring(gametime:getMonth())
    local day = tostring(gametime:getDay())
    local hour = tostring(gametime:getHour())
    local minute = tostring(gametime:getMinutes())
    local randomnum1 = tostring(ZombRand(10))
    local randomnum2 = tostring(ZombRand(10))
    local randomnum3 = tostring(ZombRand(10))

    local selltime = year.. "/"..month .. "/"..day .. "-"..hour .. ":"..minute
    local tradeID = year.. month ..day ..hour ..minute ..randomnum1 ..randomnum2 ..randomnum3
    return selltime,tradeID

end
function ISOnlineshopcore:Ontextbox(_button,item)

    local selltime,tradeID = gentradeid()

    if _button.internal == "OK" then
        local entrytext2 = _button.parent.entry2:getText()
        local entrytext1 =tonumber(_button.parent.entry:getText())

        if  entrytext1==nil then return end
        entrytext1=math.floor(entrytext1)
        -- entrytext2=math.floor(entrytext2)


        local item = ScriptManager.instance:getItem(entrytext2)
        if item  then
            sendClientCommand("os_sysshopsell","true",{
                tradeID,
                entrytext2,
                entrytext1,
                selltime

            })
            
        end
    end
end
function ISOnlineshopcore:playerinvsell(_button,item,selectitem,itemnumber)
    local selltime,tradeID = gentradeid()


    if _button.internal == "OK" then
        local entrytext1 =tonumber(_button.parent.entry:getText())
        local entrytext2 =tonumber(_button.parent.entry2:getText())

        if entrytext2==nil or entrytext1==nil then return end
        entrytext1=math.floor(entrytext1)
        entrytext2=math.floor(entrytext2)

        if entrytext2> selectitem.quantity then return end

        -- print(itemnumber)
        
        local tableitem = selectitem.itemtable
        for i=1,entrytext2 do
            self.character_:getInventory():Remove(tableitem[i])
        end
        sendClientCommand("os_playershopsell","true",{
            tradeID,
            self.character_:getUsername(),
            selectitem.itemtype,
            entrytext1,
            entrytext2,
            selltime


               
        })
    end




end


local function buyoneitem(this,button,player,item)
    -- print(button.internal)
    -- print()
    if button.internal == "YES" then
        -- print("buyone")
        sendClientCommand("os_buyone","true",{
            player:getUsername(),
            item.itemtype,
            item.price   
        })
    end
end

local function buyoneitemplayershop(this,button,player,item)
    -- print(button.internal)
    -- print()
    if button.internal == "YES" then
        -- print("buyone")
        sendClientCommand("os_buyoneplayershop","true",{
            player:getUsername(),
            item.text
        })
    end
end

local function buyoneitemgiftbag(this,button,player,item)
    -- print(button.internal)
    if button.internal == "YES" then
        -- print("giftbuy")
        sendClientCommand("os_buyonegiftbag","true",{
            player:getUsername(),
            item.text
        })
    end
end

function ISOnlineshopcore:buyallitem(_button,item,selectitem)
    -- print(_button.internal)
    if _button.internal == "OK" then
        local entrytext1 =tonumber(_button.parent.entry:getText())

        if entrytext1==nil then return end
        entrytext1=math.floor(entrytext1)
        sendClientCommand("os_buyall","true",{
            self.character_:getUsername(),
            selectitem.itemtype,
            selectitem.price*entrytext1,
            entrytext1

               
        })
    end
end

function ISOnlineshopcore:buyallitemplayershop(_button,item,selectitem,itemall)

    -- print("buyallclient")
    if _button.internal == "OK" then
        local entrytext1 =tonumber(_button.parent.entry:getText())

        if entrytext1==nil then return end
        entrytext1=math.floor(entrytext1)
        
        sendClientCommand("os_buyallplayershop","true",{
            self.character_:getUsername(),
            itemall.text,
            entrytext1

               
        })
    end
end




function ISOnlineshopcore:onClick(_button)
    
    if _button.customData == "basesysshop" then
        Onlineshopinfo.currentshop.index = "basesysshop"
        Onlineshopinfo.currentshop.content = Onlineshopinfo.basesysshop
    elseif _button.customData == "baseplayershop" then 
        Onlineshopinfo.currentshop.index = "baseplayershop"
        Onlineshopinfo.currentshop.content = Onlineshopinfo.baseplayershop
    elseif _button.customData == "playerinv" then
        Onlineshopinfo.currentshop.index = "playerinv"
        Onlineshopinfo.currentshop.content = Onlineshopinfo.playerinv
    elseif _button.customData == "giftbag" then
        Onlineshopinfo.currentshop.index = "giftbag"
        Onlineshopinfo.currentshop.content = Onlineshopinfo.giftbag
    elseif _button.customData == "fuwuqigonggao" then
        Onlineshopinfo.currentshop.index = "fuwuqigonggao"
        Onlineshopinfo.currentshop.content = Onlineshopinfo.fuwuqigonggao
    end

    

    if _button.customData == "close" then
        self:close();
        return;
    end

    


    local selectitem
    local selectitemtext
    local onlinescrollingList = Onlinetest.instance
    -- print(onlinescrollingList.selected)
    local onlinescrollingListselect = onlinescrollingList.selected
    if onlinescrollingListselect and onlinescrollingListselect >0 then
        if onlinescrollingList.items[onlinescrollingListselect] then
            selectitem = onlinescrollingList.items[onlinescrollingListselect].item
            selectitemtext = onlinescrollingList.items[onlinescrollingListselect]
        end
   
    end



    Onlinetest.instance:update_()
    local permission = (self.character_:getAccessLevel()=="Admin")
    -- print(self.scrollingList.selected.text)
    if _button.customData =="sell" then
        if Onlineshopinfo.currentshop.index == "basesysshop" then
            local modal = ISTextBoxOnline:new(0, 0, 280, 180, getText("IGUI_zhongleiandjiage"), "1", self, ISOnlineshopcore.Ontextbox, nil, nil);
            modal:initialise();
            modal:addToUIManager();
            modal:setOnlyNumbers(true);
            self.button_sell:setEnable(false);
        elseif Onlineshopinfo.currentshop.index == "playerinv" then
            local modal = ISPlayersell:new(0, 0, 280, 180, getText("IGUI_zhongleiandshuliang"), "1", self, ISOnlineshopcore.playerinvsell, 0,selectitem, selectitem,selectitem.itemtype,selectitem.quantity)
            modal:initialise()
            modal:addToUIManager()
            modal:setOnlyNumbers(true)
            modal.entry2:setOnlyNumbers(true);
            self.button_sell:setEnable(false);
            -- self.character_:getInventory():Remove(selectitem.itemtype)
        end


    elseif _button.customData =="buy"  then
    
        -- print(Onlineshopinfo.currentshop.index)
        -- print(Onlineshopinfo.currentshop.index == "giftbag")
        if Onlineshopinfo.currentshop.index == "basesysshop" then
            if permission then --permission!!替换
                sendClientCommand("os_removesys","true",{onlinescrollingList.items[onlinescrollingListselect].text})
            else
                local ui =ISModalDialog:new(0,0, 250, 150, getText("IGUI_buyone")..ScriptManager.instance:getItem(selectitem.itemtype):getDisplayName().."*1".."  "..getText("IGUI_jiage")..tostring(selectitem.price), true, nil,buyoneitem, 0,self.character_,selectitem)
                ui:initialise()
                ui:addToUIManager()
            end
        elseif Onlineshopinfo.currentshop.index == "baseplayershop" or Onlineshopinfo.currentshop.index == "playerinv" then
            local ui =ISModalDialog:new(0,0, 250, 150, getText("IGUI_buyone")..ScriptManager.instance:getItem(selectitem.itemtype):getDisplayName().."*1".."  "..getText("IGUI_jiage")..tostring(selectitem.price), true, nil,buyoneitemplayershop, 0,self.character_,selectitemtext)
            ui:initialise()
            ui:addToUIManager()


        
        elseif Onlineshopinfo.currentshop.index == "giftbag" then
            -- print("buypanel")
            local ui =ISModalDialog:new(0,0, 250, 150, getText("IGUI_buyone")..ScriptManager.instance:getItem(selectitem.itemtype):getDisplayName().."*1".."  "..getText("IGUI_jiage")..tostring(selectitem.price), true, nil,buyoneitemgiftbag, 0,self.character_,selectitemtext)
            ui:initialise()
            ui:addToUIManager()


            
        end
            





        
            
        
    elseif _button.customData =="buyall" then
        if Onlineshopinfo.currentshop.index == "basesysshop" then
            local modal = ISBuyallTextBox:new(0, 0, 280, 180, getText("IGUI_buyone")..ScriptManager.instance:getItem(selectitem.itemtype):getDisplayName().."  "..getText("IGUI_jiage"), "1", self, ISOnlineshopcore.buyallitem, 0,selectitem, selectitem,nil);
            modal:initialise();
            modal:addToUIManager();
            modal:setOnlyNumbers(true);
        elseif Onlineshopinfo.currentshop.index == "baseplayershop" or "playerinv" then
            local modal = ISBuyallTextBox:new(0, 0, 280, 180, getText("IGUI_buyone")..ScriptManager.instance:getItem(selectitem.itemtype):getDisplayName().."  "..getText("IGUI_jiage"), "1", self, ISOnlineshopcore.buyallitemplayershop, 0,selectitem, selectitem,selectitemtext);
            modal:initialise()
            modal:addToUIManager()
            modal:setOnlyNumbers(true)
        end


        
    end

    

    if  _button.customData =="buy" or _button.customData =="buyall" or _button.customData =="sell" then
        return
    end
    

    for k,v in ipairs(self.panelInfo) do


        if v.button==_button and k<5 then
            self.panelInfo[1].panel:setEnabled(true);
            self.panelInfo[1].panel:setVisible(true);
            if self.panelInfo[1].panel.onMadeActive then
                self.panelInfo[1].panel:onMadeActive();
            end
            self.panelInfo[5].panel:setEnabled(false);
            self.panelInfo[5].panel:setVisible(false);
        elseif v.button==_button and k==5 then
            self.panelInfo[5].panel:setEnabled(true);
            self.panelInfo[5].panel:setVisible(true);
            if self.panelInfo[5].panel.onMadeActive then
                self.panelInfo[5].panel:onMadeActive();
            end
            self.panelInfo[1].panel:setEnabled(false);
            self.panelInfo[1].panel:setVisible(false);  
        end
    end


    
end

function ISOnlineshopcore:onMadeActive()
    for k,v in ipairs(self.panelInfo) do
        if v.panel and v.panel:getIsVisible() and v.panel:isEnabled() and v.panel.onMadeActive then
            v.panel:onMadeActive();
        end
    end
end

function ISOnlineshopcore:update()
    ISPanel.update(self);
end

function ISOnlineshopcore:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ISOnlineshopcore.instance = nil
end

function ISOnlineshopcore:new(x, y, width, height, title)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    o.panelTitle = title;
    o.character_ = getPlayer()
    --ISOnlineshopcore.instance = o
    return o;
end



