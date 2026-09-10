--==================================================
-- CALLINGY HUB | PARTE 1/3
-- KEY SYSTEM + INTERFACE + VERIFICAÇÃO DE CONTA
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- DADOS DA CONTA
--==================================================
_G.Conta = {
    Nome = Player.Name,
    Id = Player.UserId,
    Verificada = false
}

--==================================================
-- CONFIGURAÇÕES
--==================================================
local GET_KEY_LINK = "https://discord.gg/vYdgQH5nTz"
local NORMAL_KEY = "CallYUpdate"

local PERMANENT_KEYS = {
    "CL-PRISON-7X2K-9F8D-Z4QP",
    "CL-PRISON-3M5R-1E6T-W8BV",
    "CL-PRISON-8Y9H-4A2P-L7XC",
    "CL-PRISON-2B6N-5K3J-R9MG",
    "CL-PRISON-9D4F-7C1V-X3ZW",
    "CL-PRISON-5Q8Z-2W4E-T6YU",
    "CL-PRISON-1R3T-6Y8U-I9OP",
    "CL-PRISON-7A1S-4D2F-G5HJ",
    "CL-PRISON-6L9Z-0X3C-V4BN",
    "CL-PRISON-3K5M-8Q1W-2E4R"
}

--==================================================
-- VARIÁVEIS GLOBAIS
--==================================================
_G.HubCarregado = false
_G.Rayfield = nil
_G.Window = nil

--==================================================
-- FUNÇÕES DE KEY
--==================================================
local function NormalizeKey(text)
    text = tostring(text or "")
    text = text:gsub("%s+", "")
    return text:lower()
end

local function IsValidKey(text)
    local input = NormalizeKey(text)
    if input == NormalizeKey(NORMAL_KEY) then return true end
    for _, key in ipairs(PERMANENT_KEYS) do
        if input == NormalizeKey(key) then return true end
    end
    return false
end

--==================================================
-- GUI DE VERIFICAÇÃO
--==================================================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "CallingYKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.DisplayOrder = 999999
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
KeyGui.Parent = PlayerGui

local KeyMain = Instance.new("Frame")
KeyMain.Size = UDim2.fromOffset(360, 235)
KeyMain.Position = UDim2.new(0.5, -180, 0.5, -117)
KeyMain.BackgroundColor3 = Color3.fromRGB(18, 18, 27)
KeyMain.BorderSizePixel = 0
KeyMain.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyMain

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 1.5
KeyStroke.Color = Color3.fromRGB(70, 70, 95)
KeyStroke.Parent = KeyMain

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 0, 45)
Title.Position = UDim2.fromOffset(18, 8)
Title.BackgroundTransparency = 1
Title.Text = "CALLINGY HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 21
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = KeyMain

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -45, 0, 10)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255, 100, 100)
Close.TextSize = 28
Close.Font = Enum.Font.GothamBold
Close.Parent = KeyMain

Close.Activated:Connect(function() KeyGui:Destroy() end)

local Description = Instance.new("TextLabel")
Description.Size = UDim2.new(1, -36, 0, 35)
Description.Position = UDim2.fromOffset(18, 55)
Description.BackgroundTransparency = 1
Description.Text = "Digite sua Key para continuar"
Description.TextColor3 = Color3.fromRGB(175, 175, 190)
Description.TextSize = 14
Description.Font = Enum.Font.Gotham
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.Parent = KeyMain

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -36, 0, 42)
KeyBox.Position = UDim2.fromOffset(18, 94)
KeyBox.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Digite sua Key..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 135)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyMain

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 9)
BoxCorner.Parent = KeyBox

local Verify = Instance.new("TextButton")
Verify.Size = UDim2.new(0.5, -21, 0, 40)
Verify.Position = UDim2.fromOffset(18, 145)
Verify.BackgroundColor3 = Color3.fromRGB(55, 55, 80)
Verify.BorderSizePixel = 0
Verify.Text = "VERIFICAR KEY"
Verify.TextColor3 = Color3.fromRGB(255, 255, 255)
Verify.TextSize = 13
Verify.Font = Enum.Font.GothamBold
Verify.Parent = KeyMain

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 9)
VerifyCorner.Parent = Verify

