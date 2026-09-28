-- =========================================================================
-- MULTIHUB URAN V4 — PREMIUM DESIGNER EDITION (PREMIUM UI/UX FOR ROBLOX)
-- =========================================================================
if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 15)
local Camera = workspace.CurrentCamera

if not PlayerGui then return end

-- Очистка старых копий
if PlayerGui:FindFirstChild("UranHub") then PlayerGui.UranHub:Destroy() end
if PlayerGui:FindFirstChild("UranBootTerminal") then PlayerGui.UranBootTerminal:Destroy() end

local HasDrawing = (typeof(Drawing) == "table" or typeof(Drawing) == "userdata") and Drawing.new ~= nil

-- =========================================================================
-- НАСТРОЙКИ СИСТЕМЫ КЛЮЧЕЙ С АВТОСОХРАНЕНИЕМ (ВСТАВЛЯТЬ НА 26 СТРОКУ)
-- =========================================================================
if PlayerGui:FindFirstChild("UranKeySystem") then PlayerGui.UranKeySystem:Destroy() end

local KeyLink = "https://discord.gg" -- Ссылка на получение
local ConfigFileName = "UranHub_AuthKey.txt" -- Имя файла, куда запишется ключ

-- База данных сгенерированных ключей
local KeysTable = {
    ["4K9R-M2W7-T8X5"] = true, ["L7N3-V8P4-Q9W2"] = true, ["X2B8-C5M9-K7T4"] = true,
    ["Z6Y1-H3G8-F5V2"] = true, ["P9K4-L2M7-N8B3"] = true, ["T5X9-W2V7-R4N8"] = true,
    ["C8B3-K7M4-L9P2"] = true, ["G5H1-F3V8-Y6Z2"] = true, ["M7W2-T8X5-K9R4"] = true,
    ["Q9W2-L7N3-V8P4"] = true, ["K7T4-X2B8-C5M9"] = true, ["F5V2-Z6Y1-H3G8"] = true,
    ["N8B3-P9K4-L2M7"] = true, ["R4N8-T5X9-W2V7"] = true, ["L9P2-C8B3-K7M4"] = true,
    ["Y6Z2-G5H1-F3V8"] = true, ["K9R4-M7W2-T8X5"] = true, ["V8P4-Q9W2-L7N3"] = true,
    ["C5M9-K7T4-X2B8"] = true, ["H3G8-F5V2-Z6Y1"] = true, ["L2M7-N8B3-P9K4"] = true,
    ["W2V7-R4N8-T5X9"] = true, ["K7M4-L9P2-C8B3"] = true, ["F3V8-Y6Z2-G5H1"] = true,
    ["T8X5-K9R4-M7W2"] = true, ["J3K8-L2N7-M5P4"] = true
}

local KeyVerified = false

-- АВТОМАТИЧЕСКАЯ ПРОВЕРКА СОХРАНЕННОГО КЛЮЧА
if readfile and isfile and isfile(ConfigFileName) then
    local savedKey = readfile(ConfigFileName)
    if KeysTable[savedKey] then
        KeyVerified = true -- Если нашли верный сохраненный ключ, пропускаем UI ввод
    end
end

-- Если ключ не сохранен или не верен, показываем графическое окно
if not KeyVerified then
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "UranKeySystem"
    KeyGui.ResetOnSpawn = false
    KeyGui.Parent = PlayerGui

    local KeyWindow = Instance.new("Frame")
    KeyWindow.Size = UDim2.new(0, 360, 0, 200)
    KeyWindow.Position = UDim2.new(0.5, -180, 0.5, -100)
    KeyWindow.BackgroundColor3 = Color3.fromRGB(11, 11, 14)
    KeyWindow.BorderSizePixel = 0
    KeyWindow.Parent = KeyGui

    Instance.new("UICorner", KeyWindow).CornerRadius = UDim.new(0, 10)
    local KeyStroke = Instance.new("UIStroke")
    KeyStroke.Color = Color3.fromRGB(0, 255, 163)
    KeyStroke.Thickness = 1
    KeyStroke.Parent = KeyWindow

    local KeyTitle = Instance.new("TextLabel")
    KeyTitle.Size = UDim2.new(1, 0, 0, 40)
    KeyTitle.Text = "URAN V6 // ТРЕБУЕТСЯ КЛЮЧ"
    KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyTitle.TextSize = 12
    KeyTitle.Font = Enum.Font.Code
    KeyTitle.BackgroundTransparency = 1
    KeyTitle.Parent = KeyWindow

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -40, 0, 36)
    KeyInput.Position = UDim2.new(0, 20, 0, 60)
    KeyInput.BackgroundColor3 = Color3.fromRGB(19, 19, 26)
    KeyInput.Text = ""
    KeyInput.PlaceholderText = "Вставьте ключ сюда..."
    KeyInput.TextColor3 = Color3.fromRGB(0, 255, 163)
    KeyInput.TextSize = 12
    KeyInput.Font = Enum.Font.Code
    KeyInput.Parent = KeyWindow
    Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 6)

    local CheckBtn = Instance.new("TextButton")
    CheckBtn.Size = UDim2.new(0, 150, 0, 36)
    CheckBtn.Position = UDim2.new(0, 20, 0, 120)
    CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 163)
    CheckBtn.Text = "ПРОВЕРИТЬ"
    CheckBtn.TextColor3 = Color3.fromRGB(11, 11, 14)
    CheckBtn.Font = Enum.Font.GothamBold
    CheckBtn.TextSize = 12
    CheckBtn.Parent = KeyWindow
    Instance.new("UICorner", CheckBtn).CornerRadius = UDim.new(0, 6)

    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0, 150, 0, 36)
    GetKeyBtn.Position = UDim2.new(1, -170, 0, 120)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    GetKeyBtn.Text = "ПОЛУЧИТЬ КЛЮЧ"
    GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.TextSize = 12
    GetKeyBtn.Parent = KeyWindow
    Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

    GetKeyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(KeyLink)
            GetKeyBtn.Text = "ССЫЛКА СКОПИРОВАНА!"
            task.wait(2)
            GetKeyBtn.Text = "ПОЛУЧИТЬ КЛЮЧ"
        else
            GetKeyBtn.Text = "Ошибка буфера"
        end
    end)

    CheckBtn.MouseButton1Click:Connect(function()
        local enteredKey = KeyInput.Text
        if KeysTable[enteredKey] then
            -- СОХРАНЕНИЕ КЛЮЧА НА ДИСК ПРИ УСПЕШНОМ ВВОДЕ
            if writefile then
                writefile(ConfigFileName, enteredKey)
            end
            KeyVerified = true
            KeyGui:Destroy()
        else
            CheckBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            CheckBtn.Text = "НЕВЕРНЫЙ КЛЮЧ!"
            task.wait(2)
            CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 163)
            CheckBtn.Text = "ПРОВЕРИТЬ"
        end
    end)

    while not KeyVerified do
        task.wait(0.2)
    end
