Onlinetest = ISScrollingListBox:derive("Onlinetest")
Onlinetest.instance =nil


function Onlinetest:initialise()
    ISScrollingListBox.initialise(self);
end

function Onlinetest:doDrawItem(y, item, alt)
	if not item.height then item.height = self.itemheight end -- compatibililty
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15);

    end



    
    if item.item.spclo==2 then
        self:drawRectBorder(0, (y), self:getWidth(), item.height, 0.5, 0, 1, 0);
    elseif item.item.spclo==3 then
        self:drawRectBorder(0, (y), self:getWidth(), item.height, 0.5, 0, 1, 1);
    else
        self:drawRectBorder(0, (y), self:getWidth(), item.height, 0.5, 1, 0, 1);
    end
        
	
	local itemPadY = self.itemPadY or (item.height - self.fontHgt) / 2
	self:drawText(item.itemtpye, 15, (y)+itemPadY, 0.9, 0.9, 0.9, 0.9, self.font);
	
    -- print(item.item.itemtype)
    -- print(item.item.price)
    -- print(item)
    local item_type = item.item.itemtype
    local itemtex_item = ScriptManager.instance:getItem(item_type)
    if itemtex_item==nil then return end
    local itemtex_tex = itemtex_item:getNormalTexture()
    self:drawTextureScaledAspect(itemtex_tex, 130,(y)+itemPadY-5, 32, 32, 1, 1, 1, 1)
    local itemtex_name = itemtex_item:getDisplayName()
    self:drawText(item_type, 15, (y)+itemPadY, 0.9, 0.9, 0.9, 0.9, self.font);
    self:drawText(itemtex_name.."* "..tostring(item.item.quantity), 15, (y)+itemPadY+15, 0.9, 0.9, 0.9, 0.9, self.font);
    self:drawText("$:"..item.item.price, 190, (y)+itemPadY+10, 1, 1, 0, 1, UIFont.Large);
    self:drawText(getText("IGUI_maijia")..tostring(item.item.username), 255, (y)+itemPadY+10, 0.9, 0.9, 0.9, 0.9, UIFont.Medium);
    self:drawText(getText("IGUI_shangjiashijian")..tostring(item.item.uptime), 370, (y)+itemPadY+10, 0.9, 0.9, 0.9, 0.9, UIFont.Medium);



    y = y + item.height;
	return y;

end

function Onlinetest:update_()
    -- self.scrollingList.doDrawItem = Onlinetest.doDrawItem;
    local l_items = {}
    local l_conut = 0
    if Onlineshopinfo.currentshop.content ==nil then Onlineshopinfo.currentshop.content ={} end
    for k,v in pairs(Onlineshopinfo.currentshop.content) do
        local i={}
        i.text=k
        i.item=v
        -- print(v.itemtype)
        i.tooltip = nil
        i.itemindex = l_conut+1
        l_conut = l_conut+1
        i.height = self.itemheight
        table.insert(l_items, i);
    end
    self.items = l_items


end

function Onlinetest:prerender()
    ISScrollingListBox.prerender(self);
    
    if Onlineshopinfo.currentshop.index == "basesysshop" then
        Onlineshopinfo.currentshop.content = Onlineshopinfo.basesysshop
    elseif Onlineshopinfo.currentshop.index == "baseplayershop" then
        Onlineshopinfo.currentshop.content = Onlineshopinfo.baseplayershop
    elseif Onlineshopinfo.currentshop.index == "playerinv" then
        Onlineshopinfo.currentshop.content = Onlineshopinfo.playerinv
        self:update_()

    elseif Onlineshopinfo.currentshop.index == "giftbag" then
        Onlineshopinfo.currentshop.content = Onlineshopinfo.giftbag
    elseif Onlineshopinfo.currentshop.index == "fuwuqigonggao" then
        Onlineshopinfo.currentshop.content = Onlineshopinfo.fuwuqigonggao 
    end
end

function Onlinetest:new(x, y, width, height, doStencil)
    local o = {};
    o = ISScrollingListBox:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.itemheight = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight()*2;
    o.font = UIFont.Small
    o.xywh = {x, y, width, height}

    return o;
end

