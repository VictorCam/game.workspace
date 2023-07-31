print("Hello world, from server!")



local sp1 = workspace:WaitForChild("sp1")
local sp2 = workspace:WaitForChild("sp2")
local LightingService = game:GetService("Lighting")

sp1.Neutral = true;
sp2.Neutral = false;

function TurnToNight()
	-- Set TimeOfDay to 24 (12 PM)
	LightingService.TimeOfDay = "24:00:00"

	-- Decrease brightness
	LightingService.Brightness = 0.5

	-- Adjust the color of ambient outside light
	LightingService.Ambient = Color3.fromRGB(0, 0, 10)
	LightingService.OutdoorAmbient = Color3.fromRGB(0, 0, 10)

	-- Add fog and adjust its color for a nighttime effect
	LightingService.FogStart = 50
	LightingService.FogEnd = 200
	LightingService.FogColor = Color3.fromRGB(0, 0, 15)
end





function countdown(seconds)
    while seconds > 0 do
        print(seconds .. " seconds remaining")
        task.wait(1)
        seconds = seconds - 1
    end
end

function movePlayer(player, location)
    player.Character.HumanoidRootPart.CFrame = location.CFrame
end

function trackSteps(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild('Humanoid')
        if humanoid then
            while true do
                if humanoid.MoveDirection.Magnitude > 0 then
                    print("Player is moving")
                    local position = character.PrimaryPart.Position
                    position = Vector3.new(position.X, position.Y - character.PrimaryPart.Size.Y/2, position.Z) -- Adjust the Y-coordinate
                    
                    -- Create a green square at the current position
                    local square = Instance.new("Part")
                    square.Size = Vector3.new(1, 0.1, 1)
                    square.Position = position
                    square.BrickColor = BrickColor.new("Bright green")
                    square.Material = "Neon"
                    square.Anchored = true
                    square.Parent = workspace
                    
                    game:GetService("Debris"):AddItem(square, 1)
                end
                wait(0.1)
            end
        else
            print("Humanoid not found")
        end
    end)
end




function giveGoggles(player)
    local Goggles = Instance.new("Tool")
    Goggles.Name = "Goggles"
    Goggles.Parent = player:WaitForChild("Backpack")

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Parent = Goggles

    trackSteps(player)
end



-- Connect the Equipped event to the tracking function
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        movePlayer(player, sp1)
        countdown(3)
        movePlayer(player, sp2)
        TurnToNight()
        giveGoggles(player)
    end)
end)