local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.new(0.5, -21, 0, 40)
GetKey.Position = UDim2.new(0.5, 3, 0, 145)
GetKey.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
GetKey.BorderSizePixel = 0
GetKey.Text = "PEGAR KEY"
GetKey.TextColor3 = Color3.fromRGB(220, 220, 235)
GetKey.TextSize = 13
GetKey.Font = Enum.Font.GothamBold
GetKey.Parent = KeyMain

local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0, 9)
GetCorner.Parent = GetKey

GetKey.Activated:Connect(function()
    if setclipboard then
        pcall(function() setclipboard(GET_KEY_LINK) end)
    end
    GetKey.Text = "LINK COPIADO!"
    task.delay(1.5, function() if GetKey.Parent then GetKey.Text = "PEGAR KEY" end end)
end)

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -36, 0, 30)
Status.Position = UDim2.fromOffset(18, 190)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(175, 175, 190)
Status.TextSize = 13
Status.Font = Enum.Font.GothamBold
Status.Parent = KeyMain

--==================================================
-- ANIMAÇÕES E DRAG
--==================================================
local function Shake()
    local original = KeyMain.Position
    for i = 1, 4 do
        local offset = (i % 2 == 0) and 8 or -8
        KeyMain.Position = original + UDim2.fromOffset(offset, 0)
        task.wait(0.04)
    end
    KeyMain.Position = original
end

local draggingKey = false
local dragStartKey
local startKeyPosition

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingKey = true
        dragStartKey = input.Position
        startKeyPosition = KeyMain.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not draggingKey then return end
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartKey
        KeyMain.Position = UDim2.new(
            startKeyPosition.X.Scale, startKeyPosition.X.Offset + delta.X,
            startKeyPosition.Y.Scale, startKeyPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingKey = false
    end
end)

local OriginalSize = KeyMain.Size
KeyMain.Size = UDim2.fromOffset(0, 0)
TweenService:Create(KeyMain, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = OriginalSize}):Play()

--==================================================
-- CARREGAR RAYFIELD
--==================================================
local function CarregarRayfield()
    local success, RayfieldSource = pcall(function()
        return game:HttpGet("https://sirius.menu/gen2")
    end)
    
    if not success or not RayfieldSource then
        Status.Text = "❌ Falha ao carregar menu!"
        Status.TextColor3 = Color3.fromRGB(255, 85, 85)
        return false
    end

    local LoadRayfield, Erro = loadstring(RayfieldSource)
    if not LoadRayfield then
        Status.Text = "❌ Erro no código do menu!"
        Status.TextColor3 = Color3.fromRGB(255, 85, 85)
        return false
    end

    _G.Rayfield = LoadRayfield()
    return true
end

--==================================================
-- VERIFICAÇÃO DE KEY
--==================================================
local Verificando = false

local function ProcessarKey()
    if Verificando then return end
    Verificando = true
    Verify.Text = "VERIFICANDO..."
    Status.Text = ""

    task.wait(0.2)

    if IsValidKey(KeyBox.Text) then
        Status.Text = "✅ KEY VÁLIDA! CARREGANDO..."
        Status.TextColor3 = Color3.fromRGB(75, 255, 125)
        
        if not CarregarRayfield() then
            Verify.Text = "VERIFICAR KEY"
            Verificando = false
            return
        end

        _G.Conta.Verificada = true
        _G.HubCarregado = true
        
        -- ✅ NOTIFICAÇÃO DE CONTA POR 5 SEGUNDOS
        task.wait(0.3)
        _G.Rayfield:Notify({
            Title = "✅ Conta Verificada",
            Content = string.format("Bem-vindo(a): %s\nID: %d", _G.Conta.Nome, _G.Conta.Id),
            Duration = 5
        })

        KeyGui:Destroy()
        print("✅ Parte 1 concluída")
    else
        Status.Text = "❌ KEY INVÁLIDA!"
        Status.TextColor3 = Color3.fromRGB(255, 85, 85)
        Shake()
        Verify.Text = "VERIFICAR KEY"
        Verificando = false
    end
end

Verify.Activated:Connect(ProcessarKey)
KeyBox.FocusLost:Connect(function(enter)
    if enter then ProcessarKey() end
end)