end
-- =========================================================================

local SG = Instance.new("ScreenGui")
SG.Name = "UranHub"
SG.ResetOnSpawn = false
SG.Parent = PlayerGui

-- =========================================================================
-- DESIGNER SYSTEM BOOTSTRAP (MODERN MINIMALIST TERMINAL)
-- =========================================================================
local BootGui = Instance.new("ScreenGui")
BootGui.Name = "UranBootTerminal"
BootGui.ResetOnSpawn = false
BootGui.Parent = PlayerGui

local CMDWindow = Instance.new("Frame")
CMDWindow.Name = "CMDWindow"
CMDWindow.Size = UDim2.new(0, 480, 0, 280)
CMDWindow.Position = UDim2.new(0.5, -240, 0.5, -140)
CMDWindow.BackgroundColor3 = Color3.fromRGB(11, 11, 14)
CMDWindow.BorderSizePixel = 0
CMDWindow.ClipsDescendants = true
CMDWindow.Parent = BootGui

local BootCorner = Instance.new("UICorner")
BootCorner.CornerRadius = UDim.new(0, 12)
BootCorner.Parent = CMDWindow

-- Тонкая неоновая обводка
local BootStroke = Instance.new("UIStroke")
BootStroke.Color = Color3.fromRGB(0, 255, 163)
BootStroke.Transparency = 0.8
BootStroke.Thickness = 1
BootStroke.Parent = CMDWindow

local CMDHeader = Instance.new("Frame")
CMDHeader.Name = "CMDHeader"
CMDHeader.Size = UDim2.new(1, 0, 0, 36)
CMDHeader.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
CMDHeader.BorderSizePixel = 0
CMDHeader.Parent = CMDWindow

local CMDTitle = Instance.new("TextLabel")
CMDTitle.Size = UDim2.new(1, -20, 1, 0)
CMDTitle.Position = UDim2.new(0, 16, 0, 0)
CMDTitle.Text = "URAN V7// by : giantt_"
CMDTitle.TextColor3 = Color3.fromRGB(140, 140, 150)
CMDTitle.TextSize = 10
CMDTitle.Font = Enum.Font.Code
CMDTitle.TextXAlignment = Enum.TextXAlignment.Left
CMDTitle.BackgroundTransparency = 1
CMDTitle.Parent = CMDHeader

local TextContainer = Instance.new("ScrollingFrame")
TextContainer.Name = "TextContainer"
TextContainer.Size = UDim2.new(1, -32, 1, -52)
TextContainer.Position = UDim2.new(0, 16, 0, 44)
TextContainer.BackgroundTransparency = 1
TextContainer.BorderSizePixel = 0
TextContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
TextContainer.ScrollBarThickness = 2
TextContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 163)
TextContainer.Parent = CMDWindow

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 4)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Parent = TextContainer

local lineIndex = 0
local function AddCMDLog(text, color, delayTime)
    lineIndex = lineIndex + 1
    local LogLabel = Instance.new("TextLabel")
    LogLabel.Size = UDim2.new(1, 0, 0, 16)
    LogLabel.BackgroundTransparency = 1
    LogLabel.Text = text
    LogLabel.TextColor3 = color or Color3.fromRGB(180, 180, 190)
    LogLabel.TextSize = 11
    LogLabel.Font = Enum.Font.Code
    LogLabel.TextXAlignment = Enum.TextXAlignment.Left
    LogLabel.LayoutOrder = lineIndex
    LogLabel.Parent = TextContainer
    
    TextContainer.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 16)
    TweenService:Create(TextContainer, TweenInfo.new(0.2), {CanvasPosition = Vector2.new(0, TextContainer.CanvasSize.Y.Offset)}):Play()
    
    task.wait(delayTime)
end

-- =========================================================================
-- MAIN WINDOW (PREMIUM GLASSMORPHISM DESIGN)
-- =========================================================================
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 580, 0, 400)
Main.Position = UDim2.new(0.5, -290, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(11, 11, 14)
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Active = true
Main.Visible = false 
Main.Parent = SG

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 255, 163)
MainStroke.Transparency = 0.85
MainStroke.Thickness = 1
MainStroke.Parent = Main

-- Элегантный фоновый градиент (Свечение сверху вниз)
local GradFrame = Instance.new("Frame")
GradFrame.Size = UDim2.new(1, 0, 1, 0)
GradFrame.BackgroundTransparency = 0
GradFrame.BorderSizePixel = 0
GradFrame.ZIndex = 0
GradFrame.Parent = Main
Instance.new("UICorner", GradFrame).CornerRadius = UDim.new(0, 14)

local Grad = Instance.new("UIGradient")
Grad.Rotation = -90 
Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 163)),   
    ColorSequenceKeypoint.new(0.15, Color3.fromRGB(11, 11, 14)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 14))     
})
Grad.Parent = GradFrame

-- Асинхронный поток симуляции загрузки
task.spawn(function()
    AddCMDLog("Initializing Uran Core Engine V4...", Color3.fromRGB(140, 140, 150), 0.1)
    if not HasDrawing then
        AddCMDLog("[⚠️] Drawing API missing. HUD-Effects restricted.", Color3.fromRGB(255, 107, 107), 0.1)
    else
        AddCMDLog("[✓] Drawing API Matrix successfully linked.", Color3.fromRGB(0, 255, 163), 0.05)
    end
    AddCMDLog("Connecting securely to server pipeline...", Color3.fromRGB(140, 140, 150), 0.15)
    AddCMDLog("Injecting memory hooks & silent assets...", Color3.fromRGB(0, 255, 163), 0.1)
    AddCMDLog("UI Elements compiled successfully.", Color3.fromRGB(255, 215, 0), 0.05)
    
    TweenService:Create(CMDWindow, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = UDim2.new(0,0,0,280), Transparency = 1}):Play()
    task.wait(0.4)
    BootGui:Destroy()
    
    if Main then
        Main.Visible = true
        Main.Size = UDim2.new(0, 520, 0, 360) -- Плавный Scale-In эффект при открытии
        TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 580, 0, 400)}):Play()
    end
end)

