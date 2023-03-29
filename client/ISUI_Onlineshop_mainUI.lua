require "ISUI_Onlineshopcore";

Simpleonline = ISOnlineshopcore:derive("Simpleonline");
Simpleonline.instance = nil;


function Simpleonline.OnOpenPanel()
    Simpleonline.instance = ISOnlineshopcore.OnOpenPanel(Simpleonline, 100, 100, 800, 600, getText("IGUI_Onlineshop"));
    return Simpleonline.instance
end

function Simpleonline:new(x, y, width, height, title)
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    local o = ISOnlineshopcore:new(x, y, width, height, title);
    setmetatable(o, self);
    self.__index = self;
    ISDebugMenu.RegisterClass(self);
    return o;
end

function Simpleonline:initialise()
    ISPanel.initialise(self);
    self:registerPanel("basesysshop",Onlinetest);
    self:registerPanel("baseplayershop",Onlinetest);
    self:registerPanel("playerinv",Onlinetest);
    self:registerPanel("giftbag",Onlinetest);
    self:registerPanel("fuwuqigonggao",ISUI_Os_announcepanel);
end