-- FUNÇÃO GLOBAL DE ESPERA
_G.WaitHubReady = function()
    repeat task.wait(0.1) until _G.HubCarregado
end
--==================================================
-- CALLINGY HUB | PARTE 2/3
-- NÚCLEO + SISTEMAS + BOTÕES MOBILE CORRIGIDOS
--==================================================

_G.WaitHubReady()
local Rayfield = _G.Rayfield
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- VARIÁVEIS
--==================================================
local character, humanoid, rootPart

-- Follow Ball
local FollowBall = false
local followConnection
local followDistance = 1.6
local FollowButtonGui = nil
local FollowButton = nil
local FollowButtonStroke = nil
local ShowFollowButton = false

-- GK
local GKAutoCatch = false
local GKDistance = 50
local GKCooldown = 0.25
local LastCatch = 0

-- Reach
local ReachAtivo = false
local ReachValor = 15
local ReachBola = nil

-- Control Ball
local ControllBall = false
local ControlSpeed = 35
local CameraDistance = 8
local ControlConnection = nil
local CameraConnection = nil
local ControlledBall = nil
local OldCameraType = nil
local OldCameraSubject = nil
local SavedMinZoom = nil
local SavedMaxZoom = nil
local MobileControlEnabled = false
local MobileButton = nil
local MobileButtonStroke = nil
local MobileButtonGui = nil

-- ESP
local BallESP = false

--==================================================
-- PERSONAGEM
--==================================================
local function setupCharacter(char)
    character = char
    humanoid = char:WaitForChild("Humanoid", 10)
    rootPart = char:WaitForChild("HumanoidRootPart", 10)
end

setupCharacter(Player.Character or Player.CharacterAdded:Wait())
Player.CharacterAdded:Connect(function(char)
    setupCharacter(char)
end)

--==================================================
-- LOCALIZAR BOLA
--==================================================
local function findBall()
    local stadium = Workspace:FindFirstChild("WorkspaceStadiumSounds")
    if stadium then
        local tps = stadium:FindFirstChild("TPS")
        if tps and tps:IsA("BasePart") then return tps end
    end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "TPS" and obj:IsA("BasePart") then return obj end
    end
    return nil
end

local function GetBalls()
    local balls = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "TPS" and obj.Parent then
            table.insert(balls, obj)
        end
    end
    return balls
end

local function GetNearestBall()
    if not rootPart or not rootPart.Parent then return nil, math.huge end
    local nearest = nil
    local nearestDistance = math.huge
    for _, ball in ipairs(GetBalls()) do
        if ball.Parent then
            local distance = (rootPart.Position - ball.Position).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearest = ball
            end
        end
    end
    return nearest, nearestDistance
end

--==================================================
-- FOLLOW BALL
--==================================================
local function stopFollowing()
    FollowBall = false
    if humanoid then humanoid:Move(Vector3.zero, false) end
    if followConnection then followConnection:Disconnect() followConnection = nil end
end

local function startFollowing()
    if FollowBall then return end
    FollowBall = true
    if followConnection then followConnection:Disconnect() end

    followConnection = RunService.RenderStepped:Connect(function()
        if not FollowBall or not character or not character.Parent or not humanoid or humanoid.Health <= 0 or not rootPart then return end

        if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.D) then return end

        local ball = findBall()
        if not ball then return end

        local target = Vector3.new(ball.Position.X, rootPart.Position.Y, ball.Position.Z)
        local direction = target - rootPart.Position
        local distance = direction.Magnitude

        if distance > followDistance then
            humanoid:Move(direction.Unit, false)
            rootPart.CFrame = CFrame.new(rootPart.Position, target)
        else
            humanoid:Move(Vector3.zero, false)
        end
    end)
end

local function SetFollowBall(estado)
    if estado then startFollowing() else stopFollowing() end
    if FollowButton then UpdateFollowButton() end
end

--==================================================
-- ✅ BOTÃO MOBILE FOLLOW BALL (NOVO)
--==================================================
function UpdateFollowButton()
    if not FollowButton then return end
    if FollowBall then
        FollowButton.Text = "FOLLOW\nON"
        FollowButton.BackgroundColor3 = Color3.fromRGB(35, 115, 75)
        if FollowButtonStroke then FollowButtonStroke.Color = Color3.fromRGB(80, 255, 130) end
    else
        FollowButton.Text = "FOLLOW\nOFF"
        FollowButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        if FollowButtonStroke then FollowButtonStroke.Color = Color3.fromRGB(100, 100, 120) end
    end