-- =========================================================================
-- COSMETIC HUD: AMBIENT ISOTOPES BACKGROUND
-- =========================================================================
local ChemicalContainer = Instance.new("Frame")
ChemicalContainer.Size = UDim2.new(1, 0, 1, 0)
ChemicalContainer.BackgroundTransparency = 1
ChemicalContainer.ClipsDescendants = true 
ChemicalContainer.ZIndex = 1 
ChemicalContainer.Parent = Main

local ChemicalElements = {"U", "92", "☢", "UO₂", "²³⁵U", "•"}

local function SpawnUraniumIsotope()
    if not Main.Visible then return end 
    
    local IsotopeLabel = Instance.new("TextLabel")
    IsotopeLabel.BackgroundTransparency = 1
    IsotopeLabel.TextColor3 = Color3.fromRGB(0, 255, 163) 
    IsotopeLabel.TextSize = math.random(10, 14) 
    IsotopeLabel.Font = Enum.Font.GothamBold
    IsotopeLabel.ZIndex = 1
    IsotopeLabel.Text = ChemicalElements[math.random(1, #ChemicalElements)]
    IsotopeLabel.TextTransparency = 0.85
    IsotopeLabel.Parent = ChemicalContainer

    local startX = math.random(5, 95) / 100
    IsotopeLabel.Position = UDim2.new(startX, 0, 1.1, 0)

    local tweenInfo = TweenInfo.new(math.random(6, 9), Enum.EasingStyle.Linear)
    local tween = TweenService:Create(IsotopeLabel, tweenInfo, {
        Position = UDim2.new(startX + (math.random(-8, 8) / 100), 0, -0.1, 0),
        TextTransparency = 1
    })
    tween:Play()
    tween.Completed:Connect(function() IsotopeLabel:Destroy() end)
end

task.spawn(function()
    while true do
        task.wait(0.4)
        if Main.Visible then pcall(SpawnUraniumIsotope) end
    end
end)

-- =========================================================================
-- HEADER (HEADER COMPONENT)
-- =========================================================================
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, -32, 0, 60)
TitleFrame.Position = UDim2.new(0, 16, 0, 0)
TitleFrame.BackgroundTransparency = 1
TitleFrame.ZIndex = 2
TitleFrame.Parent = Main

local ChemIcon = Instance.new("TextLabel")
ChemIcon.Size = UDim2.new(0, 32, 0, 32)
ChemIcon.Position = UDim2.new(0, 0, 0.5, -16)
ChemIcon.BackgroundColor3 = Color3.fromRGB(19, 19, 26)
ChemIcon.Text = "⁹²U"
ChemIcon.TextColor3 = Color3.fromRGB(0, 255, 163)
ChemIcon.TextSize = 12
ChemIcon.Font = Enum.Font.Code
ChemIcon.ZIndex = 2
ChemIcon.Parent = TitleFrame
Instance.new("UICorner", ChemIcon).CornerRadius = UDim.new(0, 6)
local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(0, 255, 163)
IconStroke.Transparency = 0.7
IconStroke.Parent = ChemIcon

local Title1 = Instance.new("TextLabel")
Title1.Size = UDim2.new(0, 200, 1, 0)
Title1.Position = UDim2.new(0, 44, 0, 0)
Title1.Text = "URAN <font color='rgb(0, 255, 163)'>V6</font>"
Title1.RichText = true
Title1.TextColor3 = Color3.fromRGB(255, 255, 255)
Title1.TextSize = 16
Title1.Font = Enum.Font.GothamBold
Title1.TextXAlignment = Enum.TextXAlignment.Left
Title1.BackgroundTransparency = 1
Title1.ZIndex = 2
Title1.Parent = TitleFrame

local Title2 = Instance.new("TextLabel")
Title2.Size = UDim2.new(0, 250, 1, 0)
Title2.Position = UDim2.new(1, -250, 0, 0)
Title2.Text = "Fetching active realm..."
Title2.TextColor3 = Color3.fromRGB(110, 110, 120)
Title2.TextSize = 12
Title2.Font = Enum.Font.Gotham
Title2.TextXAlignment = Enum.TextXAlignment.Right
Title2.BackgroundTransparency = 1
Title2.ZIndex = 2
Title2.Parent = TitleFrame

task.spawn(function()
    local success, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
    if success and info then
        Title2.Text = string.upper(info.Name)
    else
        Title2.Text = "UNKNOWN REALM"
    end
end)

-- =========================================================================
-- NAVIGATION PANEL (SIDEBAR) & CONTENT CONTAINER
-- =========================================================================
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(0, 150, 1, -84)
Tabs.Position = UDim2.new(0, 16, 0, 68)
Tabs.BackgroundTransparency = 1
Tabs.ZIndex = 2
Tabs.Parent = Main

local TL = Instance.new("UIListLayout", Tabs)
TL.Padding = UDim.new(0, 6)

local Cont = Instance.new("Frame")
Cont.Name = "Cont"
Cont.Size = UDim2.new(1, -198, 1, -84)
Cont.Position = UDim2.new(0, 182, 0, 68)
Cont.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Cont.BackgroundTransparency = 0.2
Cont.BorderSizePixel = 0
Cont.ZIndex = 2
Cont.Parent = Main
Instance.new("UICorner", Cont).CornerRadius = UDim.new(0, 10)

local ContStroke = Instance.new("UIStroke")
ContStroke.Color = Color3.fromRGB(255,255,255)
ContStroke.Transparency = 0.96
ContStroke.Parent = Cont

local TabPool = {}
local BtnPool = {}
local ActiveCont = nil

function CreateTab(name)
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1, 0, 0, 36)
    B.BackgroundColor3 = Color3.fromRGB(19, 19, 26)
    B.BackgroundTransparency = 0.4
    B.Text = "   " .. name
    B.TextColor3 = Color3.fromRGB(130, 130, 140)
    B.TextSize = 13
    B.Font = Enum.Font.GothamSemibold
    B.TextXAlignment = Enum.TextXAlignment.Left
    B.ZIndex = 3
    B.Parent = Tabs
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
    
    local BStroke = Instance.new("UIStroke")
    BStroke.Color = Color3.fromRGB(255,255,255)
    BStroke.Transparency = 0.97
    BStroke.Parent = B

    local SF = Instance.new("ScrollingFrame")
    SF.Size = UDim2.new(1, -24, 1, -24)
    SF.Position = UDim2.new(0, 12, 0, 12)
    SF.BackgroundTransparency = 1
    SF.BorderSizePixel = 0
    SF.ScrollBarThickness = 2
    SF.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 163)
    SF.Visible = false
    SF.ZIndex = 3
    SF.Parent = Cont

    local L = Instance.new("UIListLayout")
    L.Padding = UDim.new(0, 6)
    L.SortOrder = Enum.SortOrder.LayoutOrder
    L.Parent = SF

    -- Дизайнерские отступы внутри контента
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 2)
    UIPadding.PaddingLeft = UDim.new(0, 2)
    UIPadding.Parent = SF

    L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        SF.CanvasSize = UDim2.new(0, 0, 0, L.AbsoluteContentSize.Y + 10)
    end)

    TabPool[name] = SF
    BtnPool[name] = {Btn = B, Stroke = BStroke}

    -- Плавные Hover/Click эффекты интерфейса
    B.MouseEnter:Connect(function()
        if ActiveCont ~= SF then
            TweenService:Create(B, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 210), BackgroundTransparency = 0.2}):Play()
        end
    end)
    B.MouseLeave:Connect(function()
        if ActiveCont ~= SF then
            TweenService:Create(B, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 130, 140), BackgroundTransparency = 0.4}):Play()
        end
    end)

    B.MouseButton1Click:Connect(function()
        if ActiveCont then ActiveCont.Visible = false end
        for n, d in pairs(BtnPool) do
            TweenService:Create(d.Btn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(19, 19, 26), BackgroundTransparency = 0.4, TextColor3 = Color3.fromRGB(130, 130, 140)}):Play()
            d.Stroke.Color = Color3.fromRGB(255,255,255)
            d.Stroke.Transparency = 0.97
        end
        TweenService:Create(B, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 255, 163), BackgroundTransparency = 0, TextColor3 = Color3.fromRGB(11, 11, 14)}):Play()
        BStroke.Color = Color3.fromRGB(0, 255, 163)
        BStroke.Transparency = 0.6
        SF.Visible = true
        ActiveCont = SF
    end)
