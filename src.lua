--// maps a given range from a specific iterator to a new range
local function map(n, start, stop, newStart, newStop, withinBounds)
    local value = ((n - start) / (stop - start)) * (newStop - newStart) + newStart
    
    --// Returns basic value
    if not withinBounds then
        return value
    end
    
    --// Returns values constrained to exact range
    if newStart < newStop then
        return math.clamp(value, newStart, newStop)
    else
        return math.clamp(value, newStop, newStart)
    end
end



--// Color3 Components
color3_mt = {__index = Color3}
Color3 = {}

setmetatable(Color3, color3_mt)

function Color3:components(color3)
    return color3.r, color3.g, color3.b
end
--


--// Colours to transfer
local Color1 = Color3.fromRGB(0, 0, 255)
local Color2 = Color3.fromRGB(255, 0 , 0)


function Color3.mix(rgb1, rgb2)
    local r1, g1, b1 = Color3:components(rgb1)
    local r2, g2, b2 = Color3:components(rgb2)
    
    local r1, g1, b1 = r1*255, g1*255, b1*255
    local r2, g2, b2 = r2*255, g2*255, b2*255
    
    local r3, g3, b3 = r1 + r2, g1 + g2, b1 + b2
    
    r3 = map(r3, 0, 510, 0, 255)
    g3 = map(g3, 0, 510, 0, 255)
    b3 = map(b3, 0, 510, 0, 255)
    
    return Color3.fromRGB(r3, g3, b3)
end

local palette1 = script.Parent.Palette1
local palette2 = script.Parent.Palette2
local paletteMixed = script.Parent.PaletteMixed

palette1.BackgroundColor3 = Color1
palette2.BackgroundColor3 = Color2
paletteMixed.BackgroundColor3 = Color3.mix(Color1, Color2)

print(Color1)
print(Color2)
print(Color3.mix(Color1, Color2))
-->> 0, 0, 1
-->> 1, 0, 0
-->> 0.5, 0, 0.5