end

function DestroyFollowButton()
    if FollowButtonGui then FollowButtonGui:Destroy() end
    FollowButtonGui = nil FollowButton = nil FollowButtonStroke = nil
end

function CreateFollowButton()
    DestroyFollowButton()
    FollowButtonGui = Instance.new("ScreenGui")
    FollowButtonGui.Name = "CallingYFollowMobile"
    FollowButtonGui.ResetOnSpawn = false
    FollowButtonGui.IgnoreGuiInset = true
    FollowButtonGui.DisplayOrder = 1000
    FollowButtonGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    FollowButtonGui.Parent = PlayerGui

    FollowButton = Instance.new("TextButton")
    FollowButton.Name = "FollowToggle"
    FollowButton.Size = UDim2.fromOffset(125, 58)
    FollowButton.Position = UDim2.new(0, 20, 1, -145)
    FollowButton.BackgroundColor3 = Color3.fromRGB(45,45,65)
    FollowButton.BorderSizePixel = 0
    FollowButton.TextColor3 = Color3.fromRGB(220,220,230)
    FollowButton.TextSize = 13
    FollowButton.Font = Enum.Font.GothamBold
    FollowButton.TextWrapped = true
    FollowButton.Parent = FollowButtonGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,12)
    corner.Parent = FollowButton

    FollowButtonStroke = Instance.new("UIStroke")
    FollowButtonStroke.Thickness = 1.5
    FollowButtonStroke.Parent = FollowButton

    FollowButton.Activated:Connect(function()
        SetFollowBall(not FollowBall)
    end)

    -- ✅ ARRASTO CORRETO: SÓ SEGURANDO NO BOTÃO
    local dragging = false
    local dragStart
    local startPos

    FollowButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = FollowButton.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            FollowButton.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UpdateFollowButton()
end

local function ToggleFollowButton(visivel)
    ShowFollowButton = visivel
    if visivel then
        CreateFollowButton()
    else
        DestroyFollowButton()
    end
end

--==================================================
-- REACH
--==================================================
local function AcharBolaReach()
    local tps = Workspace:FindFirstChild("WorkspaceStadiumSounds")
    if tps then local bola = tps:FindFirstChild("TPS") if bola and bola:IsA("BasePart") then return bola end end
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v.Name == "TPS" and v:IsA("BasePart") and not v.Anchored then return v end
    end
    return nil
end

