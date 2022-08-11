-- // Services
local CoreGui = game:GetService('CoreGui')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local TextService = game:GetService('TextService')
local Players = game:GetService('Players')

-- // Variables
local UIName = 'Visual UI Library'
local Amount = 0
local Utility = {}
local Library = {}

-- // Utility Functions
do
    function Utility:DestroyUI()
        if CoreGui:FindFirstChild(UIName) ~= nil then
            CoreGui:FindFirstChild(UIName):Destroy()
        end
    end

    function Utility:ToggleUI()
        if CoreGui:FindFirstChild(UIName) ~= nil then
            CoreGui:FindFirstChild(UIName).Enabled = not CoreGui:FindFirstChild(UIName).Enabled
        end
    end

    function Utility:EnableDragging(Frame)
        local Dragging, DraggingInput, DragStart, StartPosition
        
        local function Update(Input)
            local Delta = Input.Position - DragStart
            Frame.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
        end
        
        Frame.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
                DragStart = Input.Position
                StartPosition = Frame.Position
        
                Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                    end
                end)
            end
        end)
        
        Frame.InputChanged:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                DraggingInput = Input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(Input)
            if Input == DraggingInput and Dragging then
                Update(Input)
            end
        end)
    end

    function Utility:Create(_Instance, Properties, Children)
        local Object = Instance.new(_Instance)
        local Properties = Properties or {}
        local Children = Children or {}
        
        for Index, Property in next, Properties do
            Object[Index] = Property
        end

        for _, Child in next, Children do
            Child.Parent = Object
        end

        return Object
    end

    function Utility:Tween(Instance, Properties, Duration, ...)
        local TweenInfo = TweenInfo.new(Duration, ...)
        TweenService:Create(Instance, TweenInfo, Properties):Play()
    end
end

do
    Utility:DestroyUI()
end

-- // Library Functions
function Library:DestroyUI()
    Utility:DestroyUI()
end

function Library:ToggleUI()
    Utility:ToggleUI()
end

