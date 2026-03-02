-- ====================================================================
-- REMOTE FINDER + OUTPUT MUDAH DICOPY (Untuk HP)
-- ====================================================================

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Fungsi bikin teks yang gampang di-select
local function printEasyCopy(title, data)
    print("\n" .. string.rep("=", 50))
    print(title)
    print(string.rep("=", 50))
    
    local result = {}
    
    for i, name in ipairs(data) do
        print(i .. ". " .. name)
        table.insert(result, name)
    end
    
    print("\n📋 *** MUDAH DICOPY ***")
    print(table.concat(result, "\n"))
    print(string.rep("=", 50) .. "\n")
end

-- Cari remotes
local remoteFunctions = {}
local remoteEvents = {}

for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteFunction") then
        table.insert(remoteFunctions, obj.Name)
    elseif obj:IsA("RemoteEvent") then
        table.insert(remoteEvents, obj.Name)
    end
end

-- Tampilin dengan format HP-friendly
printEasyCopy("🔹 REMOTE FUNCTIONS", remoteFunctions)
printEasyCopy("🔸 REMOTE EVENTS", remoteEvents)

print("👉 CARA COPY: Tekan lama di layar, pilih SELECT ALL, lalu COPY")
