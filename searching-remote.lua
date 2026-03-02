-- ====================================================================
-- REMOTE FINDER DENGAN GUI SEDERHANA (UNTUK DELTA/HP)
-- ====================================================================

-- Tunggu game termuat
repeat task.wait() until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CoreGui = gethui and gethui() or game:GetService("CoreGui")

-- Hapus GUI lama jika ada
if CoreGui:FindFirstChild("RemoteFinderGUI") then
    CoreGui.RemoteFinderGUI:Destroy()
end

-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RemoteFinderGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true  -- Biar bisa digeser
MainFrame.Parent = ScreenGui

-- Judul
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "🔍 Remote Finder"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Tombol tutup
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = MainFrame
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Area daftar remote (ScrollingFrame)
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, -10, 1, -90)
ListFrame.Position = UDim2.new(0, 5, 0, 45)
ListFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ListFrame.BorderSizePixel = 0
ListFrame.ScrollBarThickness = 5
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Akan diatur ulang
ListFrame.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = ListFrame

-- Fungsi untuk menambahkan baris remote ke ListFrame
local yPos = 0
local function addRemoteLine(text, isFunction)
    local lineFrame = Instance.new("Frame")
    lineFrame.Size = UDim2.new(1, -10, 0, 25)
    lineFrame.Position = UDim2.new(0, 5, 0, yPos)
    lineFrame.BackgroundColor3 = isFunction and Color3.fromRGB(40, 40, 60) or Color3.fromRGB(40, 50, 40)
    lineFrame.BorderSizePixel = 0
    lineFrame.Parent = ListFrame

    local lineLabel = Instance.new("TextLabel")
    lineLabel.Size = UDim2.new(1, -5, 1, 0)
    lineLabel.Position = UDim2.new(0, 5, 0, 0)
    lineLabel.BackgroundTransparency = 1
    lineLabel.Text = text
    lineLabel.TextColor3 = isFunction and Color3.fromRGB(200, 200, 255) or Color3.fromRGB(200, 255, 200)
    lineLabel.Font = Enum.Font.Code -- Pakai font monospace biar rapi
    lineLabel.TextSize = 12
    lineLabel.TextXAlignment = Enum.TextXAlignment.Left
    lineLabel.Parent = lineFrame

    yPos = yPos + 25
end

-- Mulai cari remote
addRemoteLine("🔍 Mencari remote...", false)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 5)
task.wait(0.1) -- Biar GUI sempat update

-- Kosongkan list dan mulai pencarian
ListFrame:ClearAllChildren()
yPos = 0
addRemoteLine("📡 Memindai ReplicatedStorage...", false)

-- Cari RemoteFunctions dan RemoteEvents
local functionCount = 0
local eventCount = 0

for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteFunction") then
        functionCount = functionCount + 1
        addRemoteLine("🔹 [F] " .. obj.Name, true)
    elseif obj:IsA("RemoteEvent") then
        eventCount = eventCount + 1
        addRemoteLine("🔸 [E] " .. obj.Name, false)
    end
    task.wait() -- Biar gak nge-lag
end

-- Tambah info jumlah
if functionCount == 0 and eventCount == 0 then
    addRemoteLine("⚠️ Tidak ada remote ditemukan.", false)
    addRemoteLine("   Mungkin game berbeda atau", false)
    addRemoteLine("   remote ada di tempat lain.", false)
else
    addRemoteLine("", false) -- Spacer
    addRemoteLine("✅ Ditemukan " .. functionCount .. " RemoteFunction & " .. eventCount .. " RemoteEvent", false)
end

-- Set ukuran canvas
ListFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)

print("✅ GUI Remote Finder siap! Total remote: Func=" .. functionCount .. ", Event=" .. eventCount)