local function PartesPersonagem()
    local partes = {}
    if not character then return partes end
    for _, v in ipairs(character:GetChildren()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then table.insert(partes, v) end
    end
    return partes
end

local function ExecutarReach()
    if not ReachAtivo then return end
    if not ReachBola or not ReachBola.Parent then ReachBola = AcharBolaReach() end
    if not ReachBola or not rootPart then return end

    for _, parte in ipairs(PartesPersonagem()) do
        if (ReachBola.Position - parte.Position).Magnitude <= ReachValor then
            pcall(function() firetouchinterest(ReachBola, parte, 0) task.wait(0.01) firetouchinterest(ReachBola, parte, 1) end)
        end
    end
    if (ReachBola.Position - rootPart.Position).Magnitude <= ReachValor then
        pcall(function() firetouchinterest(ReachBola, rootPart, 0) task.wait(0.01) firetouchinterest(ReachBola, rootPart, 1) end)
    end
end

--==================================================
-- CONTROL BALL + ✅ BOTÃO MOBILE CORRIGIDO
--==================================================
local function UpdateMobileButton()
    if not MobileButton then return end
    if ControllBall then
        MobileButton.Text = "CONTROL\nON"
        MobileButton.BackgroundColor3 = Color3.fromRGB(35, 115, 75)
        if MobileButtonStroke then MobileButtonStroke.Color = Color3.fromRGB(80, 255, 130) end
    else
        MobileButton.Text = "CONTROL\nOFF"
        MobileButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        if MobileButtonStroke then MobileButtonStroke.Color = Color3.fromRGB(100, 100, 120) end
    end
end

local function DestroyMobileButton()
    if MobileButtonGui then MobileButtonGui:Destroy() end
    MobileButtonGui = nil MobileButton = nil MobileButtonStroke = nil
end

local function StopControllBall()
    ControllBall = false
    if ControlConnection then ControlConnection:Disconnect() ControlConnection = nil end
    if CameraConnection then CameraConnection:Disconnect() CameraConnection = nil end
    local camera = Workspace.CurrentCamera
    if camera then
        if SavedMinZoom ~= nil then Player.CameraMinZoomDistance = SavedMinZoom end
        if SavedMaxZoom ~= nil then Player.CameraMaxZoomDistance = SavedMaxZoom end
        camera.CameraType = Enum.CameraType.Custom
        if humanoid and humanoid.Parent then camera.CameraSubject = humanoid end
    end
    ControlledBall = nil
    UpdateMobileButton()
end

local function StartControllBall()
    if ControlConnection then ControlConnection:Disconnect() end
    if CameraConnection then CameraConnection:Disconnect() end
    if not rootPart or not rootPart.Parent then ControllBall = false; ControlledBall = nil; return end
    local ball = GetNearestBall()
    if not ball or not ball.Parent then
        ControllBall = false; ControlledBall = nil; UpdateMobileButton()
        pcall(function() Rayfield:Notify({Title = "Controll Ball", Content = "Nenhuma TPS encontrada.", Duration = 3}) end)
        return
    end
    ControlledBall = ball
    local camera = Workspace.CurrentCamera
    if not camera then ControllBall = false; ControlledBall = nil; return end
    OldCameraType = camera.CameraType; OldCameraSubject = camera.CameraSubject
    SavedMinZoom = Player.CameraMinZoomDistance; SavedMaxZoom = Player.CameraMaxZoomDistance
    ControllBall = true; camera.CameraType = Enum.CameraType.Custom; camera.CameraSubject = ControlledBall

    ControlConnection = RunService.RenderStepped:Connect(function()
        if not ControllBall or not ControlledBall or not ControlledBall.Parent or not rootPart or not rootPart.Parent then return StopControllBall() end
        local direction = camera.CFrame.LookVector
        if direction.Magnitude > 0.001 then ControlledBall.AssemblyLinearVelocity = direction.Unit * ControlSpeed end
    end)

    CameraConnection = RunService.RenderStepped:Connect(function()
        if not ControllBall or not ControlledBall or not ControlledBall.Parent then return end
        camera.CameraType = Enum.CameraType.Custom; camera.CameraSubject = ControlledBall
        pcall(function() Player.CameraMinZoomDistance = CameraDistance; Player.CameraMaxZoomDistance = CameraDistance end)
    end)
    UpdateMobileButton()
    pcall(function() Rayfield:Notify({Title = "Controll Ball", Content = "Controlando a TPS selecionada.", Duration = 2}) end)
end

local function SetControllBall(value) if value then if not ControllBall then StartControllBall() end else StopControllBall() end end

local function CreateMobileButton()
    DestroyMobileButton()
    MobileButtonGui = Instance.new("ScreenGui")
    MobileButtonGui.Name = "CallingYMobileControl"
    MobileButtonGui.ResetOnSpawn = false; MobileButtonGui.IgnoreGuiInset = true; MobileButtonGui.DisplayOrder = 1000; MobileButtonGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    MobileButtonGui.Parent = PlayerGui
    MobileButton = Instance.new("TextButton")
    MobileButton.Name = "ControlBall"
    MobileButton.Size = UDim2.fromOffset(125, 58); MobileButton.Position = UDim2.new(1, -145, 1, -145)
    MobileButton.BackgroundColor3 = Color3.fromRGB(45,45,65); MobileButton.BorderSizePixel = 0; MobileButton.AutoButtonColor = true
    MobileButton.TextColor3 = Color3.fromRGB(220,220,230); MobileButton.TextSize = 13; MobileButton.Font = Enum.Font.GothamBold; MobileButton.TextWrapped = true; MobileButton.Active = true
    MobileButton.Parent = MobileButtonGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,12); corner.Parent = MobileButton
    MobileButtonStroke = Instance.new("UIStroke")
    MobileButtonStroke.Thickness = 1.5; MobileButtonStroke.Parent = MobileButton
    MobileButton.Activated:Connect(function() SetControllBall(not ControllBall) end)

    -- ✅ ARRASTO CORRIGIDO: SÓ SEGURANDO NO BOTÃO
    local dragging = false; local dragStart; local startPosition
    MobileButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPosition = MobileButton.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MobileButton.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
        end
    end)
    UpdateMobileButton()