end

-- =========================================================================
-- CONTROLS MODULE (MODERN UI TOGGLES)
-- =========================================================================
function AddToggle(tab, name, callback)
    local target = TabPool[tab]
    if not target then return end
    local Enabled = false

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -6, 0, 44)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
    Frame.BackgroundTransparency = 0.3
    Frame.Parent = target
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local FStroke = Instance.new("UIStroke")
    FStroke.Color = Color3.fromRGB(255,255,255)
    FStroke.Transparency = 0.96
    FStroke.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 14, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(210, 210, 215)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 4
    Label.Parent = Frame

    -- Красивый современный свитч (дизайнерская кнопка-переключатель)
    local SwitchBox = Instance.new("TextButton")
    SwitchBox.Size = UDim2.new(0, 36, 0, 20)
    SwitchBox.Position = UDim2.new(1, -50, 0.5, -10)
    SwitchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    SwitchBox.Text = ""
    SwitchBox.ZIndex = 4
    SwitchBox.Parent = Frame
    Instance.new("UICorner", SwitchBox).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 14, 0, 14)
    Circle.Position = UDim2.new(0, 3, 0.5, -7)
    Circle.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
    Circle.ZIndex = 5
    Circle.Parent = SwitchBox
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    SwitchBox.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        if Enabled then
            TweenService:Create(SwitchBox, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 255, 163)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = Color3.fromRGB(11, 11, 14)}):Play()
            TweenService:Create(Frame, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
            FStroke.Color = Color3.fromRGB(0, 255, 163)
            FStroke.Transparency = 0.8
        else
            TweenService:Create(SwitchBox, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = Color3.fromRGB(150, 150, 160)}):Play()
            TweenService:Create(Frame, TweenInfo.new(0.25), {BackgroundTransparency = 0.3}):Play()
            FStroke.Color = Color3.fromRGB(255,255,255)
            FStroke.Transparency = 0.96
        end
        pcall(callback, Enabled)
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F8 then
        if Main then Main.Visible = not Main.Visible end
    end
end)

-- =========================================================================
-- REGISTRATION & GENERATION (INITIALIZATION)
-- =========================================================================
CreateTab("Главное")
CreateTab("MM 2")
CreateTab("Doors")

-- Активация первой вкладки по умолчанию
local DefaultTab = "Главное"
BtnPool[DefaultTab].Btn.BackgroundColor3 = Color3.fromRGB(0, 255, 163)
BtnPool[DefaultTab].Btn.BackgroundTransparency = 0
BtnPool[DefaultTab].Btn.TextColor3 = Color3.fromRGB(11, 11, 14)
BtnPool[DefaultTab].Stroke.Color = Color3.fromRGB(0, 255, 163)
BtnPool[DefaultTab].Stroke.Transparency = 0.6
TabPool[DefaultTab].Visible = true
ActiveCont = TabPool[DefaultTab]

-- =========================================================================
-- MOBILE ESP SYSTEM (HIGHLIGHT CHAMS + BILLBOARD SYSTEM // 100% MOBILE FIX)
-- =========================================================================
local Mobile_ESP_Enabled = false
local Mobile_Folder = Instance.new("Folder")
Mobile_Folder.Name = "UranMobileESP"
Mobile_Folder.Parent = game:GetService("CoreGui") or PlayerGui

-- Функция создания подсветки для конкретного игрока
local function ApplyMobileESP(player)
    if player == LocalPlayer then return end
    
    local function CharacterAdded(char)
        task.wait(0.5) -- Ждем полной прогрузки персонажа
        if not Mobile_ESP_Enabled then return end
        
        local root = char:WaitForChild("HumanoidRootPart", 10)
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        
        if root and humanoid and not Mobile_Folder:FindFirstChild(player.Name) then
            -- Создаем контейнер для эффектов игрока
            local pContainer = Instance.new("Configuration")
            pContainer.Name = player.Name
            pContainer.Parent = Mobile_Folder
            
            -- 1. СИЛУЭТ (CHAMS) - Просвечивает неоном сквозь стены
            local highlight = Instance.new("Highlight")
            highlight.Name = "Chams"
            highlight.Adornee = char
            highlight.FillColor = Color3.fromRGB(0, 255, 163) -- Наш неоновый зеленый
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.OutlineTransparency = 0.2
            highlight.Parent = pContainer
            
            -- 2. ТЕКСТ НАД ГОЛОВОЙ (Никнейм + Дистанция + ХП)
            local bGui = Instance.new("BillboardGui")
            bGui.Name = "Tag"
            bGui.Adornee = root
            bGui.Size = UDim2.new(0, 200, 0, 50)
            bGui.StudsOffset = Vector3.new(0, 3.5, 0) -- Высота текста над головой
            bGui.AlwaysOnTop = true -- Чтобы текст кочевал сквозь стены
            bGui.Parent = pContainer
            
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
            txt.TextSize = 12
            txt.Font = Enum.Font.GothamBold
            txt.TextStrokeTransparency = 0 -- Черная обводка букв
            txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            txt.Parent = bGui
            
            -- Цикл постоянного обновления текста дистанции и ХП
            task.spawn(function()
                while char and char.Parent and pContainer and pContainer.Parent and Mobile_ESP_Enabled do
                    if root and humanoid and humanoid.Health > 0 then
                        local distance = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude) or 0)
                        txt.Text = string.format("%s\n[%d m] • [HP: %d]", player.Name, distance, math.floor(humanoid.Health))
                    else
                        break
                    end
                    task.wait(0.2) -- Обновляем дистанцию 5 раз в секунду (не лагает)
                end
            end)
        end
    end
    
    if player.Character then task.spawn(CharacterAdded, player.Character) end
    player.CharacterAdded:Connect(CharacterAdded)
