local CoreGui = game:GetService('CoreGui')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local TextService = game:GetService('TextService')
local Players = game:GetService('Players')

local UIName = 'Visual UI Notification'
local Amount = 0
local Utility = {}
local Library = {}

do
    function Utility:DestroyUI()
        if CoreGui:FindFirstChild(UIName) ~= nil then
            CoreGui:FindFirstChild(UIName):Destroy()
        end
    end


    function Utility:Tween(Instance, Properties, Duration, ...)
        local TweenInfo = TweenInfo.new(Duration, ...)
        TweenService:Create(Instance, TweenInfo, Properties):Play()
    end
end

do
    Utility:DestroyUI()
end

function Library:CreateNotification(Title, Text, Duration)
    task.spawn(function()
        local Title = Title or 'Title'
        local Text = Text or 'Text'
        local Duration = Duration or 5

        if not CoreGui:FindFirstChild('Visual UI Notification') then
            Utility:Create('ScreenGui', {
                Name = 'Visual UI Notification',
                Parent = CoreGui
            })
        else
            Utility:Create('Frame', {
                Parent = CoreGui:FindFirstChild('Visual UI Notification'),
                Name = 'Notification'..tostring(Amount + 1),
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BorderSizePixel = 0,
                Position = UDim2.new(1, 300, 1, -30),
                Size = UDim2.new(0, 300, 0, 50),
                AnchorPoint = Vector2.new(1, 1)
            }, {
                Utility:Create('UICorner', {
                    CornerRadius = UDim.new(0, 5),
                    Name = 'NotificationCorner'
                }),
                Utility:Create('UIStroke', {
                    Name = 'NotificationStroke',
                    ApplyStrokeMode = 'Contextual',
                    Color = Color3.fromRGB(125, 125, 125),
                    LineJoinMode = 'Round',
                    Thickness = 1
                }),
                Utility:Create('TextLabel', {
                    Name = 'NotificationTitle',
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, -1),
                    Size = UDim2.new(0, 300, 0, 30),
                    Font = Enum.Font.Gotham,
                    Text = Title,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 16,
                    TextXAlignment = Enum.TextXAlignment.Left
                }, {
                    Utility:Create('UIPadding', {
                        Name = 'NotificationTitlePadding',
                        PaddingLeft = UDim.new(0, 7)
                    })
                }),
                Utility:Create('TextLabel', {
                    Name = 'NotificationText',
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 25),
                    Size = UDim2.new(0, 300, 0, 30),
                    Font = Enum.Font.Gotham,
                    Text = Text,
                    TextWrapped = true,
                    TextColor3 = Color3.fromRGB(135, 135, 135),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left
                }, {
                    Utility:Create('UIPadding', {
                        Name = 'NotificationTextPadding',
                        PaddingLeft = UDim.new(0, 7)
                    })
                })
            })

            Amount = Amount + 1
            local Holder = CoreGui:FindFirstChild('Visual UI Notification')['Notification'..tostring(Amount)]
            local TitleObj = Holder['NotificationTitle']
            local TextObj = Holder['NotificationText']
            local TextSize = TextService:GetTextSize(Text, 14, Enum.Font.Gotham, Vector2.new(300, math.huge))
            Holder.Size = UDim2.new(0, 300, 0, TextSize.Y + 30)
            TextObj.Size = UDim2.new(0, 300, 0, TextSize.Y)
            if Amount > 1 then
                local Previous = Holder.Parent['Notification'..tostring(Amount - 1)]
                local PreviousSize = Previous.AbsoluteSize.Y
                Holder.Position = UDim2.new(1, 300, 1, -30 - PreviousSize - 5)
                Utility:Tween(Holder, {Position = UDim2.new(1, -30, 1, -30 - PreviousSize - 5)}, 0.5)
                Previous.Changed:Connect(function(Property)
                    if Property == 'Position' then
                        if Previous.Position == UDim2.new(1, 300, 1, Previous.Position.Y.Offset) then
                            Utility:Tween(Holder, {Position = UDim2.new(1, -30, 1, -30)}, 0.5)
                        end
                    end
                end)
            else
                Utility:Tween(Holder, {Position = UDim2.new(1, -30, 1, -30)}, 0.5)
            end
            task.wait(Duration - 1)
            Utility:Tween(Holder, {BackgroundTransparency = 0.5}, 0.25)
            Utility:Tween(TitleObj, {TextTransparency = 0.5}, 0.25)
            Utility:Tween(TextObj, {TextTransparency = 0.5}, 0.25)
            task.wait(0.5)
            Utility:Tween(Holder, {Position = UDim2.new(1, 300, 1, Holder.Position.Y.Offset)}, 0.5)
            task.wait(0.5)
            Holder:Destroy()
            Amount = Amount - 1
        end
    end)
end
return Library