end

--==================================================
-- LOOP PRINCIPAL
--==================================================
RunService.Heartbeat:Connect(function()
    if not character or not humanoid or not rootPart or humanoid.Health <= 0 then return end
    local ball, distance = GetNearestBall()
    if not ball then return end

    if GKAutoCatch and os.clock() - LastCatch >= GKCooldown and distance <= GKDistance then
        local event = ReplicatedStorage:FindFirstChild("CatchBall")
        if event and event:IsA("RemoteEvent") then LastCatch = os.clock(); event:FireServer(ball) end
    end

    ExecutarReach()
end)

--==================================================
-- EXPORTA PARA PARTE 3
--==================================================
_G.Core = {
    -- Personagem
    GetCharacter = function() return character end,
    GetHumanoid = function() return humanoid end,
    GetRootPart = function() return rootPart end,
    SetupCharacter = setupCharacter,

    -- Bola
    FindBall = findBall,
    GetBalls = GetBalls,
    GetNearestBall = GetNearestBall,

    -- Follow Ball
    SetFollowBall = SetFollowBall,
    GetFollowState = function() return FollowBall end,
    GetFollowDistance = function() return followDistance end,
    SetFollowDistance = function(v) followDistance = v end,
    ToggleFollowButton = ToggleFollowButton, -- ✅ NOVO
    GetFollowButtonState = function() return ShowFollowButton end,

    -- GK
    SetGKAutoCatch = function(v) GKAutoCatch = v end,
    GetGKAutoCatch = function() return GKAutoCatch end,
    SetGKDistance = function(v) GKDistance = v end,
    SetGKCooldown = function(v) GKCooldown = v end,
    GetGKValues = function() return GKDistance, GKCooldown, LastCatch end,
    SetLastCatch = function(v) LastCatch = v end,

    -- Reach
    SetReach = function(v) ReachAtivo = v; if v then ReachBola = AcharBolaReach() end end,
    GetReachState = function() return ReachAtivo end,
    SetReachRange = function(v) ReachValor = v end,
    GetReachRange = function() return ReachValor end,
    UpdateReachBall = function() ReachBola = AcharBolaReach() end,

    -- Control Ball
    SetControllBall = SetControllBall,
    GetControllState = function() return ControllBall end,
    SetControlSpeed = function(v) ControlSpeed = v end,
    SetCameraDistance = function(v) CameraDistance = v end,
    SetMobileButton = function(v) MobileControlEnabled = v; if v then CreateMobileButton() else DestroyMobileButton() end end,
    GetMobileState = function() return MobileControlEnabled end,

    -- ESP
    GetBallESP = function() return BallESP end,
    SetBallESP = function(v) BallESP = v end
}

print("✅ Parte 2 concluída")
--==================================================
-- CALLINGY HUB | PARTE 3/3
-- INTERFACE RAYFIELD + BOTÃO FOLLOW MOBILE
--==================================================

_G.WaitHubReady()
local Rayfield = _G.Rayfield
local Core = _G.Core
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer

--==================================================
-- JANELA PRINCIPAL
--==================================================
local Window = Rayfield:CreateWindow({
    name = "CallingY Hub",
    subtitle = "Follow Ball + GK + Control Ball + REACH",
    sidebarLayout = true,
})
_G.Window = Window