end

-- Функция удаления подсветки
local function RemoveMobileESP(player)
    local found = Mobile_Folder:FindFirstChild(player.Name)
    if found then found:Destroy() end
end

-- Постоянный мониторинг игроков
task.spawn(function()
    while true do
        task.wait(1)
        if Mobile_ESP_Enabled then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and not Mobile_Folder:FindFirstChild(p.Name) then
                    ApplyMobileESP(p)
                end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(RemoveMobileESP)

-- Привязка к мобильному тумблеру вашего меню Uran Hub
AddToggle("Главное", "Mobile ESP (Chams)", function(state)
    Mobile_ESP_Enabled = state
    if state then
        for _, p in ipairs(Players:GetPlayers()) do ApplyMobileESP(p) end
    else
        Mobile_Folder:ClearAllChildren()
    end
end)
-- =========================================================================

-- =========================================================================
-- NOCLIP MODULE (ПРОХОД СКВОЗЬ СТЕНЫ)
-- =========================================================================
local NoclipEnabled = false

-- Системный цикл, отключающий коллизию персонажа перед обработкой физики игры
RunService.Stepped:Connect(function()
    if NoclipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- Создание тумблера в меню во вкладке "Главное"
AddToggle("Главное", "Noclip (Сквозь стены)", function(state)
    NoclipEnabled = state
end)

-- =========================================================================
-- PREMIUM MOBILE FLY MODULE (C FRAME MATRIX // 100% FIXED FOR PHONES)
-- =========================================================================
local FlyEnabled = false
local FlySpeed = 50 -- Скорость полета
local UpAxes = 0 -- Направление вверх/вниз

-- Отслеживаем экранные кнопки прыжка телефона для подъема и спуска
local FlyInputBegan; FlyInputBegan = UserInputService.InputBegan:Connect(function(input, processed)
    if not FlyEnabled then return end
    if input.KeyCode == Enum.KeyCode.Space then
        UpAxes = 1 -- Летим вверх при зажатии прыжка
    end
end)

local FlyInputEnded; FlyInputEnded = UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        UpAxes = 0 -- Стоим на месте, если отпустили
    end
end)

-- Основной цикл полета на CFrame (работает на всех смартфонах)
task.spawn(function()
    while true do
        RunService.RenderStepped:Wait() -- Максимальная частота кадров
        if FlyEnabled and LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            if root and humanoid then
                -- Удерживаем состояние полета, отключая стандартную гравитацию Roblox
                humanoid:ChangeState(Enum.HumanoidStateType.Flying)
                root.Velocity = Vector3.new(0, 0, 0) -- Обнуляем падение
                
                -- Рассчитываем движение на основе наклона камеры телефона
                local camCFrame = Camera.CFrame
                local moveDir = humanoid.MoveDirection -- Считываем экранный джойстик
                
                if moveDir.Magnitude > 0 then
                    -- Если тянем джойстик, плавно двигаем CFrame персонажа по вектору камеры
                    local flyVector = (camCFrame.LookVector * moveDir.Z) + (camCFrame.RightVector * moveDir.X)
                    root.CFrame = root.CFrame + (flyVector.Unit * (FlySpeed / 60))
                end
                
                -- Подъем вверх, если нажимаем на кнопку прыжка на экране
                if UpAxes == 1 then
                    root.CFrame = root.CFrame + Vector3.new(0, FlySpeed / 60, 0)
                end
            end
        end
    end
end)

-- Обновленный тумблер во вкладке "Главное" вашей панели
AddToggle("Главное", "Fly (Полет)", function(state)
    FlyEnabled = state
    if not state and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        if root then
            root.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)
-- =========================================================================

-- =========================================================================
-- INFINITE JUMP MODULE (БЕСКОНЕЧНЫЙ ПРЫЖОК)
-- =========================================================================
local InfJumpEnabled = false

-- Перехват каждого нажатия кнопки прыжка
UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled then
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        -- Если персонаж существует и жив, заставляем его прыгнуть в воздухе
        if humanoid and humanoid.Health > 0 then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Создание тумблера во вкладке "Главное"
AddToggle("Главное", "Бесконечный прыжок", function(state)
    InfJumpEnabled = state
end)

-- =========================================================================
-- NIGHT VISION MODULE (FULLBRIGHT ДЛЯ ВКЛАДКИ ГЛАВНОЕ)
-- =========================================================================
local NightVisionEnabled = false

-- Сохраняем дефолтные настройки игры, чтобы вернуть их при выключении
local DefaultLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient
}

-- Поток постоянного поддержания освещения (некоторые игры сбрасывают его сами)
task.spawn(function()
    while true do
        if NightVisionEnabled then
            Lighting.Brightness = 4
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        end
        task.wait(0.5) -- Проверка и обновление каждые полсекунды
    end
end)

-- Создание тумблера во вкладке "Главное"
AddToggle("Главное", "Ночное виденье", function(state)
    NightVisionEnabled = state
    if not state then
        -- Возвращаем стандартные настройки графики и освещения игры
        Lighting.Brightness = DefaultLighting.Brightness
        Lighting.ClockTime = DefaultLighting.ClockTime
        Lighting.FogEnd = DefaultLighting.FogEnd
        Lighting.GlobalShadows = DefaultLighting.GlobalShadows
        Lighting.Ambient = DefaultLighting.Ambient
    end
end)

-- =========================================================================
-- CONTROLS MODULE: PREMIUM SLIDER ELEMENT
-- =========================================================================
-- Новая функция создания слайдера, полностью подходящая под ваш дизайн
function AddSlider(tab, name, min, max, default, callback)
    local target = TabPool[tab]
    if not target then return end

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -6, 0, 50)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
    Frame.BackgroundTransparency = 0.3
    Frame.Parent = target
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local FStroke = Instance.new("UIStroke")
    FStroke.Color = Color3.fromRGB(255, 255, 255)
    FStroke.Transparency = 0.96
    FStroke.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -100, 0, 20)
    Label.Position = UDim2.new(0, 14, 0, 6)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(210, 210, 215)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 4
    Label.Parent = Frame

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 60, 0, 20)
    ValueLabel.Position = UDim2.new(1, -74, 0, 6)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 255, 163)
    ValueLabel.TextSize = 13
    ValueLabel.Font = Enum.Font.Code
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.ZIndex = 4
    ValueLabel.Parent = Frame

    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, -28, 0, 6)
    SliderButton.Position = UDim2.new(0, 14, 0, 34)
    SliderButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    SliderButton.Text = ""
    SliderButton.ZIndex = 4
    SliderButton.Parent = Frame
    Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(1, 0)

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(0, 255, 163)
    SliderBar.BorderSizePixel = 0
    SliderBar.ZIndex = 5
    SliderBar.Parent = SliderButton
    Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(1, 0)

    local SliderDot = Instance.new("Frame")
    SliderDot.Size = UDim2.new(0, 12, 0, 12)
    SliderDot.Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6)
    SliderDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderDot.ZIndex = 6
    SliderDot.Parent = SliderButton
    Instance.new("UICorner", SliderDot).CornerRadius = UDim.new(1, 0)

    local DotStroke = Instance.new("UIStroke")
    DotStroke.Color = Color3.fromRGB(0, 255, 163)
    DotStroke.Thickness = 1.5
    DotStroke.Parent = SliderDot

    -- ИСПРАВЛЕННАЯ ЛОГИКА ДЛЯ СЕНСОРНЫХ ЭКРАНОВ СМАРТФОНОВ
    local Dragging = false
    local function UpdateSlider(input)
        local RelativeX = input.Position.X - SliderButton.AbsolutePosition.X
        local Percentage = math.clamp(RelativeX / SliderButton.AbsoluteSize.X, 0, 1)
        local Value = math.floor(min + (max - min) * Percentage)
        
        ValueLabel.Text = tostring(Value)
        TweenService:Create(SliderBar, TweenInfo.new(0.05), {Size = UDim2.new(Percentage, 0, 1, 0)}):Play()
        TweenService:Create(SliderDot, TweenInfo.new(0.05), {Position = UDim2.new(Percentage, -6, 0.5, -6)}):Play()
        pcall(callback, Value)
    end

    -- Обработка начала касания пальцем или клика мыши
    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            UpdateSlider(input)
            TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
            FStroke.Color = Color3.fromRGB(0, 255, 163)
            FStroke.Transparency = 0.8
        end
    end)

    -- Обработка движения пальца по экрану (Touch)
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)

    -- Отпускание пальца
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
            TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
            FStroke.Color = Color3.fromRGB(255, 255, 255)
            FStroke.Transparency = 0.96
        end
    end)
