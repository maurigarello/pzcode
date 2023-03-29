require "ISUI/ISPanel"
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

ISUI_Os_announcepanel = ISPanel:derive("ISUI_Os_announcepanel");

function ISUI_Os_announcepanel:initialise()
    ISPanel.initialise(self);
    self:create();
end

function ISUI_Os_announcepanel:prerender()
    ISPanel.prerender(self);
    self:drawText(getText("IGUI_guanggaowei"), 10 ,10, 1,1,0,1, UIFont.Large);
    self:drawTextureScaledAspect(getTexture("media/textures/file_267240.png"), self:getWidth()*0.1,self:getHeight()*0.1, self:getWidth()*0.8, self:getHeight()*0.8, 1, 1, 1, 1)
    
end

function ISUI_Os_announcepanel:render()
end

function ISUI_Os_announcepanel:create()
    -- self.imagehentai = ISImage:new(self:getWidth()*0.1, self:getHeight()*0.1, 0, 0, getTexture("media/textures/file_267240.png"));
    -- self.imagehentai.scaledWidth = self:getWidth()*0.8
    -- self.imagehentai.scaledHeight = self:getHeight()*0.8
    -- self:addChild(self.imagehentai);
end

function ISUI_Os_announcepanel:onOptionMouseDown(button, x, y)
    if button.internal == "CANCEL" then
    self:setVisible(false);
        self:removeFromUIManager();
    end
end

function ISUI_Os_announcepanel:new(x,y,w,h,title)
    local o = {};
    -- x = getMouseX() + 10;
    -- y = getMouseY() + 10;
    o = ISPanel:new(x, y, w, h);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=1};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = false;

    return o;
end