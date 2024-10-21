
local library = {}

for i, v in pairs(game.CoreGui:GetDescendants()) do
	if v.Name == "shadow3" then
		v.Parent.Parent:Destroy()
	end
end

local function MakeDraggable(topbarobject, object) 
	pcall(function()
		local UserInputService = game:GetService("UserInputService")
		local dragging, dragInput, mousePos, framePos = false, false, false, false
		topbarobject.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				mousePos = input.Position
				framePos = object.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
		topbarobject.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput = input
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				local delta = input.Position - mousePos
				object.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
			end
		end)
	end)
end

local function GetXY(obj)
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local Max, May = obj.AbsoluteSize.X,obj.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - obj.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - obj.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

function Ripple(obj)
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local TweenService = game:GetService("TweenService")
	spawn(function()
		local PX, PY = GetXY(obj)
		local Circle = Instance.new("ImageLabel")
		Circle.Name = "Circle"
		Circle.Parent = obj
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1.000
		Circle.ZIndex = 10
		Circle.Image = "rbxassetid://266543268"
		Circle.ImageColor3 = Color3.fromRGB(210,210,210)
		Circle.ImageTransparency = 0.6
		local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, NewX, 0, NewY)
		local Size = obj.AbsoluteSize.X
		TweenService:Create(Circle, TweenInfo.new(1), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, Size = UDim2.fromOffset(Size,Size)}):Play()
		spawn(function()
			wait(1.2)
			Circle:Destroy()
		end)
	end)
end

