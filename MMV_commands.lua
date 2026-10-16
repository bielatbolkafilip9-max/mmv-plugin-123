local shared = odh_shared_plugins

local mmv_tab = shared.CreateTab("MMV Auto Commands", "/axioriasolver/testplugin/refs/heads/main/icon")
local mmv_section = mmv_tab:AddSection("Auto Command Sender", "Loop /map, /sheriff, /murderer")

-- Helper function to send chat messages
local function sendChatCommand(cmd)
    pcall(function()
        local textChatService = game:GetService("TextChatService")
        if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local channel = textChatService.TextChannels:FindFirstChild("RBXGeneral")
            if channel then
                channel:SendAsync(cmd)
            end
        else
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local sayMessageRequest = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") 
                and replicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
            if sayMessageRequest then
                sayMessageRequest:FireServer(cmd, "All")
            end
        end
    end)
end

----------------------------------------------------
-- 1. AUTO MAP (/map <MapName>)
----------------------------------------------------
local mapName = ""
local autoMapEnabled = false

mmv_section:AddTextBox("Map Name", function(text)
    mapName = text
end)

mmv_section:AddToggle("Auto Send /map", function(state)
    autoMapEnabled = state
    if state then
        task.spawn(function()
            while autoMapEnabled do
                if mapName ~= "" then
                    sendChatCommand("/map " .. mapName)
                end
                task.wait(1.5) -- delay between messages
            end
        end)
    end
end)

----------------------------------------------------
-- 2. AUTO SHERIFF (/sheriff <Username>)
----------------------------------------------------
local sheriffName = ""
local autoSheriffEnabled = false

mmv_section:AddTextBox("Sheriff Username", function(text)
    sheriffName = text
end)

mmv_section:AddPlayerDropdown("Select Sheriff from List", function(player)
    sheriffName = player.Name
end)

mmv_section:AddToggle("Auto Send /sheriff", function(state)
    autoSheriffEnabled = state
    if state then
        task.spawn(function()
            while autoSheriffEnabled do
                if sheriffName ~= "" then
                    sendChatCommand("/sheriff " .. sheriffName)
                end
                task.wait(1.5) -- delay between messages
            end
        end)
    end
end)

----------------------------------------------------
-- 3. AUTO MURDERER (/murderer <Username>)
----------------------------------------------------
local murdererName = ""
local autoMurdererEnabled = false

mmv_section:AddTextBox("Murderer Username", function(text)
    murdererName = text
end)

mmv_section:AddPlayerDropdown("Select Murderer from List", function(player)
    murdererName = player.Name
end)

mmv_section:AddToggle("Auto Send /murderer", function(state)
    autoMurdererEnabled = state
    if state then
        task.spawn(function()
            while autoMurdererEnabled do
                if murdererName ~= "" then
                    sendChatCommand("/murderer " .. murdererName)
                end
                task.wait(1.5) -- delay between messages
            end
        end)
    end
end)
