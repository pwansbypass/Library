local pwans = {
    Theme = "Dark"
}

pwans.theme = pwans.Theme

local Themes = {
    ["Dark"] = {
        Topbar = Color3.fromRGB(30, 30, 35),
        TabContainer = Color3.fromRGB(25, 25, 30),
        Lines = Color3.fromRGB(50, 50, 55),
        HoverTabFrame = Color3.fromRGB(53, 53, 57),
        ItemUIStroke = Color3.fromRGB(41, 41, 50),
        TabFrame = Color3.fromRGB(35, 35, 40),
        SectionFrame = Color3.fromRGB(30, 30, 35),
        TabText = Color3.fromRGB(237, 237, 237),
        ItemText = Color3.fromRGB(237, 237, 237),
        ItemUIStrokeSelected = Color3.fromRGB(80, 201, 206),
        DropdownIcon = Color3.fromRGB(175, 175, 175),
        SectionText = Color3.fromRGB(237, 237, 237),
        SelectedTabFrame = Color3.fromRGB(65, 65, 70),
        ItemFrame = Color3.fromRGB(35, 35, 40),
        HoverItemFrame = Color3.fromRGB(53, 53, 57),
        SectionUIStroke = Color3.fromRGB(37, 37, 44),
        MainUIStroke = Color3.fromRGB(54, 54, 63),
        Main = Color3.fromRGB(20, 20, 25),
        Shadow = Color3.fromRGB(20, 20, 25),
        TabUIStroke = Color3.fromRGB(39, 39, 47),
        SliderOuter = Color3.fromRGB(60, 60, 70),
        SliderInner = Color3.fromRGB(80, 201, 206),
        ToggleOuter = Color3.fromRGB(35, 35, 40),
        InputPlaceHolder = Color3.fromRGB(60, 60, 65),
        ToggleOuterEnabled = Color3.fromRGB(53, 53, 61),
        ToggleOuterUIStroke = Color3.fromRGB(54, 54, 62),
        ToggleOuterUIStrokeEnabled = Color3.fromRGB(67, 67, 77),
        ToggleInner = Color3.fromRGB(66, 66, 76),
        ToggleInnerEnabled = Color3.fromRGB(80, 201, 206),
        ContainerHolder = Color3.fromRGB(26, 26, 31),
        HighlightUIStroke = Color3.fromRGB(79, 79, 86),
        Highlight = Color3.fromRGB(80, 201, 206)
    },

}

local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local notifications = Instance.new("ScreenGui")
notifications.Name = HttpService:GenerateGUID(true)
notifications.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
notifications.Parent = CoreGui

local notificationHolder = Instance.new("Frame")
notificationHolder.Name = "NotificationHolder"
notificationHolder.AnchorPoint = Vector2.new(0, 0.5)
notificationHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notificationHolder.BackgroundTransparency = 1
notificationHolder.Position = UDim2.new(0, 0, 0.5, 0)
notificationHolder.Size = UDim2.new(1, 0, 1, 100)
notificationHolder.Parent = notifications

local uIListLayout = Instance.new("UIListLayout")
uIListLayout.Name = "UIListLayout"
uIListLayout.Padding = UDim.new(0, 3)
uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
uIListLayout.Parent = notificationHolder

local uIPadding = Instance.new("UIPadding")
uIPadding.Name = "UIPadding"
uIPadding.PaddingBottom = UDim.new(0, 55)
uIPadding.PaddingRight = UDim.new(0, 5)
uIPadding.Parent = notificationHolder

function pwans:Notification(Info)
Info.Title = Info.Title or "Notification"
Info.Description = Info.Description or "Placeholder"
Info.Timeout = Info.Timeout or nil
Info.Callback = Info.Callback or function() end

local Theme = Themes[pwans.Theme]

if Theme == nil then
    error("There's no theme called: "..pwans.Theme, 0)
end

local notificationMain = Instance.new("Frame")
notificationMain.Name = "NotificationMain"
notificationMain.BackgroundColor3 = Theme.Main
notificationMain.BackgroundTransparency = 0.04
notificationMain.BorderSizePixel = 0
notificationMain.ClipsDescendants = true
notificationMain.Position = UDim2.new(0.739, 0, 0.885, 0)
notificationMain.Size = UDim2.new(0, 0, 0, 95)
notificationMain.Parent = notificationHolder

local notificationMainUIStroke = Instance.new("UIStroke")
notificationMainUIStroke.Name = "NotificationMainUIStroke"
notificationMainUIStroke.Color = Theme.MainUIStroke
notificationMainUIStroke.Parent = notificationMain
notificationMainUIStroke.Enabled = false

local notificationMainUICorner = Instance.new("UICorner")
notificationMainUICorner.Name = "NotificationMainUICorner"
notificationMainUICorner.CornerRadius = UDim.new(0, 2)
notificationMainUICorner.Parent = notificationMain