function library:Window()
	local shuilibrary = Instance.new("ScreenGui")
	local main = Instance.new("Frame")
	local topbar = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local finish = Instance.new("Frame")
	local cover = Instance.new("Frame")
	local clear = Instance.new("ImageButton")
	local tit = Instance.new("TextLabel")
	local UICorner_2 = Instance.new("UICorner")
	local tabs = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local finish_2 = Instance.new("Frame")
	local finish2 = Instance.new("Frame")
	local maintabs = Instance.new("ScrollingFrame")
	local tabs_2 = Instance.new("Folder")
	local UIListLayout = Instance.new("UIListLayout")
	local shadow1 = Instance.new("ImageLabel")
	local shadow2 = Instance.new("ImageLabel")
	local shadow3 = Instance.new("ImageLabel")
	local frames = Instance.new("Folder")
	local windowHandler = {}

	maintabs.CanvasSize = UDim2.new(0, 0, 10, 0)

	MakeDraggable(topbar, main)

	shuilibrary.Name = tostring(math.random())
	shuilibrary.Parent = game.CoreGui

	main.Name = "main"
	main.Parent = shuilibrary
	main.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	main.BorderSizePixel = 0
	main.Position = UDim2.new(0.379820347, 0, 0.321510285, 0)
	main.Size = UDim2.new(0, 455, 0, 312)

	topbar.Name = "topbar"
	topbar.Parent = main
	topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	topbar.BorderSizePixel = 0
	topbar.Position = UDim2.new(0.00179215311, 0, 0, 0)
	topbar.Size = UDim2.new(0, 454, 0, 36)
	topbar.ZIndex = 2

	UICorner.Parent = topbar

	finish.Name = "finish"
	finish.Parent = topbar
	finish.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	finish.BorderSizePixel = 0
	finish.Position = UDim2.new(0, 0, 0.79411763, 0)
	finish.Size = UDim2.new(0, 454, 0, 7)

	cover.Name = "cover"
	cover.Parent = topbar
	cover.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	cover.BorderSizePixel = 0
	cover.Position = UDim2.new(0, 0, 1, 0)
	cover.Size = UDim2.new(1.0004065, 0, 0, 1)
	cover.ZIndex = 3

	clear.Name = "clear"
	clear.Parent = topbar
	clear.BackgroundTransparency = 1.000
	clear.LayoutOrder = 3
	clear.Position = UDim2.new(0.940999985, 0, 0.205882356, 0)
	clear.Size = UDim2.new(0, 21, 0, 21)
	clear.ZIndex = 2
	clear.Image = "rbxassetid://3926305904"
	clear.ImageRectOffset = Vector2.new(924, 724)
	clear.ImageRectSize = Vector2.new(36, 36)

	clear.Activated:Connect(function()
		shuilibrary:Destroy()
	end)

	tit.Name = "tit"
	tit.Parent = topbar
	tit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tit.BackgroundTransparency = 1.000
	tit.BorderColor3 = Color3.fromRGB(27, 42, 53)
	tit.Position = UDim2.new(0.0306002107, 0, 0.205882356, 0)
	tit.Size = UDim2.new(0, 110, 0, 21)
	tit.ZIndex = 3
	tit.Font = Enum.Font.Gotham
	tit.Text = "Something Hub"
	tit.TextColor3 = Color3.fromRGB(236, 236, 236)
	tit.TextSize = 16.000

	UICorner_2.Parent = main

	tabs.Name = "tabs"
	tabs.Parent = main
	tabs.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	tabs.BorderSizePixel = 0
	tabs.Position = UDim2.new(0.00217727828, 0, 0.118589744, 0)
	tabs.Size = UDim2.new(0, 109, 0, 274)
	tabs.ZIndex = 2

	UICorner_3.Parent = tabs

	finish_2.Name = "finish"
	finish_2.Parent = tabs
	finish_2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	finish_2.BorderSizePixel = 0
	finish_2.Position = UDim2.new(-0.0109185735, 0, -0.0223880596, 0)
	finish_2.Size = UDim2.new(0, 110, 0, 11)

	finish2.Name = "finish2"
	finish2.Parent = tabs
	finish2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	finish2.BorderSizePixel = 0
	finish2.Position = UDim2.new(0.863059521, 0, 0.970650494, 0)
	finish2.Size = UDim2.new(0, 15, 0, 5)

	maintabs.Name = "maintabs"
	maintabs.Parent = tabs
	maintabs.Active = true
	maintabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	maintabs.BackgroundTransparency = 1.000
	maintabs.Position = UDim2.new(0, 0, 0.0401459858, 0)
	maintabs.Size = UDim2.new(0, 109, 0, 259)
	maintabs.ZIndex = 5
	maintabs.ScrollBarThickness = 0

	tabs_2.Name = "tabs"
	tabs_2.Parent = maintabs

	UIListLayout.Parent = tabs_2
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)

	shadow1.Name = "shadow1"
	shadow1.Parent = main
	shadow1.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow1.BackgroundTransparency = 1.000
	shadow1.Position = UDim2.new(0.5, 0, 0.5, 3)
	shadow1.Size = UDim2.new(1, 5, 1, 5)
	shadow1.ZIndex = 0
	shadow1.Image = "rbxassetid://1316045217"
	shadow1.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow1.ImageTransparency = 0.800
	shadow1.ScaleType = Enum.ScaleType.Slice
	shadow1.SliceCenter = Rect.new(10, 10, 118, 118)

	shadow2.Name = "shadow2"
	shadow2.Parent = main
	shadow2.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow2.BackgroundTransparency = 1.000
	shadow2.Position = UDim2.new(0.5, 0, 0.5, 1)
	shadow2.Size = UDim2.new(1, 18, 1, 18)
	shadow2.ZIndex = 0
	shadow2.Image = "rbxassetid://1316045217"
	shadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow2.ImageTransparency = 0.880
	shadow2.ScaleType = Enum.ScaleType.Slice
	shadow2.SliceCenter = Rect.new(10, 10, 118, 118)

	shadow3.Name = "shadow3"
	shadow3.Parent = main
	shadow3.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow3.BackgroundTransparency = 1.000
	shadow3.Position = UDim2.new(0.5, 0, 0.5, 6)
	shadow3.Size = UDim2.new(1, 10, 1, 10)
	shadow3.ZIndex = 0
	shadow3.Image = "rbxassetid://1316045217"
	shadow3.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow3.ImageTransparency = 0.860
	shadow3.ScaleType = Enum.ScaleType.Slice
	shadow3.SliceCenter = Rect.new(10, 10, 118, 118)

	frames.Name = "frames"
	frames.Parent = main

	local function selectFirstTab()
		local firstthing = frames:GetChildren()[1]
		local firstname = firstthing.Name:gsub("_Frame", "")
		local buttontoselect = tabs_2:WaitForChild(firstname .. "_Button")
		local frametoselect = frames:WaitForChild(firstname .. "_Frame")
		for i, v in pairs(tabs_2:GetChildren()) do
			if v:IsA("TextButton") then
				if v.BackgroundColor3 == Color3.fromRGB(45, 45, 45) then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}):Play()
				end
			end
		end
		for a, b in pairs(frames:GetChildren()) do
			if b:IsA("ScrollingFrame") then
				b.Visible = false
			end
		end
		frametoselect.Visible = true
		game:GetService("TweenService"):Create(buttontoselect, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
	end

	function windowHandler:Tab(name)
		local ScrollingFrame = Instance.new("ScrollingFrame")
		local elements = Instance.new("Folder")
		local UIListLayout2 = Instance.new("UIListLayout")
		local TextButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
		local tabHandler = {}

		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0)

		ScrollingFrame.Parent = frames
		ScrollingFrame.Active = true
		ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScrollingFrame.BackgroundTransparency = 1.000
		ScrollingFrame.Position = UDim2.new(0.241899222, 0, 0.159825832, 0)
		ScrollingFrame.Size = UDim2.new(0, 338, 0, 258)
		ScrollingFrame.ZIndex = 7
		ScrollingFrame.ScrollBarThickness = 0
		ScrollingFrame.Visible = false
		ScrollingFrame.Name = name .. "_Frame"

		elements.Name = "elements"
		elements.Parent = ScrollingFrame

		UIListLayout2.Parent = elements
		UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout2.Padding = UDim.new(0, 4)

		TextButton.Parent = tabs_2
		TextButton.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
		TextButton.Position = UDim2.new(-0.417431206, 0, 0, 0)
		TextButton.Size = UDim2.new(0, 89, 0, 27)
		TextButton.ZIndex = 7
		TextButton.AutoButtonColor = false
		TextButton.Font = Enum.Font.Gotham
		TextButton.Text = name
		TextButton.TextColor3 = Color3.fromRGB(236, 236, 236)
		TextButton.TextScaled = true
		TextButton.TextSize = 14.000
		TextButton.TextWrapped = true
		TextButton.Name = name .. "_Button"

		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = TextButton

		UITextSizeConstraint.Parent = TextButton
		UITextSizeConstraint.MaxTextSize = 14
		UITextSizeConstraint.MinTextSize = 14

		TextButton.MouseEnter:Connect(function()
			if not ScrollingFrame.Visible then
				game:GetService("TweenService"):Create(TextButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end)

		TextButton.MouseLeave:Connect(function()
			if not ScrollingFrame.Visible then
				game:GetService("TweenService"):Create(TextButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}):Play()
			end
		end)

		TextButton.Activated:Connect(function()
			for i, v in pairs(tabs_2:GetChildren()) do
				if v:IsA("TextButton") then
					if v.BackgroundColor3 == Color3.fromRGB(45, 45, 45) and v ~= TextButton then
						game:GetService("TweenService"):Create(v, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}):Play()
					end
				end
			end
			for a, b in pairs(frames:GetChildren()) do
				if b:IsA("ScrollingFrame") then
					if b ~= ScrollingFrame then
						b.Visible = false
					end
				end
			end
			ScrollingFrame.Visible = true
			game:GetService("TweenService"):Create(TextButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
		end)

		function tabHandler:Button(text, callback)
			local TextButton = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

			TextButton.Parent = elements
			TextButton.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			TextButton.Position = UDim2.new(-0.133136094, 0, 0, 0)
			TextButton.Size = UDim2.new(0, 314, 0, 40)
			TextButton.AutoButtonColor = false
			TextButton.Font = Enum.Font.Gotham
			TextButton.TextColor3 = Color3.fromRGB(236, 236, 236)
			TextButton.TextScaled = true
			TextButton.TextSize = 14.000
			TextButton.TextWrapped = true
			TextButton.Text = tostring(text)
			TextButton.ClipsDescendants = true

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = TextButton

			UITextSizeConstraint.Parent = TextButton
			UITextSizeConstraint.MaxTextSize = 14
			UITextSizeConstraint.MinTextSize = 14

			TextButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(TextButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
			end)
	
			TextButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(TextButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}):Play()
			end)

			TextButton.Activated:Connect(function()
				Ripple(TextButton)
				callback()
			end)
		end

		function tabHandler:Bind(text, preset, callback)
			local binding = false
			local Key = preset.Name
			local KeyBind = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
			local CurrentKey = Instance.new("TextLabel")
			local UICorner_2 = Instance.new("UICorner")
			local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")

			KeyBind.Name = "KeyBind"
			KeyBind.Parent = elements
			KeyBind.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			KeyBind.Position = UDim2.new(-0.133136094, 0, 0, 0)
			KeyBind.Size = UDim2.new(0, 314, 0, 40)
			KeyBind.AutoButtonColor = false
			KeyBind.Font = Enum.Font.Gotham
			KeyBind.Text = ""
			KeyBind.TextColor3 = Color3.fromRGB(236, 236, 236)
			KeyBind.TextScaled = true
			KeyBind.TextSize = 14.000
			KeyBind.TextWrapped = true
			KeyBind.ClipsDescendants = true

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = KeyBind

			Title.Name = "Title"
			Title.Parent = KeyBind
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0382165611, 0, 0.075000003, 0)
			Title.Size = UDim2.new(0, 166, 0, 33)
			Title.Font = Enum.Font.Gotham
			Title.Text = tostring(text)
			Title.TextColor3 = Color3.fromRGB(236, 236, 236)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UITextSizeConstraint.Parent = Title
			UITextSizeConstraint.MaxTextSize = 14
			UITextSizeConstraint.MinTextSize = 14

			CurrentKey.Name = "CurrentKey"
			CurrentKey.Parent = KeyBind
			CurrentKey.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			CurrentKey.Position = UDim2.new(0.827499986, 0, 0.125, 0)
			CurrentKey.Size = UDim2.new(0, 48, 0, 30)
			CurrentKey.Font = Enum.Font.Gotham
			CurrentKey.Text = Key or ". . ."
			CurrentKey.TextColor3 = Color3.fromRGB(236, 236, 236)
			CurrentKey.TextScaled = true
			CurrentKey.TextSize = 14.000
			CurrentKey.TextWrapped = true
			CurrentKey.ZIndex = 9

			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = CurrentKey

			UITextSizeConstraint_2.Parent = CurrentKey
			UITextSizeConstraint_2.MaxTextSize = 14
			UITextSizeConstraint_2.MinTextSize = 14

			KeyBind.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(KeyBind, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
			end)
	
			KeyBind.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(KeyBind, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}):Play()
			end)

			KeyBind.Activated:Connect(function()
				Ripple(KeyBind)
				CurrentKey.Text = ". . ."
				binding = true
				local a, b = game:GetService('UserInputService').InputBegan:Wait()
				if a.KeyCode.Name ~= "Unknown" then
                    CurrentKey.Text = a.KeyCode.Name
                    Key = a.KeyCode.Name
					wait(0.1)
					binding = false
                end
			end)

			game:GetService("UserInputService").InputBegan:Connect(function(current, ok) 
                if not ok and not binding then 
                    if current.KeyCode.Name == Key then 
                        callback(Key)
                    end
                end
            end)
		end

		function tabHandler:Toggle(text, default, callback)
			callback = callback or function() end
			local istoggled = default
			local Toggle = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
			local enabled = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local check = Instance.new("ImageButton")

			Toggle.Name = "Toggle"
			Toggle.Parent = elements
			Toggle.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			Toggle.Position = UDim2.new(-0.133136094, 0, 0, 0)
			Toggle.Size = UDim2.new(0, 314, 0, 40)
			Toggle.AutoButtonColor = false
			Toggle.Font = Enum.Font.Gotham
			Toggle.Text = ""
			Toggle.TextColor3 = Color3.fromRGB(236, 236, 236)
			Toggle.TextScaled = true
			Toggle.TextSize = 14.000
			Toggle.TextWrapped = true
			Toggle.ClipsDescendants = true

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Toggle

			Title.Name = "Title"
			Title.Parent = Toggle
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0382165611, 0, 0.075000003, 0)
			Title.Size = UDim2.new(0, 166, 0, 33)
			Title.Font = Enum.Font.Gotham
			Title.Text = tostring(text)
			Title.TextColor3 = Color3.fromRGB(236, 236, 236)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UITextSizeConstraint.Parent = Title
			UITextSizeConstraint.MaxTextSize = 14
			UITextSizeConstraint.MinTextSize = 14

			enabled.Name = "enabled"
			enabled.Parent = Toggle
			enabled.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
			enabled.Position = UDim2.new(0.883000016, 0, 0.200000003, 0)
			enabled.Size = UDim2.new(0, 29, 0, 26)
			if not istoggled then
				enabled.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			else
				enabled.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
			end

			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = enabled

			check.Name = "check"
			check.Parent = enabled
			check.AnchorPoint = Vector2.new(0.5, 0.5)
			check.BackgroundTransparency = 1.000
			check.Position = UDim2.new(0.5, 0, 0.5, 0)
			check.Size = UDim2.new(0, 23, 0, 23)
			check.ZIndex = 2
			check.Image = "rbxassetid://3926305904"
			check.ImageColor3 = Color3.fromRGB(35, 35, 35)
			check.ImageRectOffset = Vector2.new(312, 4)
			check.ImageRectSize = Vector2.new(24, 24)
			if istoggled then
				check.ImageTransparency = 0
				check.Size = UDim2.new(0, 23, 0, 23)
			else
				check.ImageTransparency = 1
				check.Size = UDim2.new(0, 0, 0, 0)
			end

			Toggle.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
			end)
	
			Toggle.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}):Play()
			end)

			Toggle.Activated:Connect(function()
				istoggled = not istoggled
				callback(istoggled)
				pcall(Ripple, Toggle)
				if istoggled then
					spawn(function()
						game:GetService("TweenService"):Create(enabled, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 127)}):Play()
						game:GetService("TweenService"):Create(check, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
						game:GetService("TweenService"):Create(check, TweenInfo.new(0.5), {Size = UDim2.new(0, 23, 0, 23)}):Play()
					end)
				else
					spawn(function()
						game:GetService("TweenService"):Create(enabled, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
						game:GetService("TweenService"):Create(check, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0)}):Play()
					end)
				end
			end)
		end

		function tabHandler:Dropdown(text, list, callback)
			local droptog = false
            local framesize = 0
            local itemcount = 0
			local Dropdown = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
			local arrow = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local chevron_right = Instance.new("ImageButton")
			local itemholder = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			itemholder.CanvasSize = UDim2.new(0, 0, 10, 0)

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = elements
			Dropdown.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			Dropdown.Position = UDim2.new(-0.133136094, 0, 0, 0)
			Dropdown.Size = UDim2.new(0, 314, 0, 40)
			Dropdown.AutoButtonColor = false
			Dropdown.Font = Enum.Font.Gotham
			Dropdown.Text = ""
			Dropdown.TextColor3 = Color3.fromRGB(236, 236, 236)
			Dropdown.TextScaled = true
			Dropdown.TextSize = 14.000
			Dropdown.TextWrapped = true
			Dropdown.AutoButtonColor = false
			Dropdown.ClipsDescendants = true

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Dropdown

			Title.Name = "Title"
			Title.Parent = Dropdown
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0382165611, 0, 0.075000003, 0)
			Title.Size = UDim2.new(0, 166, 0, 33)
			Title.Font = Enum.Font.Gotham
			Title.Text = tostring(text)
			Title.TextColor3 = Color3.fromRGB(236, 236, 236)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UITextSizeConstraint.Parent = Title
			UITextSizeConstraint.MaxTextSize = 14
			UITextSizeConstraint.MinTextSize = 14

			arrow.Name = "arrow"
			arrow.Parent = Dropdown
			arrow.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			arrow.Position = UDim2.new(0.883000016, 0, 0.200000003, 0)
			arrow.Size = UDim2.new(0, 29, 0, 26)

			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = arrow

			chevron_right.Name = "chevron_right"
			chevron_right.Parent = arrow
			chevron_right.AnchorPoint = Vector2.new(0.5, 0.5)
			chevron_right.BackgroundTransparency = 1.000
			chevron_right.Position = UDim2.new(0.5, 0, 0.5, 0)
			chevron_right.Rotation = -90.000
			chevron_right.Size = UDim2.new(0, 27, 0, 27)
			chevron_right.ZIndex = 2
			chevron_right.Image = "rbxassetid://3926305904"
			chevron_right.ImageColor3 = Color3.fromRGB(236, 236, 236)
			chevron_right.ImageRectOffset = Vector2.new(924, 884)
			chevron_right.ImageRectSize = Vector2.new(36, 36)

			itemholder.Name = "itemholder"
			itemholder.Parent = elements
			itemholder.Active = true
			itemholder.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			itemholder.BorderSizePixel = 0
			itemholder.Position = UDim2.new(0, 0, 1.10000002, 0)
			itemholder.Size = UDim2.new(0, 312, 0, 0)
			itemholder.ScrollBarThickness = 0
			itemholder.Visible = false

			UIListLayout.Parent = itemholder
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 4)
			
			Dropdown.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(Dropdown, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
			end)
	
			Dropdown.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(Dropdown, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}):Play()
			end)
			for i, v in next, list do
				itemcount += 1
				if itemcount <= 3 then
					framesize += 33
				end

				local Item = Instance.new("TextButton")
				local UITextSizeConstraintd = Instance.new("UITextSizeConstraint")
				local UICorners = Instance.new("UICorner")

				Item.Name = "Item"
				Item.Parent = itemholder
				Item.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
				Item.Position = UDim2.new(0.0192307699, 0, 0, 0)
				Item.Size = UDim2.new(0, 292, 0, 33)
				Item.Font = Enum.Font.Gotham
				Item.Text = v
				Item.TextColor3 = Color3.fromRGB(236, 236, 236)
				Item.TextScaled = true
				Item.TextSize = 14.000
				Item.TextWrapped = true
				Item.AutoButtonColor = false

				UITextSizeConstraintd.Parent = Item
				UITextSizeConstraintd.MaxTextSize = 14
				UITextSizeConstraintd.MinTextSize = 14

				UICorners.CornerRadius = UDim.new(0, 5)
				UICorners.Parent = Item

				Item.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(Item, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
				end)
		
				Item.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(Item, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}):Play()
				end)

				Item.Activated:Connect(function()
					droptog = not droptog
					Title.Text = text .. " - " .. v
					pcall(callback, v)
					ScrollingFrame.ScrollingEnabled = true
					game:GetService("TweenService"):Create(chevron_right, TweenInfo.new(0.2), {Rotation = -90}):Play()
					game:GetService("TweenService"):Create(itemholder, TweenInfo.new(0.3), {Size = UDim2.new(0, 312, 0, 0)}):Play()
					if droptog == true then
						itemholder.Visible = true
					else
						wait(0.3)
						itemholder.Visible = false
					end
				end)
			end

			Dropdown.Activated:Connect(function()
				Ripple(Dropdown)
				if droptog == false then
					ScrollingFrame.ScrollingEnabled = false
					game:GetService("TweenService"):Create(chevron_right, TweenInfo.new(0.2), {Rotation = 90}):Play()
					game:GetService("TweenService"):Create(itemholder, TweenInfo.new(0.3), {Size = UDim2.new(0, 312, 0, framesize)}):Play()
				else
					ScrollingFrame.ScrollingEnabled = true
					game:GetService("TweenService"):Create(chevron_right, TweenInfo.new(0.2), {Rotation = -90}):Play()
					game:GetService("TweenService"):Create(itemholder, TweenInfo.new(0.3), {Size = UDim2.new(0, 312, 0, 0)}):Play()
				end
				droptog = not droptog
				if droptog == true then
					itemholder.Visible = true
				else
					wait(0.3)
					itemholder.Visible = false
				end
			end)

		end

		function tabHandler:Slider(text, min, max, inc, callback)
			local dragging = false
			local Slider = Instance.new("Frame")
			local Title345 = Instance.new("TextLabel")
			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
			local CurrentValue = Instance.new("TextLabel")
			local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
			local Bar = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Slide = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UICorner_3 = Instance.new("UICorner")

			Slider.Name = "Slider"
			Slider.Parent = elements
			Slider.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			Slider.Size = UDim2.new(0, 314, 0, 40)

			Title345.Name = "Title"
			Title345.Parent = Slider
			Title345.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title345.BackgroundTransparency = 1.000
			Title345.Position = UDim2.new(0.0382165611, 0, 0.125, 0)
			Title345.Size = UDim2.new(0, 109, 0, 20)
			Title345.Font = Enum.Font.SourceSans
			Title345.Text = tostring(text)
			Title345.TextColor3 = Color3.fromRGB(236, 236, 236)
			Title345.TextScaled = true
			Title345.TextSize = 14.000
			Title345.TextWrapped = true
			Title345.TextXAlignment = Enum.TextXAlignment.Left

			UITextSizeConstraint.Parent = Title345
			UITextSizeConstraint.MaxTextSize = 16
			UITextSizeConstraint.MinTextSize = 16

			CurrentValue.Name = "CurrentValue"
			CurrentValue.Parent = Slider
			CurrentValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CurrentValue.BackgroundTransparency = 1.000
			CurrentValue.Position = UDim2.new(0.837579787, 0, 0.125, 0)
			CurrentValue.Size = UDim2.new(0, 41, 0, 20)
			CurrentValue.Font = Enum.Font.SourceSans
			CurrentValue.Text = "0"
			CurrentValue.TextColor3 = Color3.fromRGB(236, 236, 236)
			CurrentValue.TextScaled = true
			CurrentValue.TextSize = 14.000
			CurrentValue.TextWrapped = true
			CurrentValue.TextXAlignment = Enum.TextXAlignment.Right

			UITextSizeConstraint_2.Parent = CurrentValue
			UITextSizeConstraint_2.MaxTextSize = 16
			UITextSizeConstraint_2.MinTextSize = 16

			Bar.Name = "Bar"
			Bar.Parent = Slider
			Bar.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
			Bar.Position = UDim2.new(0.0307127349, 0, 0.675000012, 0)
			Bar.Size = UDim2.new(0, 296, 0, 6)

			UICorner.CornerRadius = UDim.new(1, 0)
			UICorner.Parent = Bar

			Slide.Name = "Slide"
			Slide.Parent = Bar
			Slide.BackgroundColor3 = Color3.fromRGB(236, 236, 236)
			Slide.Position = UDim2.new(0, 0, 0.17499797, 0)
			Slide.Size = UDim2.new(0, 0, 0, 4)

			UICorner_2.CornerRadius = UDim.new(1, 0)
			UICorner_2.Parent = Slide

			UICorner_3.CornerRadius = UDim.new(0, 5)
			UICorner_3.Parent = Slider

			local function move(Input)
				local XSize = math.clamp((Input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
				local Increment = inc and (max / ((max - min) / (inc * 4))) or (max >= 50 and max / ((max - min) / 4)) or  (max >= 25 and max / ((max - min) / 2)) or (max / (max - min))
				local SizeRounded = UDim2.new((math.round(XSize * ((max / Increment) * 4)) / ((max / Increment) * 4)), 0, 0.700, 0)
				Slide:TweenSize(SizeRounded, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .1, true)

				local Val = math.round((((SizeRounded.X.Scale * max) / max) * (max - min) + min) * 20) / 20
				CurrentValue.Text = tostring(Val)
				pcall(callback, tonumber(Val))
			end

			Bar.InputBegan:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
					end
				end
			)
			Bar.InputEnded:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end
			)
			game:GetService("UserInputService").InputChanged:Connect(
			function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					move(input)
				end
			end
			)
		end

		function tabHandler:Textbox(text, numonly, dissapear, callback)
			local Textbox = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
			local TheTextBox = Instance.new("TextBox")
			local UICorner_2 = Instance.new("UICorner")
			local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")

			Textbox.Name = "Textbox"
			Textbox.Parent = elements
			Textbox.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			Textbox.Position = UDim2.new(-0.133136094, 0, 0, 0)
			Textbox.Size = UDim2.new(0, 314, 0, 40)
			Textbox.AutoButtonColor = false
			Textbox.Font = Enum.Font.Gotham
			Textbox.Text = ""
			Textbox.TextColor3 = Color3.fromRGB(236, 236, 236)
			Textbox.TextScaled = true
			Textbox.TextSize = 14.000
			Textbox.TextWrapped = true
			Textbox.ClipsDescendants = true

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Textbox

			Title.Name = "Title"
			Title.Parent = Textbox
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0382165611, 0, 0.075000003, 0)
			Title.Size = UDim2.new(0, 166, 0, 33)
			Title.Font = Enum.Font.Gotham
			Title.Text = tostring(text)
			Title.TextColor3 = Color3.fromRGB(236, 236, 236)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UITextSizeConstraint.Parent = Title
			UITextSizeConstraint.MaxTextSize = 14
			UITextSizeConstraint.MinTextSize = 14

			TheTextBox.Name = "TheTextBox"
			TheTextBox.Parent = Textbox
			TheTextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			TheTextBox.Position = UDim2.new(0.709165514, 0, 0.125, 0)
			TheTextBox.Size = UDim2.new(0, 85, 0, 30)
			TheTextBox.Font = Enum.Font.Gotham
			TheTextBox.PlaceholderText = ". . ."
			TheTextBox.Text = ""
			TheTextBox.TextColor3 = Color3.fromRGB(236, 236, 236)
			TheTextBox.TextScaled = true
			TheTextBox.TextSize = 14.000
			TheTextBox.TextStrokeColor3 = Color3.fromRGB(236, 236, 236)
			TheTextBox.TextWrapped = true

			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = TheTextBox

			UITextSizeConstraint_2.Parent = TheTextBox
			UITextSizeConstraint_2.MaxTextSize = 14
			UITextSizeConstraint_2.MinTextSize = 14

			Textbox.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(Textbox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
			end)
	
			Textbox.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(Textbox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}):Play()
			end)

			Textbox.Activated:Connect(function()
				Ripple(Textbox)
				TheTextBox:CaptureFocus()
			end)

			TheTextBox.FocusLost:Connect(function(idk)
				if idk then
					if #TheTextBox.Text > 0 then
						pcall(callback, TheTextBox.Text)
						if dissapear then
							TheTextBox.Text = ""
						end
					end
				end
			end)

			TheTextBox:GetPropertyChangedSignal("Text"):Connect(function()
				if numonly then
					TheTextBox.Text = TheTextBox.Text:gsub("D%+", "")
				end
			end)
		end
		
		function tabHandler:Label(text)
			local Label = Instance.new("TextLabel")
			local UICorner = Instance.new("UICorner")
			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

			Label.Name = "Label"
			Label.Parent = elements
			Label.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			Label.Size = UDim2.new(0, 314, 0, 40)
			Label.Font = Enum.Font.Gotham
			Label.TextColor3 = Color3.fromRGB(236, 236, 236)
			Label.TextScaled = true
			Label.TextSize = 14.000
			Label.TextWrapped = true
			Label.Text = tostring(text)

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Label

			UITextSizeConstraint.Parent = Label
			UITextSizeConstraint.MaxTextSize = 14
			UITextSizeConstraint.MinTextSize = 14
		end

		return tabHandler
	end

	function windowHandler:Toggle()
		main.Visible = not main.Visible
	end

	function windowHandler:Load()
		selectFirstTab()
	end

	return windowHandler
end
return library
