local function GetFrameRect(frame)
    local height = math.floor(frame:GetHeight() + 0.5)
    local width = math.floor(frame:GetWidth() + 0.5)
    return height, width
end

local frame = CreateFrame("FRAME")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterEvent("UNIT_FACTION")


frame:SetScript("OnEvent", function(self, event, ...) 
    if event == "PLAYER_ENTERING_WORLD" then 
        print(string.format("|cFF20ff20%s loaded...|r", "BackgroundNameFrame"))
        local height, width = GetFrameRect(JcfPlayerFrameHealthBar)
        for index, frame in pairs({JcfPlayerFrame, JcfTargetFrame, JcfFocusFrame}) do
            local texture = frame:CreateTexture(nil, "BACKGROUND")    
            texture:SetColorTexture(1, 1, 1, 1)
            texture:SetSize(width, height * 1.5)  
            texture:SetPoint("LEFT", frame.healthbar, "LEFT", 0, 14)     
            texture:SetTexture("Interface\\Buttons\\WHITE8X8")
            frame.CCBackgroundNameFrame = texture
        end
    else
        if UnitIsPlayer("target") then
            c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
            JcfTargetFrame.CCBackgroundNameFrame:SetVertexColor(c.r, c.g, c.b)
        else 
            JcfTargetFrame.CCBackgroundNameFrame:SetVertexColor(0, 1, 0)
        end
        if UnitIsPlayer("focus") then
            c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
            JcfFocusFrame.CCBackgroundNameFrame:SetVertexColor(c.r, c.g, c.b)
        end
		if UnitIsPlayer("player") then
            c = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
            JcfPlayerFrame.CCBackgroundNameFrame:SetVertexColor(c.r, c.g, c.b)
        end
    end 
end)