function Library:CreateNotification(Title, Text, Duration)
    task.spawn(function()
        local Title = Title or 'Title'
        local Text = Text or 'Text'
        local Duration = Duration or 5

        if not CoreGui:FindFirstChild('Visual UI Library | .gg/puxxCphTnK | Notifications') then
            Utility:Create('ScreenGui', {
                Name = 'Visual UI Library | .gg/puxxCphTnK | Notifications',
                Parent = CoreGui
            })
        else
            Utility:Create('Frame', {
                Parent = CoreGui:FindFirstChild('Visual UI Library | .gg/puxxCphTnK | Notifications'),
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
            local Holder = CoreGui:FindFirstChild('Visual UI Library | .gg/puxxCphTnK | Notifications')['Notification'..tostring(Amount)]
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

function Library:CreateWindow(HubName, GameName)
    local HubName = HubName or 'UI Name'
    local GameName = GameName or 'Game Name'

    local Container = Utility:Create('ScreenGui', {
        Name = UIName,
        Parent = CoreGui
    }, {
        Utility:Create('Frame', {
            Name = 'Main',
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 595, 0, 150),
            Size = UDim2.new(0, 600, 0, 375)
        }, {
            Utility:Create('UICorner', {
                CornerRadius = UDim.new(0, 5),
                Name = 'MainCorner'
            }),
            Utility:Create('Frame', {
                Name = 'Sidebar',
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                BorderSizePixel = 0,
                Size = UDim2.new(0, 170, 0, 375)
            }, {
                Utility:Create('UICorner', {
                    CornerRadius = UDim.new(0, 5),
                    Name = 'SidebarCorner'
                }),
                Utility:Create('TextLabel', {
                    Name = 'HubNameText',
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 6),
                    Size = UDim2.new(0, 170, 0, 20),
                    Font = Enum.Font.Gotham,
                    Text = HubName,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 18,
                    TextXAlignment = Enum.TextXAlignment.Left
                }, {
                    Utility:Create('UIPadding', {
                        Name = 'HubNameTextPadding',
                        PaddingLeft = UDim.new(0, 7)
                    })
                }), 
                Utility:Create('TextLabel', {
                    Name = 'GameNameText',
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 26),
                    Size = UDim2.new(0, 170, 0, 20),
                    Font = Enum.Font.Gotham,
                    Text = GameName,
                    TextColor3 = Color3.fromRGB(135, 135, 135),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left
                }, {
                    Utility:Create('UIPadding', {
                        Name = 'GameNameTextPadding',
                        PaddingLeft = UDim.new(0, 7)
                    })
                }),
                Utility:Create('Frame', {
                    Name = 'SidebarLine1',
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 170, 0, -1),
                    Size = UDim2.new(0, 1, 0, 375)
                }),
                Utility:Create('Frame', {
                    Name = 'SidebarLine2',
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 48),
                    Size = UDim2.new(0, 170, 0, 1)
                }),
                Utility:Create('ScrollingFrame', {
                    Name = 'TabButtonHolder',
                    Active = true,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 55),
                    Size = UDim2.new(0, 170, 0, 313),
                    ScrollBarThickness = 0
                }, {
                    Utility:Create('UIListLayout', {
                        Name = 'TabButtonHolderListLayout',
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 3)
                    })
                })
            }),
            Utility:Create('Frame', {
                Name = 'TabContainer',
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BorderSizePixel = 0,
                Position = UDim2.new(0, 171, 0, 9),
                Size = UDim2.new(0, 429, 0, 355)
            }, {
                Utility:Create('Folder', {
                    Name = 'TabsFolder'
                })
            })
        })
    })

    Utility:EnableDragging(Container.Main)

    local Tabs = {}

    function Tabs:CreateTab(TabName, DefaultVisibility, Icon, RectOffset, RectSize)
        local TabName = TabName or 'Tab'
        local RectOffset = RectOffset or Vector2.new(0, 0)
        local RectSize = RectSize or Vector2.new(0, 0)

        Utility:Create('ScrollingFrame', {
            Name = TabName,
            Parent = Container.Main.TabContainer.TabsFolder,
            Active = true,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 428, 0, 365),
            BorderSizePixel = 0,
            ScrollBarImageColor3 = Color3.fromRGB(125, 125, 125),
            ScrollBarThickness = 3
        }, {
            Utility:Create('UIListLayout', {
                Name = TabName..'ListLayout',
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 3)
            })
        })
        Utility:Create('Frame', {
            Name = TabName..'ButtonFrame',
            Parent = Container.Main.Sidebar.TabButtonHolder,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 170, 0, 30)
        }, {
            Utility:Create('TextButton', {
                Name = TabName..'Button',
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Text = '',
                Size = UDim2.new(0, 170, 0, 30),
                BorderSizePixel = 0,
                ZIndex = 2
            }),
            Utility:Create('ImageLabel', {
                Name = TabName..'ButtonImage',
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 5),
                Size = UDim2.new(0, 20, 0, 20),
                Image = Icon,
                ImageRectOffset = RectOffset,
                ImageRectSize = RectSize
            }),
            Utility:Create('TextLabel', {
                Name = TabName..'ButtonText',
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 30, 0, 3),
                Size = UDim2.new(0, 140, 0, 24),
                Font = Enum.Font.Gotham,
                Text = TabName,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left
            }, {
                Utility:Create('UIPadding', {
                    Name = TabName..'ButtonTextPadding',
                    PaddingLeft = UDim.new(0, 5)
                })
            })
        })
        
        local TabFolder = Container.Main.TabContainer.TabsFolder
        local Tab = TabFolder[TabName]
        local TabButtonHolder = Container.Main.Sidebar.TabButtonHolder
        local TabButton = TabButtonHolder[TabName..'ButtonFrame'][TabName..'Button']
        local TabListLayout = Tab[TabName..'ListLayout']

        function UpdateTabSize()
            for _, Item in next, Tab:GetDescendants() do
                if Item:IsA('UIListLayout') and Item.Parent.Parent == Tab then
                    Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize + UDim2.new(0, 0, 0, Item.AbsoluteContentSize.Y + TabListLayout.AbsoluteContentSize.Y)}, 0.25)
                end
            end
        end

        UpdateTabSize()
        Tab.ChildAdded:Connect(UpdateTabSize)
        Tab.ChildRemoved:Connect(UpdateTabSize)

        if DefaultVisibility then
            TabButton.Parent[TabName..'ButtonText'].TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.Parent[TabName..'ButtonImage'].ImageColor3 = Color3.fromRGB(255, 255, 255)
            Tab.Visible = true

            for _, ITab in next, TabFolder:GetChildren()do 
                if ITab:IsA('ScrollingFrame') and ITab ~= Tab then
                    ITab.Visible = false
                end
            end
        else
            Tab.Visible = false
            TabButton.Parent[TabName..'ButtonText'].TextColor3 = Color3.fromRGB(125, 125, 125)
            TabButton.Parent[TabName..'ButtonImage'].ImageColor3 = Color3.fromRGB(125, 125, 125)
        end

        TabButton.MouseButton1Down:Connect(function()
            UpdateTabSize()

            for _, ITab in next, TabFolder:GetChildren() do
                ITab.Visible = false
            end

            Tab.Visible = true
                
            for _, Item in next, TabButtonHolder:GetDescendants() do
                if Item:IsA('TextLabel') then 
                    Utility:Tween(Item, {TextColor3 = Color3.fromRGB(125, 125, 125)}, 0.25)
                elseif Item:IsA('ImageLabel') then
                    Utility:Tween(Item, {ImageColor3 = Color3.fromRGB(125, 125, 125)}, 0.25)
                end
            end

            Utility:Tween(TabButton.Parent[TabName..'ButtonText'], {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.25)
            Utility:Tween(TabButton.Parent[TabName..'ButtonImage'], {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.25)
        end) 

        local Sections = {}

        function Sections:CreateSection(Name)
            local Name = Name or 'Section'
            
            Utility:Create('Frame', {
                Name = Name..'Section',
                Parent = Tab,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BorderSizePixel = 0,
                Position = UDim2.new(0.0210280381, 0, -0.800000012, 0),
                Size = UDim2.new(0, 410, 0, 30),
            }, {
                Utility:Create('TextLabel', {
                    Name = Name..'SectionLabel',
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, 410, 0, 30),
                    Font = Enum.Font.Gotham,
                    Text = Name,
                    TextColor3 = Color3.fromRGB(135, 135, 135),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
                Utility:Create('UIListLayout', {
                    Name = Name..'ListLayout',
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 6)
                })
            })

            local Section = Tab[Name..'Section']

            function UpdateSectionSize()
                local ContentSize = Section[Name..'ListLayout'].AbsoluteContentSize

                Utility:Tween(Section, {Size = UDim2.new(0, ContentSize.X, 0, ContentSize.Y)}, 0.25)
            end

            for _, Item in next, Section:GetChildren() do
                RunService.RenderStepped:Connect(function()
                    if Item:IsA('Frame') then
                        Item.Changed:Connect(function(Property)
                            if Property == 'Size' then
                                UpdateTabSize()
                                UpdateSectionSize()
                            end
                        end)
                    end
                end)
            end

            UpdateSectionSize()
            Section.ChildAdded:Connect(UpdateSectionSize)
            Section.ChildRemoved:Connect(UpdateSectionSize)

            local Elements = {}
            
            function Elements:CreateLabel(LabelText)
                local LabelText = LabelText or 'Label'
                local LabelFunctions = {}

                Utility:Create('Frame', {
                    Name = LabelText..'LabelHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                    Size = UDim2.new(0, 410, 0, 30)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = LabelText..'LabelHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = LabelText..'LabelStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextLabel', {
                        Name = LabelText..'Label',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 410, 0, 30),
                        Font = Enum.Font.Gotham,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        Text = LabelText,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = LabelText..'LabelCorner'
                        }),
                        Utility:Create('UIPadding', {
                            Name = LabelText..'LabelPadding',
                            PaddingLeft = UDim.new(0, 7)
                        })
                    })
                })

                function LabelFunctions:UpdateLabel(NewText)
                    Section[LabelText..'LabelHolder'][LabelText..'Label'].Text = NewText
                end
                return LabelFunctions
            end

            function Elements:CreateParagraph(Title, Paragraph)
                local Title = Title or 'Title'
                local Paragraph = Paragraph or 'Text'
                local ParagraphFunctions = {}

                Utility:Create('Frame', {
                    Name = Title..'ParagraphHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                    Size = UDim2.new(0, 410, 0, 37)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = Title..'ParagraphHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = Title..'ParagraphStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextLabel', {
                        Name = Title..'ParagraphTitle',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 0),
                        Size = UDim2.new(0, 410, 0, 20),
                        Font = Enum.Font.Gotham,
                        Text = Title,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Title..'ParagraphTitleCorner'
                        }),
                        Utility:Create('UIPadding', {
                            Name = Title..'ParagraphTitlePadding',
                            PaddingLeft = UDim.new(0, 7)
                        })
                    }),
                    Utility:Create('TextLabel', {
                        Name = Title..'ParagraphContent',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 16),
                        Size = UDim2.new(0, 410, 0, 20),
                        Font = Enum.Font.Gotham,
                        Text = Paragraph,
                        TextColor3 = Color3.fromRGB(125, 125, 125),
                        TextWrapped = true,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Title..'ParagraphContentCorner'
                        }),
                        Utility:Create('UIPadding', {
                            Name = Title..'ParagraphContentPadding',
                            PaddingLeft = UDim.new(0, 7)
                        })
                    })
                })
                local Old

                local ParagraphHolder = Section[Title..'ParagraphHolder']
                local ParagraphContent = Section[Title..'ParagraphHolder'][Title..'ParagraphContent']
                local ParagraphTitle = Section[Title..'ParagraphHolder'][Title..'ParagraphTitle']

                UpdateTabSize()
                UpdateSectionSize()

                function ParagraphFunctions:UpdateParagraph(NewTitle, NewParagraph)
                    Old = ParagraphContent.Text
                    print(Old)
                    ParagraphTitle.Text = NewTitle
                    ParagraphContent.Text = NewParagraph
                    local TextSizeNew = TextService:GetTextSize(ParagraphContent.Text, 14, Enum.Font.Gotham, Vector2.new(410, math.huge))
                    local TextSizeOld = TextService:GetTextSize(Old, 14, Enum.Font.Gotham, Vector2.new(410, math.huge))

                    if TextSizeNew.Y > 14 and TextSizeNew.Y > TextSizeOld.Y then
                        Tab.CanvasSize = Tab.CanvasSize - UDim2.new(0, 0, 0, TextSizeOld.Y + 5)
                        Section.Size = Section.Size - UDim2.new(0, 0, 0, TextSizeOld.Y + 5)
                        Tab.CanvasSize = Tab.CanvasSize + UDim2.new(0, 0, 0, TextSizeNew.Y + 5)
                        Section.Size = Section.Size + UDim2.new(0, 0, 0, TextSizeNew.Y + 5)
                        ParagraphHolder.Size = UDim2.new(0, 410, 0, TextSizeNew.Y + 20)
                        ParagraphContent.Size = UDim2.new(0, 410, 0, TextSizeNew.Y)
                        --Tab.CanvasSize = Tab.CanvasSize + UDim2.new(0, 0, 0, TextSizeNew.Y + 5)
                        --Section.Size = Section.Size + UDim2.new(0, 0, 0, TextSizeNew.Y + 5)
                    elseif TextSizeNew.Y < TextSizeOld.Y then
                        Tab.CanvasSize = Tab.CanvasSize - UDim2.new(0, 0, 0, TextSizeOld.Y + 5)
                        Section.Size = Section.Size - UDim2.new(0, 0, 0, TextSizeOld.Y + 5)
                        Tab.CanvasSize = Tab.CanvasSize + UDim2.new(0, 0, 0, TextSizeNew.Y + 5)
                        Section.Size = Section.Size + UDim2.new(0, 0, 0, TextSizeNew.Y + 5)
                        ParagraphHolder.Size = ParagraphHolder.Size - UDim2.new(0, 0, 0, TextSizeOld.Y)
                        ParagraphHolder.Size = UDim2.new(0, 410, 0, TextSizeNew.Y + 20)
                        ParagraphContent.Size = UDim2.new(0, 410, 0, TextSizeNew.Y)
                    end       
                end
                return ParagraphFunctions
            end

            function Elements:CreateButton(Name, Callback)
                local Name = Name or 'Button'
                local Callback = Callback or function() end

                Utility:Create('Frame', {
                    Name = Name..'ButtonHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                    Size = UDim2.new(0, 410, 0, 30)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = Name..'ButtonHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = Name..'ButtonHolderStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextButton', {
                        Name = Name..'Button',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 410, 0, 30),
                        Font = Enum.Font.Gotham,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Text = Name
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = 'ButtonCorner'
                        }),
                        Utility:Create('UIPadding', {
                            Name = 'ButtonPadding',
                            PaddingLeft = UDim.new(0, 7)
                        }),
                        Utility:Create('ImageLabel', {
                            Name = 'ButtonImage',
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 374, 0, 3),
                            Size = UDim2.new(0, 25, 0, 25),
                            Image = 'rbxassetid://3926307971',
                            ImageColor3 = Color3.fromRGB(135, 135, 135),
                            ImageRectOffset = Vector2.new(564, 364),
                            ImageRectSize = Vector2.new(36, 36)
                        })
                    })
                })

                UpdateSectionSize()

                local Button = Section[Name..'ButtonHolder'][Name..'Button']

                Button.MouseButton1Down:Connect(function()
                    Utility:Tween(Button.Parent, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}, 0.25)
                    Callback()
                    task.wait(0.25)
                    Utility:Tween(Button.Parent, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                end)

                Button.MouseEnter:Connect(function()
                    Utility:Tween(Button.Parent, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.25)
                end)

                Button.MouseLeave:Connect(function()
                    Utility:Tween(Button.Parent, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                end)
            end

            function Elements:CreateSlider(Name, MinimumValue, MaximumValue, SliderColor, Callback)
                local Name = Name or 'Slider'
                local MinimumValue = MinimumValue or 1
                local MaximumValue = MaximumValue or 100
                local SliderColor = SliderColor or Color3.fromRGB(0, 125, 255)
                local Callback = Callback or function() end
                local CurrentValue = nil

                Utility:Create('Frame', {
                    Name = Name..'SliderHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                    Size = UDim2.new(0, 410, 0, 50)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = Name..'SliderHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = Name..'SliderHolderStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextLabel', {
                        Name = 'SliderText',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 300, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = Name,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'SliderTextCorner'
                        }),
                        Utility:Create('UIPadding', {
                            Name = Name..'SliderTextPadding',
                            PaddingLeft = UDim.new(0, 7)
                        }),
                    }),
                    Utility:Create('TextButton', {
                        Name = Name..'SliderButton',
                        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                        Position = UDim2.new(0, 7, 0, 29),
                        Size = UDim2.new(0, 395, 0, 10),
                        Text = '',
                        BorderSizePixel = 0,
                        AutoButtonColor = false
                    }, {
                        Utility:Create('UIStroke', {
                            Name = Name..'SliderButtonStroke',
                            ApplyStrokeMode = 'Contextual',
                            Color = Color3.fromRGB(60, 60, 60),
                            LineJoinMode = 'Round',
                            Thickness = 1
                        }),
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'SliderButtonCorner'
                        }),
                        Utility:Create('Frame', {
                            Name = Name..'SliderTrail',
                            BackgroundColor3 = SliderColor,
                            Size = UDim2.new(0, 0, 0, 10),
                            BorderSizePixel = 0
                        }, {
                            Utility:Create('UICorner', {
                                CornerRadius = UDim.new(0, 5),
                                Name = Name..'SliderTrailCorner'
                            })
                        })
                    }),
                    Utility:Create('TextLabel', {
                        Name = Name..'SliderNumberText',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 299, 0, 0),
                        Size = UDim2.new(0, 110, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = '0',
                        TextColor3 = Color3.fromRGB(125, 125, 125),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Right
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'SliderNumberTextCorner'
                        }),
                        Utility:Create('UIPadding', {
                            Name = Name..'SliderNumberTextPadding',
                            PaddingRight = UDim.new(0, 7)
                        })
                    })
                })

                local Mouse = Players.LocalPlayer:GetMouse()
                local SliderHolder = Section[Name..'SliderHolder']
                local SliderButton = SliderHolder[Name..'SliderButton']
                local SliderNumber = SliderHolder[Name..'SliderNumberText']
                local SliderTrail = SliderButton[Name..'SliderTrail']

                SliderButton.MouseButton1Down:Connect(function()
                    CurrentValue = math.floor((((tonumber(MaximumValue) - tonumber(MinimumValue)) / 395) * SliderTrail.AbsoluteSize.X) + tonumber(MinimumValue)) or 0
                    Callback(CurrentValue)
                    Utility:Tween(SliderTrail, {Size = UDim2.new(0, math.clamp(Mouse.X - SliderTrail.AbsolutePosition.X, 0, 395), 0, 10)}, 0.25)
                    MoveConnection = Mouse.Move:Connect(function()
                        SliderNumber.Text = CurrentValue
                        CurrentValue = math.floor((((tonumber(MaximumValue) - tonumber(MinimumValue)) / 395) * SliderTrail.AbsoluteSize.X) + tonumber(MinimumValue))
                        Callback(CurrentValue)
                        Utility:Tween(SliderNumber, {TextColor3 = Color3.new(255, 255, 255)}, 0.25)
                        Utility:Tween(SliderTrail, {Size = UDim2.new(0, math.clamp(Mouse.X - SliderTrail.AbsolutePosition.X, 0, 395), 0, 10)}, 0.25)
                    end)
                    ReleaseConnection = UserInputService.InputEnded:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            CurrentValue = math.floor((((tonumber(MaximumValue) - tonumber(MinimumValue)) / 395) * SliderTrail.AbsoluteSize.X) + tonumber(MinimumValue))
                            Callback(CurrentValue)
                            Utility:Tween(SliderTrail, {Size = UDim2.new(0, math.clamp(Mouse.X - SliderTrail.AbsolutePosition.X, 0, 395), 0, 10)}, 0.25)
                            MoveConnection:Disconnect()
                            ReleaseConnection:Disconnect()
                        end
                    end)
                end)

                SliderHolder.MouseEnter:Connect(function()
                    Utility:Tween(SliderHolder, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.25)
                end)

                SliderHolder.MouseLeave:Connect(function()
                    Utility:Tween(SliderHolder, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                end)
            end

            function Elements:CreateTextbox(Name, Placeholder, Callback)
                local Name = Name or 'Textbox'
                local Placeholder = Placeholder or 'Input'
                local Callback = Callback or function() end
                local Length = nil

                Utility:Create('Frame', {
                    Name = Name..'TextboxHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                    Size = UDim2.new(0, 410, 0, 40)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = Name..'TextboxHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = Name..'TextboxHolderStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextLabel', {
                        Name = Name..'TextboxText',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 5),
                        Size = UDim2.new(0, 299, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = Name,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UIPadding', {
                            Name = Name..'TextboxTextPadding',
                            PaddingLeft = UDim.new(0, 7)
                        })
                    }),
                    Utility:Create('TextBox', {
                        Name = Name..'Textbox',
                        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(0, 400, 0, 20),
                        Size = UDim2.new(0, 50, 0, 25),
                        Font = Enum.Font.Gotham,
                        PlaceholderColor3 = Color3.fromRGB(175, 175, 175),
                        Text = Placeholder,
                        TextColor3 = Color3.fromRGB(175, 175, 175),
                        TextSize = 14,
                        ClearTextOnFocus = false
                    }, {
                        Utility:Create('UIStroke', {
                            Name = Name..'TextboxStroke',
                            ApplyStrokeMode = 'Contextual',
                            Color = Color3.fromRGB(60, 60, 60),
                            LineJoinMode = 'Round',
                            Thickness = 1
                        }),
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'TextboxCorner'
                        })
                    })
                })

                local TextboxHolder = Section[Name..'TextboxHolder']
                local Textbox = TextboxHolder[Name..'Textbox']

                local TextSize = TextService:GetTextSize(Placeholder, 14, Enum.Font.Gotham, Vector2.new(410, 40))

                if TextSize.X < 50 then 
                    Utility:Tween(Textbox, {Size = UDim2.new(0, 50, 0, 25)}, 0.25)
                else
                    Utility:Tween(Textbox, {Size = UDim2.new(0, TextSize.X + 10, 0, 25)}, 0.25)
                end

                Textbox.Focused:Connect(function()
                    Utility:Tween(Textbox, {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}, 0.25)
                    Utility:Tween(TextboxHolder, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.25)
                end)
                
                Textbox.FocusLost:Connect(function()
                    Utility:Tween(Textbox, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.25)
                    Utility:Tween(TextboxHolder, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                    Callback(Textbox.Text)
                end)

                TextboxHolder.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Textbox:CaptureFocus()
                    end
                end)

                Textbox.Changed:Connect(function(Property)
                    if Property == 'Text' then
                        Utility:Tween(Textbox, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.25)

                        local TextSize = TextService:GetTextSize(Textbox.Text, 14, Enum.Font.Gotham, Vector2.new(410, 40))

                        if TextSize.X < 50 then 
                            Utility:Tween(Textbox, {Size = UDim2.new(0, 50, 0, 25)}, 0.25)
                        else
                            Utility:Tween(Textbox, {Size = UDim2.new(0, TextSize.X + 10, 0, 25)}, 0.25)
                        end
                    end
                end)

                TextboxHolder.MouseEnter:Connect(function()
                    Utility:Tween(TextboxHolder, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.25)
                end)

                TextboxHolder.MouseLeave:Connect(function()
                    Utility:Tween(TextboxHolder, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                end)
            end

            function Elements:CreateKeybind(Name, Key, Callback)
                local Name = Name or 'Keybind'
                local Key = Key or 'E'
                local Callback = Callback or function() end
                local Current = Key

                Utility:Create('Frame', {
                    Name = Name..'KeybindHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                    Size = UDim2.new(0, 410, 0, 40)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = Name..'KeybindHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = Name..'KeybindHolderStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextLabel', {
                        Name = Name..'KeybindText',
                        Parent = KeybindHolder,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 5),
                        Size = UDim2.new(0, 352, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = Name,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UIPadding', {
                            Name = Name..'KeybindTextPadding',
                            PaddingLeft = UDim.new(0, 7)
                        })
                    }), 
                    Utility:Create('TextButton', {
                        Name = Name..'Keybind',
                        Parent = KeybindHolder,
                        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                        Position = UDim2.new(0, 376, 0, 8),
                        Size = UDim2.new(0, 25, 0, 25),
                        Font = Enum.Font.Gotham,
                        Text = Current,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(0, 400, 0, 20),
                        TextColor3 = Color3.fromRGB(175, 175, 175),
                        TextSize = 14,
                        AutoButtonColor = false
                    }, {
                        Utility:Create('UIStroke', {
                            Name = Name..'KeybindStroke',
                            ApplyStrokeMode = 'Contextual',
                            Color = Color3.fromRGB(60, 60, 60),
                            LineJoinMode = 'Round',
                            Thickness = 1
                        }),
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'KeybindCorner'
                        })
                    })
                })
                
                local KeybindHolder = Section[Name..'KeybindHolder']
                local Keybind = KeybindHolder[Name..'Keybind']

                TextSize = TextService:GetTextSize(Current, 14, Enum.Font.Gotham, Vector2.new(410, 40))
                if TextSize.X < 25 then
                    Utility:Tween(Keybind, {Size = UDim2.new(0, 25, 0, 25)}, 0.25)
                else 
                    Utility:Tween(Keybind, {Size = UDim2.new(0, TextSize.X + 10, 0, 25)}, 0.25)
                end

                Keybind.MouseButton1Click:Connect(function()
                    Keybind.Text = '. . .'
                    Utility:Tween(KeybindHolder, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.25)
                    local Input, _ = UserInputService.InputBegan:wait();

                    if Input.KeyCode.Name ~= 'Unknown' then
                        Keybind.Text = Input.KeyCode.Name
                        TextSize = TextService:GetTextSize(Input.KeyCode.Name, 14, Enum.Font.Gotham, Vector2.new(410, 40))
                        if TextSize.X < 25 then
                            Utility:Tween(Keybind, {Size = UDim2.new(0, 25, 0, 25)}, 0.25)
                        else 
                            Utility:Tween(Keybind, {Size = UDim2.new(0, TextSize.X + 10, 0, 25)}, 0.25)
                        end
                        Current = Input.KeyCode.Name;
                        Utility:Tween(KeybindHolder, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                    end
                end)

                UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
                    if not GameProcessedEvent then 
                        if Input.KeyCode.Name == Current then
                            Callback()
                        end
                    end
                end)

                KeybindHolder.MouseEnter:Connect(function()
                    Utility:Tween(KeybindHolder, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.25)
                end)

                KeybindHolder.MouseLeave:Connect(function()
                    Utility:Tween(KeybindHolder, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                end)
            end

            function Elements:CreateToggle(Name, Default, ToggleColor, DebounceAmount, Callback)
                local Name = Name or 'Toggle'
                local Default = Default or false
                local Callback = Callback or function() end
                local Toggled = Default
                local ToggleColor = ToggleColor or Color3.fromRGB(0, 255, 100)
                local Debounce = false
                local DebounceAmount = DebounceAmount or 0.25

                Utility:Create('Frame', {
                    Name = Name..'ToggleHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                    Size = UDim2.new(0, 410, 0, 40)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = Name..'ToggleHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = Name..'ToggleHolderStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextLabel', {
                        Name = Name..'ToggleText',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 5),
                        Size = UDim2.new(0, 344, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = Name,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UIPadding', {
                            Name = Name..'ToggleTextPadding',
                            PaddingLeft = UDim.new(0, 7)
                        })
                    }),
                    Utility:Create('Frame', {
                        Name = Name..'Toggle',
                        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                        Position = UDim2.new(0, 352, 0, 8),
                        Size = UDim2.new(0, 50, 0, 25)        
                    }, {
                        Utility:Create('UIStroke', {
                            Name = Name..'ToggleStroke',
                            ApplyStrokeMode = 'Contextual',
                            Color = Color3.fromRGB(60, 60, 60),
                            LineJoinMode = 'Round',
                            Thickness = 1
                        }),
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 25),
                            Name = Name..'ToggleCorner'
                        }),
                        Utility:Create('ImageLabel', {
                            Name = Name..'ToggleCircle',
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 5, 0, 5),
                            Size = UDim2.new(0, 15, 0, 15),
                            Image = 'rbxassetid://3570695787',
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.120,
                        })
                    }),
                    Utility:Create('TextButton', {
                        Name = Name..'ToggleButton',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, 0),
                        Size = UDim2.new(0, 410, 0, 40),
                        Font = Enum.Font.SourceSans,
                        Text = '',
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        TextSize = 14
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'ToggleButtonCorner'
                        })
                    })
                })

                local ToggleHolder = Section[Name..'ToggleHolder']
                local ToggleButton = ToggleHolder[Name..'ToggleButton']
                local Toggle = ToggleHolder[Name..'Toggle']
                local Circle = Toggle[Name..'ToggleCircle']

                if Default then
                    Callback(Default)
                    Utility:Tween(Toggle, {BackgroundColor3 = ToggleColor}, 0.25)
                    Utility:Tween(Circle, {Position = UDim2.new(0, 30, 0, 5)}, 0.25)
                end

                ToggleButton.MouseButton1Down:Connect(function()
                    if not Debounce then
                        Toggled = not Toggled
                        Debounce = true
                        if Toggled then
                            Utility:Tween(Toggle, {BackgroundColor3 = ToggleColor}, 0.25)
                            Utility:Tween(Circle, {Position = UDim2.new(0, 30, 0, 5)}, 0.25)
                        else
                            Utility:Tween(Toggle, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.25)
                            Utility:Tween(Circle, {Position = UDim2.new(0, 5, 0, 5)}, 0.25)
                        end
                        Callback(Toggled)
                        task.wait(DebounceAmount)
                        Debounce = false
                    end
                end)

                ToggleHolder.MouseEnter:Connect(function()
                    Utility:Tween(ToggleHolder, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.5)
                end)

                ToggleHolder.MouseLeave:Connect(function()
                    Utility:Tween(ToggleHolder, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.5)
                end)
            end

            function Elements:CreateDropdown(Name, List, DebounceAmount, Callback)
                local Name = Name or 'Dropdown'
                local List = List or {}
                local Callback = Callback or function() end
                local DebounceAmount = DebounceAmount or 0.25
                local SelectedItem = 'None'
                local Opened = false
                local Debounce = false
                local DropdownFunctions = {}

                Utility:Create('Frame', {
                    Name = Name..'DropdownHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                    Size = UDim2.new(0, 410, 0, 40)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = Name..'DropdownHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = Name..'DropdownHolderStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextLabel', {
                        Name = Name..'DropdownText',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 5),
                        Size = UDim2.new(0, 200, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = Name,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UIPadding', {
                            Name = Name..'DropdownTextPadding',
                            PaddingLeft = UDim.new(0, 7)
                        })
                    }),
                    Utility:Create('ImageLabel', {
                        Name = Name..'DropdownIcon',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 377, 0, 8),
                        Rotation = 270,
                        Size = UDim2.new(0, 25, 0, 25),
                        Image = 'rbxassetid://3926305904',
                        ImageColor3 = Color3.fromRGB(125, 125, 125),
                        ImageRectOffset = Vector2.new(964, 284),
                        ImageRectSize = Vector2.new(36, 36)
                    }),
                    Utility:Create('TextLabel', {
                        Name = Name..'DropdownSelectedText',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 199, 0, 8),
                        Size = UDim2.new(0, 176, 0, 25),
                        Font = Enum.Font.Gotham,
                        Text = SelectedItem,
                        TextColor3 = Color3.fromRGB(125, 125, 125),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Right
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'DropdownSelectedTextCorner'
                        }),
                        Utility:Create('UIPadding', {
                            Name = Name..'DropdownSelectedTextPadding',
                            PaddingRight = UDim.new(0, 7)
                        })
                    }),
                    Utility:Create('ScrollingFrame', {
                        Name = Name..'DropList',
                        Active = true,
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 1, 0),
                        Size = UDim2.new(0, 410, 0, 30),
                        Visible = false,
                        ScrollBarImageColor3 = Color3.fromRGB(125, 125, 125),
                        ScrollBarThickness = 3
                    }, {
                        Utility:Create('UIStroke', {
                            Name = Name..'DropListStroke',
                            ApplyStrokeMode = 'Contextual',
                            Color = Color3.fromRGB(60, 60, 60),
                            LineJoinMode = 'Round',
                            Thickness = 1
                        }),
                        Utility:Create('UIListLayout', {
                            Name = Name..'DropListLayout',
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }),
                    }),
                    Utility:Create('TextButton', {
                        Name = Name..'DropdownButton',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, 0),
                        Size = UDim2.new(0, 410, 0, 40),
                        Font = Enum.Font.SourceSans,
                        Text = '',
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        TextSize = 14
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'DropdownButtonCorner'
                        })
                    })
                })
                Utility:Create('Frame', {
                    Name = Name..'DropdownFiller',
                    Parent = Section,
                    Visible = false,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 410, 0, 0)
                })

                local DropdownHolder = Section[Name..'DropdownHolder']
                local DropList = DropdownHolder[Name..'DropList']
                local DropdownButton = DropdownHolder[Name..'DropdownButton']
                local DropdownIcon = DropdownHolder[Name..'DropdownIcon']
                local DropdownSelectedText = DropdownHolder[Name..'DropdownSelectedText']
                local DropListLayout = DropList[Name..'DropListLayout']
                local DropdownFiller = Section[Name..'DropdownFiller']

                DropdownButton.MouseButton1Click:Connect(function()
                    if not Debounce then
                        if Opened then
                            Opened = false
                            Utility:Tween(DropdownFiller, {Size = UDim2.new(0, 410, 0, 0)}, 0.25)
                            Utility:Tween(DropList, {Size = UDim2.new(0, 410, 0, 0)}, 0.25)
                            Utility:Tween(DropdownIcon, {Rotation = 270}, 0.25)
                            if #List <= 5 then
                                Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize - UDim2.new(0, 400, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                                Utility:Tween(Section, {Size = Section.Size - UDim2.new(0, 400, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                            else
                                Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize - UDim2.new(0, 400, 0, 150)}, 0.25)
                                Utility:Tween(Section, {Size = Section.Size - UDim2.new(0, 400, 0, 150)}, 0.25)
                            end
                            UpdateSectionSize()
                            UpdateTabSize()
                            Debounce = true
                            task.wait(DebounceAmount)
                            Debounce = false
                            DropList.Visible = false
                            DropdownFiller.Visible = false
                        else
                            Opened = true
                            DropdownFiller.Visible = true
                            DropList.Visible = true
                            if #List <= 5 then
                                Utility:Tween(DropList, {Size = UDim2.new(0, 410, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                                Utility:Tween(DropdownFiller, {Size = UDim2.new(0, 410, 0, DropListLayout.AbsoluteContentSize.Y - 6)}, 0.25)
                                Utility:Tween(DropList, {CanvasSize = UDim2.new(0, 400, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                                Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize + UDim2.new(0, 0, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                                Utility:Tween(Section, {Size = Section.Size + UDim2.new(0, 0, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                                UpdateSectionSize()
                                UpdateTabSize()
                            else
                                Utility:Tween(DropList, {Size = UDim2.new(0, 410, 0, 150)}, 0.25)
                                Utility:Tween(DropList, {CanvasSize = UDim2.new(0, 400, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                                Utility:Tween(DropdownFiller, {Size = UDim2.new(0, 410, 0, 144)}, 0.25)
                                Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize + UDim2.new(0, 0, 0, 150)}, 0.25)
                                Utility:Tween(Section, {Size = Section.Size + UDim2.new(0, 0, 0, 150)}, 0.25)
                                UpdateSectionSize()
                                UpdateTabSize()
                            end
                            Utility:Tween(DropdownIcon, {Rotation = 90}, 0.25)
                            Debounce = true
                            task.wait(DebounceAmount)
                            Debounce = false
                        end
                    end
                end)

                for _, Item in next, List do
                    Utility:Create('TextButton', {
                        Name = Item..'OptionButton',
                        Parent = DropList,
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, 410, 0, 30),
                        Font = Enum.Font.SourceSans,
                        TextColor3 = Color3.fromRGB(125, 125, 125),
                        TextSize = 16,
                        AutoButtonColor = false,
                        Text = Item,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }, {
                        Utility:Create('UIPadding', {
                            Name = Item..'OptionButtonPadding',
                            PaddingLeft = UDim.new(0, 7)
                        }),
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Item..'OptionButtonCorner'
                        })
                    })

                    local OptionButton = DropList[Item..'OptionButton']

                    OptionButton.MouseEnter:Connect(function()
                        Utility:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.5)
                    end)
    
                    OptionButton.MouseLeave:Connect(function()
                        Utility:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.5)
                    end)

                    OptionButton.MouseButton1Click:Connect(function()
                        for _, Button in next, DropList:GetChildren() do
                            if Button:IsA('TextButton') then
                                Utility:Tween(Button, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                            end
                        end
                        Utility:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.25)
                        DropdownSelectedText.Text = Item
                        Callback(Item)
                        task.wait(0.5)
                        Opened = false
                        if #List <= 5 then
                            Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize - UDim2.new(0, 0, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                            Utility:Tween(Section, {Size = Section.Size - UDim2.new(0, 0, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                        else
                            Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize - UDim2.new(0, 0, 0, 150)}, 0.25)
                            Utility:Tween(Section, {Size = Section.Size - UDim2.new(0, 0, 0, 150)}, 0.25)
                        end
                        Utility:Tween(DropdownFiller, {Size = UDim2.new(0, 410, 0, 0)}, 0.25)
                        Utility:Tween(DropList, {Size = UDim2.new(0, 410, 0, 0)}, 0.25)
                        Utility:Tween(DropdownIcon, {Rotation = 270}, 0.25)
                        task.wait(0.25)
                        UpdateSectionSize()
                        UpdateTabSize()
                        DropList.Visible = false
                        DropdownFiller.Visible = false
                    end)
                end

                DropdownHolder.MouseEnter:Connect(function()
                    Utility:Tween(DropdownHolder, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.5)
                end)

                DropdownHolder.MouseLeave:Connect(function()
                    Utility:Tween(DropdownHolder, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.5)
                end)

                function DropdownFunctions:UpdateDropdown(NewList)
                    local NewList = NewList or {}
                    for _, Item in next, DropList:GetChildren() do
                        if Item:IsA('TextButton') then
                            Item:Destroy()
                        end
                    end
                    List = NewList

                    for _, Item in next, NewList do
                        Utility:Create('TextButton', {
                            Name = Item..'OptionButton',
                            Parent = DropList,
                            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                            BorderSizePixel = 0,
                            Size = UDim2.new(0, 410, 0, 30),
                            Font = Enum.Font.SourceSans,
                            TextColor3 = Color3.fromRGB(125, 125, 125),
                            TextSize = 16,
                            AutoButtonColor = false,
                            Text = Item,
                            TextXAlignment = Enum.TextXAlignment.Left
                        }, {
                            Utility:Create('UIPadding', {
                                Name = Item..'OptionButtonPadding',
                                PaddingLeft = UDim.new(0, 7)
                            }),
                            Utility:Create('UICorner', {
                                CornerRadius = UDim.new(0, 5),
                                Name = Item..'OptionButtonCorner'
                            })
                        })

                        UpdateSectionSize()
                        UpdateTabSize()
    
                        local OptionButton = DropList[Item..'OptionButton']

                        OptionButton.MouseEnter:Connect(function()
                            Utility:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.5)
                        end)
        
                        OptionButton.MouseLeave:Connect(function()
                            Utility:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.5)
                        end)
    
                        OptionButton.MouseButton1Click:Connect(function()
                            for _, Button in next, DropList:GetChildren() do
                                if Button:IsA('TextButton') then
                                    Utility:Tween(Button, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.25)
                                end
                            end
                            Utility:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.25)
                            DropdownSelectedText.Text = Item
                            Callback(Item)
                            task.wait(0.5)
                            Opened = false
                            if #NewList <= 5 then
                                Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize - UDim2.new(0, 0, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                                Utility:Tween(Section, {Size = Section.Size - UDim2.new(0, 0, 0, DropListLayout.AbsoluteContentSize.Y)}, 0.25)
                            else
                                Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize - UDim2.new(0, 0, 0, 150)}, 0.25)
                                Utility:Tween(Section, {Size = Section.Size - UDim2.new(0, 0, 0, 150)}, 0.25)
                            end
                            Utility:Tween(DropdownFiller, {Size = UDim2.new(0, 410, 0, 0)}, 0.25)
                            Utility:Tween(DropList, {Size = UDim2.new(0, 410, 0, 0)}, 0.25)
                            Utility:Tween(DropdownIcon, {Rotation = 270}, 0.25)
                            task.wait(0.25)
                            UpdateSectionSize()
                            UpdateTabSize()
                            DropList.Visible = false
                            DropdownFiller.Visible = false
                        end)
                    end
                end
                return DropdownFunctions
            end

            function Elements:CreateColorpicker(Name, DebounceAmount, Callback)
                local Name = Name or 'Colorpicker'
                local Callback = Callback or function() end
                local DebounceAmount = DebounceAmount or 0.25
                local Debounce = false
                local Opened = false

                Utility:Create('Frame', {
                    Name = Name..'ColorpickerHolder',
                    Parent = Section,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                    Size = UDim2.new(0, 410, 0, 40)
                }, {
                    Utility:Create('UICorner', {
                        CornerRadius = UDim.new(0, 5),
                        Name = Name..'ColorpickerHolderCorner'
                    }),
                    Utility:Create('UIStroke', {
                        Name = Name..'ColorpickerHolderStroke',
                        ApplyStrokeMode = 'Contextual',
                        Color = Color3.fromRGB(60, 60, 60),
                        LineJoinMode = 'Round',
                        Thickness = 1
                    }),
                    Utility:Create('TextLabel', {
                        Name = Name..'ColorpickerText',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 5),
                        Size = UDim2.new(0, 200, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = Name,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }, {
                        Utility:Create('UIPadding', {
                            Name = Name..'ColorpickerTextPadding',
                            PaddingLeft = UDim.new(0, 7)
                        })
                    }),
                    Utility:Create('TextButton', {
                        Name = Name..'ColorpickerButton',
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 410, 0, 40),
                        ZIndex = 2,
                        Font = Enum.Font.Gotham,
                        Text = '',
                        TextColor3 = Color3.fromRGB(175, 175, 175),
                        TextSize = 14
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'ColorpickerButtonCorner'
                        })
                    }),
                    Utility:Create('Frame', {
                        Name = Name..'ColorpickerDropdown',
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, 40),
                        Size = UDim2.new(0, 410, 0, 114),
                        Visible = false
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'ColorpickerDropdownCorner'
                        }),
                        Utility:Create('UIStroke', {
                            Name = Name..'ColorpickerDropdownStroke',
                            ApplyStrokeMode = 'Contextual',
                            Color = Color3.fromRGB(60, 60, 60),
                            LineJoinMode = 'Round',
                            Thickness = 1
                        }),
                        Utility:Create('ImageButton', {
                            Name = Name..'RGBPicker',
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            Position = UDim2.new(0, 38, 0, 7),
                            Size = UDim2.new(0, 300, 0, 100),
                            Image = 'rbxassetid://6523286724'
                        }, {
                            Utility:Create('UICorner', {
                                CornerRadius = UDim.new(0, 5),
                                Name = Name..'RGBPickerCorner'
                            }),
                            Utility:Create('ImageLabel', {
                                Name = Name..'RGBPickerCircle',
                                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0, 293, 0, -7),
                                Size = UDim2.new(0, 14, 0, 14),
                                Image = 'rbxassetid://3926309567',
                                ImageColor3 = Color3.fromRGB(0, 0, 0),
                                ImageRectOffset = Vector2.new(628, 420),
                                ImageRectSize = Vector2.new(48, 48)
                            }),
                            Utility:Create('UIStroke', {
                                Name = Name..'RGBPickerStroke',
                                ApplyStrokeMode = 'Contextual',
                                Color = Color3.fromRGB(60, 60, 60),
                                LineJoinMode = 'Round',
                                Thickness = 1
                            }),
                        }),
                        Utility:Create('ImageButton', {
                            Name = Name..'DarknessPicker',
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            Position = UDim2.new(0, 346, 0, 7),
                            Size = UDim2.new(0, 25, 0, 100),
                            Image = 'rbxassetid://6523291212'
                        }, {
                            Utility:Create('UICorner', {
                                CornerRadius = UDim.new(0, 5),
                                Name = Name..'DarknessPickerCorner'
                            }),
                            Utility:Create('ImageLabel', {
                                Name = Name..'DarknessPickerCircle',
                                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                                BackgroundTransparency = 1,
                                AnchorPoint = Vector2.new(0.5, 0),
                                Position = UDim2.new(0.5, 0, 0, -6),
                                Size = UDim2.new(0, 14, 0, 14),
                                Image = 'rbxassetid://3926309567',
                                ImageColor3 = Color3.fromRGB(0, 0, 0),
                                ImageRectOffset = Vector2.new(628, 420),
                                ImageRectSize = Vector2.new(48, 48)
                            }),
                            Utility:Create('UIStroke', {
                                Name = Name..'DarknessPickerStroke',
                                ApplyStrokeMode = 'Contextual',
                                Color = Color3.fromRGB(60, 60, 60),
                                LineJoinMode = 'Round',
                                Thickness = 1
                            }),
                        })
                    }),
                    Utility:Create('Frame', {
                        Name = Name..'ColorpickerPreview',
                        BackgroundColor3 = Color3.fromRGB(0, 125, 255),
                        Position = UDim2.new(0, 377, 0, 8),
                        Size = UDim2.new(0, 25, 0, 25)
                    }, {
                        Utility:Create('UICorner', {
                            CornerRadius = UDim.new(0, 5),
                            Name = Name..'ColorpickerPreviewCorner'
                        })
                    })
                })
                Utility:Create('Frame', {
                    Name = Name..'ColorpickerFiller',
                    Parent = Section,
                    Visible = false,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 410, 0, 0)
                })

                local ColorpickerHolder = Section[Name..'ColorpickerHolder']
                local ColorpickerButton = ColorpickerHolder[Name..'ColorpickerButton']
                local ColorpickerDropdown = ColorpickerHolder[Name..'ColorpickerDropdown']
                local RGBPicker = ColorpickerDropdown[Name..'RGBPicker']
                local RGBPickerCircle = RGBPicker[Name..'RGBPickerCircle']
                local DarknessPicker = ColorpickerDropdown[Name..'DarknessPicker']
                local DarknessPickerCircle = DarknessPicker[Name..'DarknessPickerCircle']
                local ColorpickerPreview = ColorpickerHolder[Name..'ColorpickerPreview']
                local ColorpickerFiller = Section[Name..'ColorpickerFiller']

                ColorpickerButton.MouseButton1Click:Connect(function()
                    if not Debounce then
                        if Opened then
                            Opened = false
                            Utility:Tween(ColorpickerFiller, {Size = UDim2.new(0, 410, 0, 0)}, 0.25)
                            Utility:Tween(RGBPicker, {Size = UDim2.new(0, 300, 0, 0)}, 0.25)
                            Utility:Tween(DarknessPicker, {Size = UDim2.new(0, 25, 0, 0)}, 0.25)
                            Utility:Tween(ColorpickerDropdown, {Size = UDim2.new(0, 410, 0, 0)}, 0.25)
                            Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize - UDim2.new(0, 0, 0, 114)}, 0.25)
                            Utility:Tween(Section, {Size = Section.Size - UDim2.new(0, 0, 0, 114)}, 0.25)
                            UpdateSectionSize()
                            UpdateTabSize()
                            Debounce = true
                            task.wait(DebounceAmount)
                            Debounce = false
                            ColorpickerDropdown.Visible = false
                            ColorpickerFiller.Visible = false
                        else
                            Opened = true
                            ColorpickerFiller.Visible = true
                            ColorpickerDropdown.Visible = true
                            Utility:Tween(Tab, {CanvasSize = Tab.CanvasSize + UDim2.new(0, 0, 0, 114)}, 0.25)
                            Utility:Tween(Section, {Size = Section.Size + UDim2.new(0, 0, 0, 114)}, 0.25)
                            Utility:Tween(ColorpickerDropdown, {Size = UDim2.new(0, 410, 0, 114)}, 0.25)
                            Utility:Tween(RGBPicker, {Size = UDim2.new(0, 300, 0, 100)}, 0.25)
                            Utility:Tween(DarknessPicker, {Size = UDim2.new(0, 25, 0, 100)}, 0.25)
                            Utility:Tween(DropdownFiller, {Size = UDim2.new(0, 410, 0, 110)}, 0.25)
                            UpdateSectionSize()
                            UpdateTabSize()
                            Debounce = true
                            task.wait(DebounceAmount)
                            Debounce = false
                        end
                    end
                end)

                ColorpickerHolder.MouseEnter:Connect(function()
                    Utility:Tween(ColorpickerHolder, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.5)
                end)

                ColorpickerHolder.MouseLeave:Connect(function()
                    Utility:Tween(ColorpickerHolder, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.5)
                end)

                local Mouse = Players.LocalPlayer:GetMouse()
                local Color = {1, 1, 1}
                local RGBPicked = false
                local DarknessPicked = false

                -- // Based off xHeptc's functions | https://v3rmillion.net/member.php?action=profile&uid=1347047
                Mouse.Move:Connect(function()
                    if RGBPicked then
                        local MouseXPosition = Mouse.X - RGBPicker.AbsolutePosition.X
                        local MouseYPosition = Mouse.Y - RGBPicker.AbsolutePosition.Y

                        local CircleXPosition = RGBPickerCircle.AbsoluteSize.X / 2
                        local CircleYPosition = RGBPickerCircle.AbsoluteSize.Y / 2

                        local MaximumXPosition = RGBPicker.AbsoluteSize.X
                        local MaximumYPosition = RGBPicker.AbsoluteSize.Y

                        if MouseXPosition < 0 then MouseXPosition = 0 end
                        if MouseYPosition < 0 then MouseYPosition = 0 end

                        if MouseXPosition > MaximumXPosition then MouseXPosition = MaximumXPosition end
                        if MouseYPosition > MaximumYPosition then MouseYPosition = MaximumYPosition end

                        MouseXPosition = MouseXPosition / MaximumXPosition
                        MouseYPosition = MouseYPosition / MaximumYPosition

                        RGBPickerCircle.Position = UDim2.new(MouseXPosition, -CircleXPosition, MouseYPosition, -CircleYPosition)

                        Color = {1 - MouseXPosition, 1 - MouseYPosition, Color[3]}

                        local HSVColor = Color3.fromHSV(Color[1], Color[2], Color[3])

                        ColorpickerPreview.BackgroundColor3 = HSVColor

                        Callback(HSVColor)
                    
                    elseif DarknessPicked then
                        local MouseYPosition = Mouse.Y - DarknessPicker.AbsolutePosition.Y

                        local CircleYPosition = DarknessPickerCircle.AbsoluteSize.Y / 2

                        local MaximumYPosition = DarknessPicker.AbsoluteSize.Y

                        if MouseYPosition < 0 then MouseYPosition = 0 end
                        if MouseYPosition > MaximumYPosition then MouseYPosition = MaximumYPosition end

                        MouseYPosition = MouseYPosition / MaximumYPosition

                        DarknessPickerCircle.Position = UDim2.new(0.5, 0, MouseYPosition, -CircleYPosition)

                        DarknessPickerCircle.ImageColor3 = Color3.fromHSV(0, 0, MouseYPosition)

                        Color = {Color[1], Color[2], 1 - MouseYPosition}

                        local HSVColor = Color3.fromHSV(Color[1], Color[2], Color[3])

                        ColorpickerPreview.BackgroundColor3 = HSVColor

                        Callback(HSVColor)
                    end 
                end)

                UserInputService.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if DarknessPicked then 
                            DarknessPicked = false 
                        elseif RGBPicked then
                            RGBPicked = false
                        end
                    end
                end)
                -- // End

                RGBPicker.MouseButton1Down:Connect(function()
                    RGBPicked = true
                end)

                DarknessPicker.MouseButton1Down:Connect(function()
                    DarknessPicked = true
                end)
            end
            return Elements
        end
        return Sections
    end
    return Tabs
end
return Library
