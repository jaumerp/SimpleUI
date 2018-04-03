-- Show WorldMap Coordinates

local addonName, L = ...; 
local function defaultFunc(L, key) 
	return key; 
end
setmetatable(L, {__index=defaultFunc}); 

local playerColor = RAID_CLASS_COLORS[select(2, UnitClass('player'))]

local f = CreateFrame('Frame')
f:SetParent(WorldMapButton)

f.cursor = f:CreateFontString(nil, 'OVERLAY')
f.cursor:SetFont(GameFontNormal:GetFont(), 16, 'THINOUTLINE')
f.cursor:SetShadowOffset(1, -1)
f.cursor:SetJustifyH('LEFT')
f.cursor:SetPoint('BOTTOMLEFT', WorldMapButton, 'BOTTOM', -150, 2)

f.player = f:CreateFontString(nil, 'OVERLAY')
f.player:SetFont(GameFontNormal:GetFont(), 16, 'THINOUTLINE')
f.player:SetTextColor(playerColor.r, playerColor.g, playerColor.b)
f.player:SetShadowOffset(1, -1)
f.player:SetJustifyH('RIGHT')
f.player:SetPoint('BOTTOMRIGHT', WorldMapButton, 'BOTTOM', 150, 2)

f:SetScript('OnUpdate', function()
    local width = WorldMapButton:GetWidth() 
    local height = WorldMapButton:GetHeight()
    local mx, my = WorldMapFrame:GetCenter()
    local px, py = GetPlayerMapPosition('player')
    local cx, cy = GetCursorPosition()
	
    mx = (((cx / WorldMapFrame:GetScale()) - (mx - width / 2)) / width + 22 / 10000)
    my = ((((my + height / 2) - (cy / WorldMapFrame:GetScale())) / height) - 262 / 10000)

    f.cursor:SetText(format(L['Mouse:  %.2d:%.2d'], mx * 100, my * 100))
    f.player:SetText(format(L['Player:  %.2d:%.2d'], px * 100, py * 100))
end)


--[[
local uiScale, x, y = UIParent:GetEffectiveScale(), GetCursorPosition()
local tex = UIParent:CreateTexture()
tex:SetTexture(1,1,1)
tex:SetSize(4,4)
tex:SetPoint("CENTER", nil, "BOTTOMLEFT", x / uiScale, y / uiScale)
]]