local info = {
    moduleName = "RaiderIO Tooltip",
    color1 = {
        name = "Frame",
        desc = "",
    },
    color2 = {
        name = "Background",
        desc = "",
    },
}

local module = FrameColor_CreateSkinModule(info)

local SetDesaturation = SetDesaturation
local SetVertexColor = SetVertexColor

local callback = nil
local function recolor(main_color, bg_color, desaturation)
    local frame = RaiderIO_ProfileTooltip
    for _, texture in pairs({
        frame.NineSlice.TopEdge,
        frame.NineSlice.BottomEdge,
        frame.NineSlice.TopRightCorner,
        frame.NineSlice.TopLeftCorner,
        frame.NineSlice.RightEdge,
        frame.NineSlice.LeftEdge,
        frame.NineSlice.BottomRightCorner,
        frame.NineSlice.BottomLeftCorner,  
    }) do
        texture:SetDesaturation(desaturation)
        texture:SetVertexColor(main_color.r,main_color.g,main_color.b) 
    end
    frame.NineSlice.Center:SetVertexColor(bg_color.r,bg_color.g,bg_color.b)
end

function module:OnEnable()
    local main_color = self:GetColor1()
    local bg_color = self:GetColor2()
    callback = recolor
    if not hooked then
        PVEFrame:HookScript("OnShow", function()
            callback(main_color, bg_color, 1)
        end)
        hooked = true
    end
    if PVEFrame:IsShown() then
        recolor(main_color, bg_color, 1)
    end
end

function module:OnDisable()
    local color1 = {r=1,g=1,b=1,a=1}
    local color2 = {}
    color2.r, color2.g, color2.b = TOOLTIP_DEFAULT_BACKGROUND_COLOR:GetRGB()
    callback = function() end
    recolor(color1, color2, 0)
end