end

-- =========================================================================
-- СОЗДАНИЕ СЛАЙДЕРА FOV ВО ВКЛАДКЕ "ГЛАВНОЕ"
-- =========================================================================
-- Минимальный FOV: 70, Максимальный: 120, По умолчанию: 70
AddSlider("Главное", "Field of View (FOV)", 70, 120, 70, function(value)
    Camera.FieldOfView = value
end)

-- =========================================================================
-- ADVANCED SPINBOT MODULE (ИСПРАВЛЕННАЯ ВЕРСИЯ: ИДЕАЛЬНАЯ ХОДЬБА БЕЗ ТРЯСКИ)
-- =========================================================================

local SpinBotEnabled = false
local SpinSpeed = 50 -- Скорость вращения по умолчанию

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Основной цикл вращения персонажа
RunService.RenderStepped:Connect(function(deltaTime)
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if root and humanoid and humanoid.Health > 0 then
        if SpinBotEnabled and humanoid.Sit == false then
            -- КРИТИЧЕСКИЙ ФИКС: Отключаем авто-поворот Roblox, чтобы убрать тряску при ходьбе
            humanoid.AutoRotate = false
            
            -- Плавное и чистое вращение по оси Y с привязкой к дельте времени
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(SpinSpeed * deltaTime * 10), 0)
        else
            -- Возвращаем стандартное управление, если чит выключен
            if humanoid.AutoRotate == false then
                humanoid.AutoRotate = true
            end
        end
    end
end)

-- Тумблер включения/выключения во вкладке "Главное"
AddToggle("Главное", "SpinBot", function(state)
    SpinBotEnabled = state
    
    -- Дополнительный сброс при ручном выключении тумблера
    if not state and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.AutoRotate = true end
    end
end)

-- Слайдер настройки скорости вращения во вкладке "Главное"
AddSlider("Главное", "SpinBot Speed", 10, 150, 50, function(value)
    SpinSpeed = value
end)

-- =========================================================================
-- PREMIUM 3RD PERSON CAMERA MODULE (КАМЕРА ОТ ТРЕТЬЕГО ЛИЦА)
-- =========================================================================

local ThirdPersonEnabled = false
local DefaultZoomDistance = 10 -- Дистанция камеры по умолчанию

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Постоянное поддержание обзора (на случай, если игра пытается вернуть 1-е лицо)
RunService.RenderStepped:Connect(function()
    if ThirdPersonEnabled and LocalPlayer then
        -- Разрешаем свободное отдаление камеры
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        
        -- Если игра заставляет зум быть намертво в режиме 1-го лица (0.5),
        -- мы принудительно отодвигаем её назад на безопасное расстояние
        if LocalPlayer.CameraMinZoomDistance < 2 then
            LocalPlayer.CameraMinZoomDistance = DefaultZoomDistance
        end
    end
end)

-- Тумблер включения/выключения во вкладке "Главное"
AddToggle("Главное", "Камера от 3-го лица", function(state)
    ThirdPersonEnabled = state
    
    if state then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        LocalPlayer.CameraMinZoomDistance = DefaultZoomDistance
    else
        -- Возвращаем стандартные настройки игры при выключении чита
        LocalPlayer.CameraMinZoomDistance = 0.5
    end
end)

-- Слайдер для настройки дальности обзора от 3-го лица
-- Минимум: 5 метров, Максимум: 30 метров, По умолчанию: 10 метров
AddSlider("Главное", "3rd Person Distance", 5, 30, 10, function(value)
    DefaultZoomDistance = value
    if ThirdPersonEnabled then
        LocalPlayer.CameraMinZoomDistance = value
    end
end)

-- =========================================================================
-- NATURAL DISASTER SURVIVAL: SERVER-REPLICATED DEBRIS VACUUM (ВИДНО ВСЕМ)
-- =========================================================================
local DebrisOrbitEnabled = false
local OrbitRadius = 12 -- Радиус кружения обломков (в метрах)
local OrbitSpeed = 4   -- Скорость вращения торнадо
local MaxParts = 35    -- Оптимальное количество деталей, чтобы сервер успевал их реплицировать

