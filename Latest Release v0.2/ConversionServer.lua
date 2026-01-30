local staticHeadTable = require(game.ReplicatedStorage.StaticHeadTable)
local replaceNonIdentifiedHeads = true --If true: Heads that cannot be found (Typically UGC Heads) will be replaced with the default smile as a failsafe.
local players = game:GetService("Players")

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
		local m = Instance.new("SpecialMesh")
		m.MeshType = Enum.MeshType.Head
		m.Scale = Vector3.new(1.25, 1.25, 1.25)
		
		local d = Instance.new("Decal")
		if char:FindFirstChild("Torso") then --R6
			if staticHeadTable[char.Head.Mesh.MeshId] then
				local face = staticHeadTable[char.Head.Mesh.MeshId]
				
				d.Texture = staticHeadTable[char.Head.Mesh.MeshId]
				char.Head.Mesh:Destroy()
				m.Parent = char.Head
				
				if char.Head:FindFirstChild("face") then
					char.Head.face.Texture = face
					d:Destroy()
				else
					d.Texture = face
					d.Parent = char.Head
				end
			else
				if replaceNonIdentifiedHeads == true then
					char.Head.Mesh:Destroy()
					m.Parent = char.Head
					
					if char.Head:FindFirstChild("face") then
						char.Head.face.Texture = "rbxasset://textures/face.png"
						d:Destroy()
					else
						d.Texture = "rbxasset://textures/face.png"
						d.Parent = char.Head
					end
				end
			end
		else --R15/Failsafe
			if staticHeadTable[char.Head.MeshId] then
				local face = staticHeadTable[char.Head.MeshId]
				local fakeHead = Instance.new("Part")
				fakeHead.Color = char.Head.Color
				fakeHead.Size = Vector3.new(2, 1, 1)
				fakeHead.Parent = char
				m.Parent = fakeHead
				
				d.Texture = face
				d.Parent = fakeHead
				
				fakeHead.CFrame = char.Head.CFrame + Vector3.new(0, 0.1, 0) --Dynamic heads are slightly offset, so we use this to make up for it.
				
				local w = Instance.new("WeldConstraint")
				w.Part0 = char.Head
				w.Part1 = fakeHead
				w.Parent = char.Head
				
				char.Head.Transparency = 1
			else
				if replaceNonIdentifiedHeads == true then
					local face = "rbxasset://textures/face.png"
					local fakeHead = Instance.new("Part")
					fakeHead.Color = char.Head.Color
					fakeHead.Size = Vector3.new(2, 1, 1)
					fakeHead.Parent = char
					m.Parent = fakeHead

					d.Texture = face
					d.Parent = fakeHead

					fakeHead.CFrame = char.Head.CFrame + Vector3.new(0, 0.1, 0)

					local w = Instance.new("WeldConstraint")
					w.Part0 = char.Head
					w.Part1 = fakeHead
					w.Parent = char.Head

					char.Head.Transparency = 1
				end
			end
		end
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
