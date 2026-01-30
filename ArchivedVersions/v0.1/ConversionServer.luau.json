local staticHeadTable = require(game.ReplicatedStorage.StaticHeadTable)
local replaceNonIdentifiedHeads = false --If true: Heads that cannot be found (Typically UGC Heads) will be replaced with the default smile as a failsafe.
local players = game:GetService("Players")

--For legacy versions that use a fake head, you need to put a fake head mesh inside of this script for it to work.

local function addHead(plr, char)
	if char.Head:FindFirstChildWhichIsA("FaceControls") then
		char.Head.FaceControls:Destroy()
	end

	for i, accessory:Accessory in ipairs(char:GetChildren()) do
		if accessory:IsA("Accessory") then
			if accessory.AccessoryType == Enum.AccessoryType.Eyebrow or accessory.AccessoryType == Enum.AccessoryType.Eyelash then
				accessory:Destroy()
			end
		end
	end
	
	if true then
		char.Head.Transparency = 1

		local c = script.FakeHead:Clone()
		c.CFrame = char.Head.CFrame
		c.Color = char.Head.Color

		local w = Instance.new("WeldConstraint")
		w.Part0 = char.Head
		w.Part1 = c
		w.Parent = char.Head

		c.Parent = char

		local d = Instance.new("Decal")
		if char:FindFirstChild("Torso") then --R6
			if staticHeadTable[char.Head.Mesh.MeshId] then
				d.Texture = staticHeadTable[char.Head.Mesh.MeshId]
			else
				if replaceNonIdentifiedHeads == true then
					d.Texture = "rbxasset://textures/face.png"
				end
			end
		else --R15/Failsafe
			if staticHeadTable[char.Head.MeshId] then
				d.Texture = staticHeadTable[char.Head.MeshId]
			else
				if replaceNonIdentifiedHeads == true then
					d.Texture = "rbxasset://textures/face.png"
				end
			end
		end
		d.Parent = c

		char.Head.Changed:Connect(function() --Update fake head
			c.Size = char.Head.Size
			c.Color = char.Head.Color
		end)
	end
end

players.PlayerAdded:Connect(function(plr)
	plr.CharacterAppearanceLoaded:Connect(function()
		local char = plr.Character
		
		if char:FindFirstChild("Torso") then
			if staticHeadTable[char.Head.Mesh.MeshId] or replaceNonIdentifiedHeads == true then --R6
				addHead(plr, char)
			end
		else
			if staticHeadTable[char.Head.MeshId] or replaceNonIdentifiedHeads == true then --R15/Failsafe
				addHead(plr, char)
			end
		end
	end)
end)
