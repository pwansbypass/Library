local library = {}
library.DefaultColor = Color3.fromRGB(56, 207, 154)

local TweenService = game:GetService("TweenService")

if not game:GetService("CoreGui"):FindFirstChild("NotificationLibrary") then
    local notificationLibrary = Instance.new("ScreenGui")
    notificationLibrary.Name = "NotificationLibrary"
    notificationLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    notificationLibrary.Parent = game:GetService("CoreGui")

    local notificationHolder = Instance.new("Frame")
    notificationHolder.Name = "NotificationHolder"
    notificationHolder.AnchorPoint = Vector2.new(0, 0.5)
    notificationHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notificationHolder.BackgroundTransparency = 1
    notificationHolder.Position = UDim2.fromScale(0, 0.5)
    notificationHolder.Size = UDim2.fromScale(0.8, 1)
    notificationHolder.Parent = notificationLibrary

    local notificationUIListLayout = Instance.new("UIListLayout")
    notificationUIListLayout.Name = "NotificationUIListLayout"
    notificationUIListLayout.FillDirection = Enum.FillDirection.Vertical
    notificationUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    notificationUIListLayout.Padding = UDim.new(0, 4)
    notificationUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    notificationUIListLayout.Parent = notificationHolder

    local notificationUIPadding = Instance.new("UIPadding")
    notificationUIPadding.Name = "NotificationUIPadding"
    notificationUIPadding.PaddingBottom = UDim.new(0, 9)
    notificationUIPadding.PaddingLeft = UDim.new(0, 5)
    notificationUIPadding.Parent = notificationHolder
end

local NotificationLib = game:GetService("CoreGui"):FindFirstChild("NotificationLibrary")
local Holder = NotificationLib:FindFirstChild("NotificationHolder")

function library:Notification(NotificationInfo)
    NotificationInfo.Text = NotificationInfo.Text or "This is a notification."
    NotificationInfo.Duration = NotificationInfo.Duration or 5
    NotificationInfo.Color = NotificationInfo.Color or library.DefaultColor

    local notificationText = Instance.new("TextLabel")
    notificationText.Name = "NotificationText"
    notificationText.ClipsDescendants = true
    notificationText.Font = Enum.Font.GothamBold
    notificationText.Text = NotificationInfo.Text
    notificationText.TextColor3 = Color3.fromRGB(214, 214, 214)
    notificationText.TextSize = 14
    notificationText.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
    notificationText.BorderSizePixel = 0
    notificationText.Position = UDim2.fromScale(0, 0.954)
    notificationText.Size = UDim2.fromOffset(0, 38)
    notificationText.Parent = Holder

    local outerFrame = Instance.new("Frame")
    outerFrame.Name = "OuterFrame"
    outerFrame.AnchorPoint = Vector2.new(0, 1)
    outerFrame.BackgroundColor3 = NotificationInfo.Color
    outerFrame.BorderSizePixel = 0
    outerFrame.Position = UDim2.fromScale(0, 1)
    outerFrame.Size = UDim2.new(1, 0, 0, 3)
    outerFrame.ZIndex = 2
    outerFrame.Parent = notificationText

    local notificationUICorner = Instance.new("UICorner")
    notificationUICorner.Name = "NotificationUICorner"
    notificationUICorner.CornerRadius = UDim.new(0, 4)
    notificationUICorner.Parent = notificationText

    local innerFrame = Instance.new("Frame")
    innerFrame.Name = "InnerFrame"
    innerFrame.AnchorPoint = Vector2.new(0, 1)
    innerFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    innerFrame.BorderSizePixel = 0
    innerFrame.Position = UDim2.fromScale(0, 1)
    innerFrame.Size = UDim2.new(1, 0, 0, 3)
    innerFrame.Parent = notificationText

    local NotifText = notificationText
    local TextBounds = NotifText.TextBounds

    coroutine.wrap(function()
        local InTween = TweenService:Create(NotifText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, TextBounds.X + 20, 0, 38)})
        InTween:Play()
        InTween.Completed:Wait()

        local LineTween = TweenService:Create(outerFrame, TweenInfo.new(NotificationInfo.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 3)})
        LineTween:Play()
        LineTween.Completed:Wait()

        local OutTween = TweenService:Create(NotifText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 38)})
        OutTween:Play()
        OutTween.Completed:Wait()
        notificationText:Destroy()
    end)()
end

return library