task.spawn(function()
    local angle = 0
    while true do
        RunService.RenderStepped:Wait() -- Посекундная синхронизация с кадрами физики
        if DebrisOrbitEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = LocalPlayer.Character.HumanoidRootPart
            local myPos = rootPart.Position
            
            -- Наращиваем угол вращения
            angle = angle + (OrbitSpeed * 0.015)
            
            local count = 0
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(LocalPlayer.Character) then
                    -- Проверяем, что деталь не принадлежит живому игроку
                    local isPlayer = false
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p.Character and part:IsDescendantOf(p.Character) then
                            isPlayer = true
                            break
                        end
                    end
                    
                    if not isPlayer then
                        count = count + 1
                        if count > MaxParts then break end
                        
                        -- Принудительно заставляем клиент симулировать физику этой детали
                        pcall(function()
                            part.CanCollide = false -- Отключаем коллизию между обломками, чтобы они не разлетались
                            if part.SetNetworkOwner then
                                part:SetNetworkOwner(LocalPlayer)
                            end
                        end)
                        
                        -- Рассчитываем целевую точку на круговой орбите вокруг вас
                        local partAngle = angle + (count * (math.pi * 2 / MaxParts))
                        local targetX = myPos.X + math.cos(partAngle) * OrbitRadius
                        local targetZ = myPos.Z + math.sin(partAngle) * OrbitRadius
                        local targetY = myPos.Y + 3 + (math.sin(angle + count) * 1.5) -- Кружатся на уровне тела и головы
                        
                        local targetPos = Vector3.new(targetX, targetY, targetZ)
                        
                        -- РЕПЛИКАЦИЯ НА СЕРВЕР: Двигаем через Velocity (силу притяжения), а не CFrame
                        local direction = (targetPos - part.Position)
                        local distance = direction.Magnitude
                        
                        -- Рассчитываем идеальный вектор скорости для удержания детали на орбите
                        if distance > 2 then
                            part.Velocity = direction.Unit * (distance * 14) -- Сила магнита
                        else
                            -- Касательная скорость для эффекта закручивания в вихрь
                            part.Velocity = direction.Unit * 5 + Vector3.new(-math.sin(partAngle), 0, math.cos(partAngle)) * (OrbitSpeed * 8)
                        end
                        
                        -- Добавляем хаотичное вращение деталей вокруг своей оси (видно всем)
                        part.RotVelocity = Vector3.new(10, 20, 10)
                    end
                end
            end
        end
    end
end)

-- Создание тумблера в вашем меню Uran Hub
AddToggle("Главное", "Orbit Debris (NDS)", function(state)
    DebrisOrbitEnabled = state
end)

-- =========================================================================
-- FLOATING TOGGLE BUTTON // ПЛАВАЮЩАЯ КНОПКА-КРУГ ДЛЯ ОТКРЫТИЯ МЕНЮ
-- =========================================================================
local FloatingButtonGui = Instance.new("ScreenGui")
FloatingButtonGui.Name = "UranFloatingButton"
FloatingButtonGui.ResetOnSpawn = false
FloatingButtonGui.Parent = PlayerGui

local RoundBtn = Instance.new("TextButton")
RoundBtn.Name = "RoundBtn"
RoundBtn.Size = UDim2.new(0, 60, 0, 60) -- Идеальный размер круга
RoundBtn.Position = UDim2.new(0, 20, 0.5, -30) -- Спавнится слева по центру экрана
RoundBtn.BackgroundColor3 = Color3.fromRGB(11, 11, 14) -- Черный цвет фона, как у меню
RoundBtn.Text = "УРАН"
RoundBtn.TextColor3 = Color3.fromRGB(0, 255, 163) -- Неоновый зеленый текст
RoundBtn.TextSize = 11
RoundBtn.Font = Enum.Font.Code
RoundBtn.Active = true
RoundBtn.ZIndex = 10000 -- Всегда поверх остальных окон
RoundBtn.Parent = FloatingButtonGui

-- Делаем кнопку идеально круглой
local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1, 0)
BtnCorner.Parent = RoundBtn

-- Красивая неоновая обводка круга
local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Color3.fromRGB(0, 255, 163)
BtnStroke.Thickness = 1.5
BtnStroke.Transparency = 0.3
BtnStroke.Parent = RoundBtn

-- ЛОГИКА СВОБОДНОГО ПЕРЕМЕЩЕНИЯ (DRAG И КЛИК)
local Dragging, DragInput, DragStart, StartPosition
local Dragged = false -- Флаг, чтобы отличать перетаскивание от обычного клика

RoundBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        Dragged = false
        DragStart = input.Position
        StartPosition = RoundBtn.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then 
                Dragging = false 
            end
        end)
    end
end)

RoundBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
        DragInput = input 
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == DragInput and Dragging then
        local Delta = input.Position - DragStart
        -- Если сдвинулся больше чем на 5 пикселей, считаем это перетаскиванием, а не кликом
        if Delta.Magnitude > 5 then
            Dragged = true
        end
        RoundBtn.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
    end
end)

-- ЛОГИКА ОТКРЫТИЯ/ЗАКРЫТИЯ ОСНОВНОГО МЕНЮ ПРИ КЛИКЕ
RoundBtn.MouseButton1Click:Connect(function()
    -- Открываем меню только если кнопку просто кликнули, а не тащили по экрану
    if not Dragged and Main then
        Main.Visible = not Main.Visible
        
        -- Небольшой визуальный эффект клика
        TweenService:Create(RoundBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 54, 0, 54)}):Play()
        task.wait(0.1)
        TweenService:Create(RoundBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 60, 0, 60)}):Play()
    end
end)

-- Плавное подсвечивание обводки при наведении мыши
RoundBtn.MouseEnter:Connect(function()
    TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0, Thickness = 2}):Play()
end)

RoundBtn.MouseLeave:Connect(function()
    TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.3, Thickness = 1.5}):Play()
end)
-- =========================================================================

-- =========================================================================
-- MURDER MYSTERY 2: MOBILE ROLE FINDER & COMPACT CHAMS (100% MOBILE FIX)
-- =========================================================================
local MM2_Mobile_Finder = false
local MobileHighlights = {}

