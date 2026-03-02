-- ====================================================================
-- REMOTE FINDER DENGAN TEXT BOX BESAR (MUDAH DI-SELECT)
-- ====================================================================

repeat task.wait() until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = gethui and gethui() or game:GetService("CoreGui")

if CoreGui:FindFirstChild("RemoteFinderGUI") then
    CoreGui.RemoteFinderGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RemoteFinderGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 500)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Judul
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Text = "📋 REMOTE FINDER - SELECT & COPY"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

-- Tombol tutup
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainFrame
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ========== TEXT BOX BESAR BUAT COPY ==========
local ResultBox = Instance.new("TextBox")
ResultBox.Size = UDim2.new(0.9, 0, 0, 300)
ResultBox.Position = UDim2.new(0.05, 0, 0, 50)
ResultBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ResultBox.TextColor3 = Color3.fromRGB(100, 255, 100)
ResultBox.Font = Enum.Font.Code
ResultBox.TextSize = 14
ResultBox.TextXAlignment = Enum.TextXAlignment.Left
ResultBox.TextYAlignment = Enum.TextYAlignment.Top
ResultBox.MultiLine = true
ResultBox.ClearTextOnFocus = false
ResultBox.TextEditable = false  -- Biar ga bisa diedit, tapi BISA DI-SELECT
ResultBox.BorderSizePixel = 0
ResultBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = ResultBox

-- ========== TOMBOL SCAN ==========
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(0.44, 0, 0, 45)
ScanButton.Position = UDim2.new(0.05, 0, 0, 360)
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
ScanButton.Text = "🔍 SCAN REMOTE"
ScanButton.TextColor3 = Color3.new(1, 1, 1)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 14
ScanButton.BorderSizePixel = 0
ScanButton.Parent = MainFrame

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 6)
ScanCorner.Parent = ScanButton

-- ========== TOMBOL INSTRUKSI ==========
local InfoButton = Instance.new("TextButton")
InfoButton.Size = UDim2.new(0.44, 0, 0, 45)
InfoButton.Position = UDim2.new(0.51, 0, 0, 360)
InfoButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InfoButton.Text = "ℹ️ CARA COPY"
InfoButton.TextColor3 = Color3.new(1, 1, 1)
InfoButton.Font = Enum.Font.GothamBold
InfoButton.TextSize = 14
InfoButton.BorderSizePixel = 0
InfoButton.Parent = MainFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 6)
InfoCorner.Parent = InfoButton

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.9, 0, 0, 30)
StatusLabel.Position = UDim2.new(0.05, 0, 0, 415)
StatusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
StatusLabel.Text = "🟡 Klik SCAN untuk mulai"
StatusLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.BorderSizePixel = 0
StatusLabel.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 4)
StatusCorner.Parent = StatusLabel

-- Fungsi SCAN
ScanButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🟡 Scanning remote..."
    ResultBox.Text = "🔍 Mencari remote...\n"
    task.wait(0.1)
    
    local funcList = {}
    local eventList = {}
    
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteFunction") then
            table.insert(funcList, obj.Name)
        elseif obj:IsA("RemoteEvent") then
            table.insert(eventList, obj.Name)
        end
    end
    
    -- Urutin biar rapi
    table.sort(funcList)
    table.sort(eventList)
    
    -- Buat teks hasil
    local resultText = ""
    resultText = resultText .. "=" .. string.rep("=", 50) .. "\n"
    resultText = resultText .. "🔹 REMOTE FUNCTIONS (" .. #funcList .. ")\n"
    resultText = resultText .. "=" .. string.rep("=", 50) .. "\n"
    
    for i, name in ipairs(funcList) do
        resultText = resultText .. i .. ". " .. name .. "\n"
    end
    
    resultText = resultText .. "\n"
    resultText = resultText .. "=" .. string.rep("=", 50) .. "\n"
    resultText = resultText .. "🔸 REMOTE EVENTS (" .. #eventList .. ")\n"
    resultText = resultText .. "=" .. string.rep("=", 50) .. "\n"
    
    for i, name in ipairs(eventList) do
        resultText = resultText .. i .. ". " .. name .. "\n"
    end
    
    ResultBox.Text = resultText
    StatusLabel.Text = "✅ Selesai! " .. #funcList .. " Function, " .. #eventList .. " Event"
end)

-- Tombol instruksi
InfoButton.MouseButton1Click:Connect(function()
    ResultBox.Text = [[
📋 CARA COPY KE CLIPBOARD:

1. Tekan lama di dalam kotak teks ini
2. Pilih "SELECT ALL" (Pilih Semua)
3. Pilih "COPY" (Salin)
4. Buka Notes/WhatsApp
5. Paste (Tempel)

⚠️ CATATAN:
Karena keterbatasan executor HP,
tombol copy otomatis TIDAK BISA dibuat.
Ini adalah cara termudah yang tersedia.

🎯 Tips: Hasil scan sudah otomatis
muncul di kotak ini tinggal di-select.]]
    
    StatusLabel.Text = "ℹ️ Ikuti langkah di atas untuk copy"
end)

-- Auto scan pas pertama buka
task.spawn(function()
    task.wait(0.5)
    ScanButton.MouseButton1Click:Fire()
end)