--==================================================
-- ✅ ABA FOLLOW BALL COM BOTÃO P/ BOTÃO MOBILE
--==================================================
local FollowTab = Window:CreateTab({name = "Follow Ball", icon = "circle"})
FollowTab:CreateToggle({
    name = "Follow Ball",
    flag = "FollowBall",
    currentValue = Core.GetFollowState(),
    callback = Core.SetFollowBall
})
FollowTab:CreateSlider({
    name = "Distância de Parada",
    range = {0.5, 10},
    increment = 0.1,
    suffix = " studs",
    currentValue = Core.GetFollowDistance(),
    flag = "FollowDist",
    callback = Core.SetFollowDistance
})
FollowTab:CreateKeybind({
    name = "Tecla Rápida",
    currentKeybind = "F",
    holdToInteract = false,
    flag = "FollowKey",
    callback = function() Core.SetFollowBall(not Core.GetFollowState()) end
})
-- ✅ NOVO: Botão para ativar/mostrar botão mobile
FollowTab:CreateToggle({
    name = "Botão Mobile",
    flag = "FollowMobileBtn",
    currentValue = Core.GetFollowButtonState(),
    callback = Core.ToggleFollowButton
})
FollowTab:CreateButton({
    name = "Teleportar Para Bola",
    callback = function()
        local root = Core.GetRootPart()
        if root then
            local b = Core.GetNearestBall()
            if b then root.CFrame = b.CFrame + Vector3.new(0,3,0) end
        end
    end
})
FollowTab:CreateButton({
    name = "Atualizar Bola",
    callback = function() Core.GetBalls() end
})

--==================================================
-- ABA GK
--==================================================
local GKTab = Window:CreateTab({name = "GK", icon = "shield"})
GKTab:CreateToggle({
    name = "GK Auto Catch",
    flag = "GKAutoCatch",
    callback = Core.SetGKAutoCatch
})
GKTab:CreateSlider({
    name = "Distância para Pegar",
    range = {1, 150},
    increment = 1,
    suffix = " studs",
    flag = "GKDistance",
    callback = Core.SetGKDistance
})
GKTab:CreateSlider({
    name = "Tempo entre Pegadas",
    range = {0.05, 2},
    increment = 0.05,
    suffix = " seg",
    currentValue = 0.25,
    flag = "GKCooldown",
    callback = Core.SetGKCooldown
})
GKTab:CreateKeybind({
    name = "Tecla do GK",
    currentKeybind = "G",
    holdToInteract = false,
    flag = "GKKey",
    callback = function() Core.SetGKAutoCatch(not Core.GetGKAutoCatch()) end
})
GKTab:CreateButton({
    name = "Pegar Bola Próxima",
    callback = function()
        local ball, dist = Core.GetNearestBall()
        local root = Core.GetRootPart()
        local maxDist = Core.GetGKValues()
        if ball and root and dist <= maxDist then
            local event = game:GetService("ReplicatedStorage"):FindFirstChild("CatchBall")
            if event and event:IsA("RemoteEvent") then
                event:FireServer(ball)
                Core.SetLastCatch(os.clock())
            end
        end
    end
})

--==================================================
-- ABA REACH
--==================================================
local ReachTab = Window:CreateTab({name = "REACH", icon = "bolt"})
ReachTab:CreateSection("Configuração do Alcance")
ReachTab:CreateToggle({
    name = "Ativar Reach",
    flag = "ReachToggle",
    callback = Core.SetReach
})
ReachTab:CreateSlider({
    name = "Alcance",
    range = {1, 50},
    increment = 1,
    suffix = " studs",
    currentValue = Core.GetReachRange(),
    flag = "ReachRange",
    callback = Core.SetReachRange
})
ReachTab:CreateButton({
    name = "Atualizar Bola",
    callback = Core.UpdateReachBall
})
ReachTab:CreateButton({
    name = "Recarregar Personagem",
    callback = function()
        Core.SetupCharacter(Player.Character or Player.CharacterAdded:Wait())
        Core.UpdateReachBall()
    end
})