-- 1. СОЗДАНИЕ УЛЬТРА-КОМПАКТНОГО МИНИ-МЕНЮ ДЛЯ ЭКРАНА ТЕЛЕФОНА
local MobileHUD = Instance.new("Frame")
MobileHUD.Name = "MM2MobileHUD"
MobileHUD.Size = UDim2.new(0, 160, 0, 50) -- Сильно уменьшен размер под экран смартфона
MobileHUD.Position = UDim2.new(0.02, 0, 0.15, 0) -- Аккуратно встает в левом верхнем углу
MobileHUD.BackgroundColor3 = Color3.fromRGB(11, 11, 14)
MobileHUD.BackgroundTransparency = 0.2
MobileHUD.BorderSizePixel = 0
MobileHUD.Visible = false
MobileHUD.ZIndex = 9999
MobileHUD.Parent = SG -- Привязываем к ScreenGui, чтобы было видно даже при закрытом основном меню

local MHUDCorner = Instance.new("UICorner")
MHUDCorner.CornerRadius = UDim.new(0, 8)
MHUDCorner.Parent = MobileHUD

local MHUDStroke = Instance.new("UIStroke")
MHUDStroke.Color = Color3.fromRGB(0, 255, 163)
MHUDStroke.Transparency = 0.6
MHUDStroke.Thickness = 1
MHUDStroke.Parent = MobileHUD

-- Текст убийцы (Компактный)
local MMurderer = Instance.new("TextLabel")
MMurderer.Size = UDim2.new(1, -10, 0, 20)
MMurderer.Position = UDim2.new(0, 10, 0, 5)
MMurderer.BackgroundTransparency = 1
MMurderer.Text = "🔪 : <font color='rgb(140,140,150)'>Поиск...</font>"
MMurderer.RichText = true
MMurderer.TextColor3 = Color3.fromRGB(255, 255, 255)
MMurderer.TextSize = 11
MMurderer.Font = Enum.Font.GothamBold
MMurderer.TextXAlignment = Enum.TextXAlignment.Left
MMurderer.Parent = MobileHUD

-- Текст шерифа (Компактный)
local MSheriff = Instance.new("TextLabel")
MSheriff.Size = UDim2.new(1, -10, 0, 20)
MSheriff.Position = UDim2.new(0, 10, 0, 25)
MSheriff.BackgroundTransparency = 1
MSheriff.Text = "🔫 : <font color='rgb(140,140,150)'>Поиск...</font>"
MSheriff.RichText = true
MSheriff.TextColor3 = Color3.fromRGB(255, 255, 255)
MSheriff.TextSize = 11
MSheriff.Font = Enum.Font.GothamBold
MSheriff.TextXAlignment = Enum.TextXAlignment.Left
MSheriff.Parent = MobileHUD

-- 2. ОЧИСТКА ЭФФЕКТОВ
local function ClearMobileMM2()
    for char, hl in pairs(MobileHighlights) do
        if hl then hl:Destroy() end
    end
    MobileHighlights = {}
    MMurderer.Text = "🔪 : <font color='rgb(140,140,150)'>Поиск...</font>"
    MSheriff.Text = "🔫 : <font color='rgb(140,140,150)'>Поиск...</font>"
end

-- 3. МОБИЛЬНЫЙ ЦИКЛ СКАНЕРА ИНВЕНТАРЕЙ (ОПТИМИЗИРОВАННЫЙ)
task.spawn(function()
    while true do
        task.wait(1.2) -- Чуть увеличен интервал, чтобы не лагало на слабых процессорах
        if MM2_Mobile_Finder then
            local murdererName = "Поиск..."
            local sheriffName = "Поиск..."
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    local backpack = player:FindFirstChild("Backpack")
                    
                    local hasKnife = false
                    local hasGun = false
                    
                    if backpack then
                        if backpack:FindFirstChild("Knife") then hasKnife = true end
                        if backpack:FindFirstChild("Gun") then hasGun = true end
                    end
                    
                    if character then
                        if character:FindFirstChild("Knife") then hasKnife = true end
                        if character:FindFirstChild("Gun") then hasGun = true end
                    end
                    
                    -- ОБРАБОТКА МУРДЕРА
                    if hasKnife and character and character.Parent then
                        murdererName = player.DisplayName
                        if #murdererName > 10 then murdererName = murdererName:sub(1, 8) .. ".." end -- Обрезка длинных ников
                        
                        if not MobileHighlights[character] or MobileHighlights[character].FillColor ~= Color3.fromRGB(255, 50, 50) then
                            if MobileHighlights[character] then MobileHighlights[character]:Destroy() end
                            
                            local hl = Instance.new("Highlight")
                            hl.Adornee = character
                            hl.FillColor = Color3.fromRGB(255, 50, 50) -- Красный
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0.3
                            hl.AlwaysOnTop = true
                            hl.Parent = character
                            MobileHighlights[character] = hl
                        end
                        
                    -- ОБРАБОТКА ШЕРИФА
                    elseif hasGun and character and character.Parent then
                        sheriffName = player.DisplayName
                        if #sheriffName > 10 then sheriffName = sheriffName:sub(1, 8) .. ".." end
                        
                        if not MobileHighlights[character] or MobileHighlights[character].FillColor ~= Color3.fromRGB(50, 150, 255) then
                            if MobileHighlights[character] then MobileHighlights[character]:Destroy() end
                            
                            local hl = Instance.new("Highlight")
                            hl.Adornee = character
                            hl.FillColor = Color3.fromRGB(50, 150, 255) -- Синий
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0.3
                            hl.AlwaysOnTop = true
                            hl.Parent = character
                            MobileHighlights[character] = hl
                        end
                    end
                end
            end
            
            -- Обновляем мини-текст
            if murdererName ~= "Поиск..." then
                MMurderer.Text = string.format("🔪 : <font color='rgb(255, 50, 50)'>%s</font>", murdererName)
            else
                MMurderer.Text = "🔪 : <font color='rgb(140,140,150)'>Поиск...</font>"
            end
            
            if sheriffName ~= "Поиск..." then
                MSheriff.Text = string.format("🔫 : <font color='rgb(50, 150, 255)'>%s</font>", sheriffName)
            else
                MSheriff.Text = "🔫 : <font color='rgb(140,140,150)'>Поиск...</font>"
            end
            
            -- Чистим кэш
            for char, hl in pairs(MobileHighlights) do
                if not char or not char.Parent then
                    if hl then hl:Destroy() end
                    MobileHighlights[char] = nil
                end
            end
        end
    end
end)

-- 4. ПРИВЯЗКА К ТУМБЛЕРУ ВО ВКЛАДКЕ "MM 2"
AddToggle("MM 2", "Role Finder + ESP", function(state)
    MM2_Mobile_Finder = state
    MobileHUD.Visible = state
    if not state then
        ClearMobileMM2()
    end
end)
-- =========================================================================