local notificationName = Instance.new("TextLabel")
notificationName.Name = "NotificationName"
notificationName.Font = Enum.Font.GothamBold
notificationName.Text = Info.Title
notificationName.TextColor3 = Theme.SectionText
notificationName.TextSize = 14
notificationName.TextXAlignment = Enum.TextXAlignment.Left
notificationName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notificationName.BackgroundTransparency = 1
notificationName.Position = UDim2.new(0, 6, 0, 0)
notificationName.Size = UDim2.new(0, 330, 0, 34)
notificationName.ZIndex = 2
notificationName.Parent = notificationMain

local topbar = Instance.new("Frame")
topbar.Name = "Topbar"
topbar.BackgroundColor3 = Theme.Topbar
topbar.BorderSizePixel = 0
topbar.Size = UDim2.new(1, 0, 0, 34)
topbar.Parent = notificationMain

local topbarUICorner = Instance.new("UICorner")
topbarUICorner.Name = "TopbarUICorner"
topbarUICorner.CornerRadius = UDim.new(0, 2)
topbarUICorner.Parent = topbar

local notificationTopbarLine = Instance.new("Frame")
notificationTopbarLine.Name = "NotificationTopbarLine"
notificationTopbarLine.AnchorPoint = Vector2.new(0.5, 1)
notificationTopbarLine.BackgroundColor3 = Theme.Lines
notificationTopbarLine.BorderSizePixel = 0
notificationTopbarLine.Position = UDim2.new(0.5, 0, 1, 0)
notificationTopbarLine.Size = UDim2.new(1, 0, 0, 1)
notificationTopbarLine.Parent = topbar

local notificationCloseButton = Instance.new("ImageButton")
notificationCloseButton.Name = "NotificationCloseButton"
notificationCloseButton.Image = "rbxassetid://10738425363"
notificationCloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notificationCloseButton.ImageColor3 = Theme.SectionText
notificationCloseButton.BackgroundTransparency = 1
notificationCloseButton.Position = UDim2.new(0, 315, 0, 9)
notificationCloseButton.Size = UDim2.new(0, 17, 0, 17)
notificationCloseButton.Visible = false
notificationCloseButton.Parent = topbar

local notificationTime = Instance.new("TextLabel")
notificationTime.Name = "NotificationTime"
notificationTime.Font = Enum.Font.GothamBold
notificationTime.Text = "36"
notificationTime.TextColor3 = Theme.SectionText
notificationTime.TextSize = 14
notificationTime.TextXAlignment = Enum.TextXAlignment.Right
notificationTime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notificationTime.BackgroundTransparency = 1
notificationTime.Position = UDim2.new(0, 6, 0, 0)
notificationTime.Size = UDim2.new(0, 324, 0, 34)
notificationTime.Visible = false
notificationTime.ZIndex = 2
notificationTime.Parent = topbar

local textFrame = Instance.new("Frame")
textFrame.Name = "TextFrame"
textFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textFrame.BackgroundTransparency = 1
textFrame.Position = UDim2.new(0, 0, 0.358, 0)
textFrame.Size = UDim2.new(1, 0, -0.0737, 68)
textFrame.Parent = notificationMain

local notificationDescription = Instance.new("TextLabel")
notificationDescription.Name = "NotificationDescription"
notificationDescription.Font = Enum.Font.GothamBold
notificationDescription.Text = Info.Description
notificationDescription.TextColor3 = Theme.SectionText
notificationDescription.TextSize = 18
notificationDescription.TextWrapped = true
notificationDescription.TextXAlignment = Enum.TextXAlignment.Left
notificationDescription.TextYAlignment = Enum.TextYAlignment.Top
notificationDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notificationDescription.BackgroundTransparency = 1
notificationDescription.Position = UDim2.new(0, 6, 0, 6)
notificationDescription.Size = UDim2.new(0, 330, 0, 55)
notificationDescription.ZIndex = 2
notificationDescription.Parent = textFrame

if not Info.Timeout then
    notificationCloseButton.Visible = true

    notificationCloseButton.MouseButton1Click:Connect(function()
        task.spawn(Info.Callback)
        local timedout = TweenService:Create(notificationMain, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 95)})
        timedout:Play()
        timedout.Completed:Wait()
        notificationMainUIStroke.Enabled = false
        notificationMain:Destroy()
    end)
end

local show = TweenService:Create(notificationMain, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 336, 0, 95)})
notificationMainUIStroke.Enabled = true
show:Play()

if Info.Timeout then
    notificationTime.Visible = true
    local Timeout = Info.Timeout
    notificationTime.Text = tostring(Timeout)
    task.spawn(function()
        while Timeout > 0 do
            task.wait(1)
            Timeout = Timeout - 1
            notificationTime.Text = tostring(Timeout)
        end
        task.spawn(Info.Callback)
        local timedout = TweenService:Create(notificationMain, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 95)})
        timedout:Play()
        timedout.Completed:Wait()
        notificationMainUIStroke.Enabled = false
        notificationMain:Destroy()
    end)
end
end

return pwans