--==================================================
-- ABA CONTROL BALL
--==================================================
local ControlTab = Window:CreateTab({name = "Controlar Bola", icon = "move"})
ControlTab:CreateToggle({
    name = "Controle de Bola",
    flag = "ControlBallMain",
    callback = Core.SetControllBall
})
ControlTab:CreateKeybind({
    name = "Tecla Ativar",
    currentKeybind = "C",
    holdToInteract = false,
    flag = "ControlKey",
    callback = function() Core.SetControllBall(not Core.GetControllState()) end
})
ControlTab:CreateSlider({
    name = "Velocidade",
    range = {5, 100},
    increment = 1,
    suffix = " u/s",
    currentValue = 35,
    flag = "BallSpeed",
    callback = Core.SetControlSpeed
})
ControlTab:CreateSlider({
    name = "Distância Câmera",
    range = {2, 25},
    increment = 1,
    suffix = " studs",
    currentValue = 8,
    flag = "CamDistance",
    callback = Core.SetCameraDistance
})
ControlTab:CreateToggle({
    name = "Botão Mobile",
    flag = "MobileBtn",
    callback = Core.SetMobileButton
})
ControlTab:CreateButton({
    name = "Teleportar Para Bola",
    callback = function()
        local root = Core.GetRootPart()
        if not root then return end
        local ball = Core.GetNearestBall()
        if ball then root.CFrame = ball.CFrame + Vector3.new(0, 2.5, 0) end
    end
})

--==================================================
-- ABA EXTRAS E ESP
--==================================================
local ExtrasTab = Window:CreateTab({name = "Extras & ESP", icon = "eye"})
local ESPObjects = {}
local TextSizeESP = 14

local function LimparESP()
    for _, obj in pairs(ESPObjects) do
        if obj.Highlight then obj.Highlight:Destroy() end
        if obj.Gui then obj.Gui:Destroy() end
    end
    table.clear(ESPObjects)
end

local function CriarESP(bola)
    if not bola or ESPObjects[bola] then return end
    local High = Instance.new("Highlight")
    High.Adornee = bola
    High.FillColor = Color3.new(1, 0.3, 0.3)
    High.OutlineColor = Color3.new(1, 1, 1)
    High.FillTransparency = 0.4
    High.OutlineTransparency = 0
    High.Parent = bola

    local Billboard = Instance.new("BillboardGui")
    Billboard.Adornee = bola
    Billboard.Size = UDim2.fromOffset(120, 40)
    Billboard.StudsOffset = Vector3.new(0, 2, 0)
    Billboard.AlwaysOnTop = true

    local Texto = Instance.new("TextLabel")
    Texto.BackgroundTransparency = 1
    Texto.Size = UDim2.fromScale(1, 1)
    Texto.TextColor3 = Color3.new(1,1,1)
    Texto.TextStrokeTransparency = 0
    Texto.TextStrokeColor3 = Color3.new(0,0,0)
    Texto.Font = Enum.Font.GothamBold
    Texto.Parent = Billboard

    Billboard.Parent = bola
    ESPObjects[bola] = {Highlight = High, Gui = Billboard, Label = Texto}
end

ExtrasTab:CreateToggle({
    name = "ESP na Bola",
    flag = "BallESP",
    callback = function(v)
        Core.SetBallESP(v)
        if not v then LimparESP() end
    end
})
ExtrasTab:CreateSlider({
    name = "Tamanho Texto",
    range = {8, 28},
    increment = 1,
    currentValue = TextSizeESP,
    flag = "ESPTextSz",
    callback = function(v)
        TextSizeESP = v
        for _,d in pairs(ESPObjects) do
            if d.Label then d.Label.TextSize = v end
        end
    end
})

task.spawn(function()
    while task.wait(0.2) do
        if Core.GetBallESP() then
            local todasBolas = Core.GetBalls()
            local existentes = {}
            local root = Core.GetRootPart()
            for _,b in pairs(todasBolas) do
                existentes[b] = true
                CriarESP(b)
                if ESPObjects[b] and root then
                    local dist = math.floor((root.Position - b.Position).Magnitude)
                    ESPObjects[b].Label.Text = "BOLA\n"..dist.."m"
                    ESPObjects[b].Label.TextSize = TextSizeESP
                end
            end
            for bola in pairs(ESPObjects) do
                if not existentes[bola] or not bola.Parent then
                    if ESPObjects[bola].Highlight then ESPObjects[bola].Highlight:Destroy() end
                    if ESPObjects[bola].Gui then ESPObjects[bola].Gui:Destroy() end
                    ESPObjects[bola] = nil
                end
            end
        end
    end
end)

--==================================================
-- NOTIFICAÇÃO FINAL
--==================================================
Rayfield:Notify({
    Title = "CallingY Hub",
    Content = "✅ Interface carregada!",
    Duration = 2
})

print("✅ Todas partes carregadas!")