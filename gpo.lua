--[[

   .-.            /\   .--------' |            .-..-.
  (_) )-.     _  / |  (_)   /     |     .--.`-'  (_) )-.    .--.    .-
     /   \   (  /  |  .    /      |    /  (_;       /   \  /    )`-'
    /     )   `/.__|_.'   /       |   /            /     )/    /
 .-/  `--'.:' /    |   .-/._      |  (     --;- .-/  `--'(    /
(_/      (__.'     `-'(_/  `-     |   `.___.'  (_/        `-.'

REQ : STABLE +15 FPS
--]]

task.wait(1)

local rs = game:GetService("ReplicatedStorage")

spawn(function()
    while true do
        rs.Events.takestam:FireServer(table.unpack({
            0.6,
            "dash",
            CFrame.new(-548.638855, 5.07499409, -3517.01514, -0.967746675, 9.00487152e-08, 0.251925349, 8.38576142e-08, 1, -3.53112206e-08, -0.251925349, -1.30464572e-08, -0.967746675),
        }))
        task.wait(2)
    end
end)

local plr = game:GetService("Players").LocalPlayer
local hBars = plr.PlayerGui:FindFirstChild("HealthBars")
local nT = hBars and hBars:FindFirstChild(plr.Name) and hBars[plr.Name]:FindFirstChild("NameT")
local data = game.ReplicatedStorage:FindFirstChild("Stats" .. plr.Name)
local vu = game:GetService("VirtualUser")

----------------------------- name tag

if nT then
    nT.Text = "Lawshub made by zey.zip"
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    grad.Parent = nT
end

----------------------------- rifle check

local bp = plr:WaitForChild("Backpack")
local char = plr.Character or plr.CharacterAdded:Wait()

local sg = Instance.new("ScreenGui")
sg.Name = "rifle"
sg.Parent = plr.PlayerGui

local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(0, 310, 0, 50)
lbl.Position = UDim2.new(.5, -150, 0.2, -30)
lbl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
lbl.BackgroundTransparency = .6
lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lbl.TextScaled = true
lbl.Font = Enum.Font.Arial
lbl.Text = "Equip your rifle big g"
lbl.Visible = false
lbl.Parent = sg

Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 10)

local function findAndEq()
    for _, itm in bp:GetChildren() do
        if itm.Name == "Rifle" then
            lbl.Visible = false
            itm.Parent = char
            task.wait(0.1)
            if itm.Parent == char then
                task.wait(2)
                sg:Destroy()
                return true
            end
        end
    end
    lbl.Visible = true
    task.wait(4)
    lbl.Visible = false
    task.wait(.2)
    sg:Destroy()
    return false
end

if not findAndEq() then return end

----------------------------- anti idle

game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

----------------------------- tweening

local spd = 65
local hum = char:WaitForChild("Humanoid")
local r = char:WaitForChild("HumanoidRootPart")

local pts = {
    Vector3.new(-553, 5, -3446),
    Vector3.new(-551.98, 5.70, -3651.80),
    Vector3.new(-24.81, 5.80, -8413.92),
    Vector3.new(1746.00, 7.22, -12337.00),
    Vector3.new(1746.00, 35.98, -12337.00),
    Vector3.new(1754.00, 28.98, -12333.00),
    Vector3.new(1781.00, 39.98, -12321.00),
    Vector3.new(1781.00, 40.00, -12327.00),
    Vector3.new(1794.00, 40.00, -12327.00),
    Vector3.new(8004.09, -1780.83, -17015.41),
    Vector3.new(7837.52, -2135.33, -17135.18)
}

local function tweenTo(dest)
    for _, p in char:GetDescendants() do
        if p:IsA("BasePart") then
            p.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            p.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
    
    local sPos = r.Position
    local dur = (dest - sPos).Magnitude / spd
    
    hum.PlatformStand = true
    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    
    local sTime = tick()
    while (tick() - sTime) < dur do
        local a = (tick() - sTime) / dur
        r.CFrame = CFrame.new(sPos:Lerp(dest, a))
        task.wait()
    end
    
    r.CFrame = CFrame.new(dest)
    task.wait(0.05)
    
    for _, p in char:GetDescendants() do
        if p:IsA("BasePart") then
            p.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            p.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
    
    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
    hum.PlatformStand = false
end

local function instaTP(dest)
    for _, p in char:GetDescendants() do
        if p:IsA("BasePart") then
            p.CanCollide = false
        end
    end
    
    local parts = {}
    for _, p in char:GetDescendants() do
        if p:IsA("BasePart") then
            table.insert(parts, p)
        end
    end
    
    hum.PlatformStand = true
    for _, p in parts do
        p.CFrame = CFrame.new(dest + (p.Position - r.Position))
    end
    hum.PlatformStand = false
end

for i = 1, 9 do tweenTo(pts[i]) task.wait(.2) end

task.wait(2)
instaTP(Vector3.new(1794.11, -88, -12327.02))

local vim = game:GetService("VirtualInputManager")
vim:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(2)
vim:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)

task.wait(2)
tweenTo(pts[10])
task.wait(.005)
tweenTo(pts[11])

task.wait(2)

----------------------------- char lock

local lockedPos = r.Position
local lockedRot = r.Orientation.Y

local function lockCharacter()
    r.CFrame = CFrame.new(lockedPos) * CFrame.Angles(0, math.rad(lockedRot), 0)
    
    for _, part in char:GetDescendants() do
        if part:IsA("BasePart") then
            part.Anchored = true
        end
    end
    
    hum.AutoRotate = false
    hum.PlatformStand = true
    r.RotVelocity = Vector3.new(0, 0, 0)
end

spawn(function()
    while true do
        task.wait()
        lockCharacter()
        
        pcall(function()
            if r.Orientation.Y ~= lockedRot then
                r.CFrame = CFrame.new(r.Position) * CFrame.Angles(0, math.rad(lockedRot), 0)
            end
        end)
    end
end)

pcall(function()
    UserSettings():GetService("UserGameSettings").RotationType = Enum.RotationType.CameraRelative
end)

----------------------------- rifle shoot

local rs = game:GetService("ReplicatedStorage")
local cam = workspace.CurrentCamera

local function getFm()
    local npcs = workspace:FindFirstChild("NPCs")
    local targs = {}
    
    if npcs then
        for _, n in ipairs(npcs:GetChildren()) do
            if n.Name == "Fishman Karate User" then
                table.insert(targs, n)
            end
        end
    end
    
    return targs
end

local function getClosest()
    local curChar = plr.Character
    if not curChar then return nil end
    
    local curR = curChar:FindFirstChild("HumanoidRootPart")
    if not curR then return nil end
    
    local targs = getFm()
    local closest = nil
    local closestDist = math.huge
    
    for _, t in ipairs(targs) do
        local tR = t:FindFirstChild("HumanoidRootPart")
        if tR then
            local d = (curR.Position - tR.Position).Magnitude
            if d < closestDist then
                closestDist = d
                closest = t
            end
        end
    end
    
    return closest
end

local function shoot(t)
    local curChar = plr.Character
    if not curChar or not t then return end
    
    local tR = t:FindFirstChild("HumanoidRootPart")
    if not tR then return end
    
    local firePos = tR.Position
    local startPos = cam.CFrame.Position
    local dir = (firePos - startPos).Unit
    local startCF = CFrame.new(startPos, startPos + dir)
    
    rs.Events.GunManager:FireServer(table.unpack({
        "fire",
        {
            ["Start"] = startCF,
            ["Gun"] = "Rifle",
            ["joe"] = "true",
            ["Position"] = firePos,
        }
    }))
end

local function reload()
    rs.Events.GunManager.gunFunctions:InvokeServer(table.unpack({
        "reload",
        {
            ["Gun"] = "Rifle",
        }
    }))
end

spawn(function()
    while true do
        local t = getClosest()
        
        if t then
            shoot(t)
            task.wait(0.15)
            reload()
            task.wait(0.1)
        else
            task.wait(0.3)
        end
    end
end)

----------------------------- auto stats

spawn(function()
    while true do
        if data and data.Stats and data.Stats.SkillPoints.Value > 0 then
            game.ReplicatedStorage.Events.stats:FireServer("GunMastery", nil, 1)
        end
        task.wait(0.5)
    end
end)

