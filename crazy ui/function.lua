local Function = {Signals = {}} do

    function Function:AddSignal(a, b, c, d, e, f)
        table.insert(Function.Signals, {a, b, c, d, e, f})
    end

    function Function:HexColor(q, t)
        local int = math.floor(q.r*255)*256^2+math.floor(q.g*255)*256+math.floor(q.b*255)
        local current = int
        local final = ""
        local hexChar = {"a", "b", "c", "d", "e", "f"}

        repeat local remainder = current % 16
            local char = tostring(remainder)
            if remainder >= 10 then
                char = hexChar[1 + remainder - 10]
            end

            current = math.floor(current/16)
            final = final..char
        until current <= 0

        return (t or "#") .. string.reverse(final)
    end

    function Function:RoundNumber(q)
        local DigitsInNumber = math.max(math.ceil(math.log10(q+1)),1)
        local FormattedNumber
        local NotationToUse
        local TableOfLetters = {"", "K", "M", "B", "T"}

        local NumberOfDigitsToShow = 1.5*(DigitsInNumber%3)^2 - 3.5*(DigitsInNumber%3) + 5
        FormattedNumber = string.sub(tostring(q/10^(DigitsInNumber-1)),1,NumberOfDigitsToShow)
        local FinalNumber = string.sub(FormattedNumber*(10^((DigitsInNumber-1)%3)),1,NumberOfDigitsToShow)

        if DigitsInNumber == 3 then
            FinalNumber = tostring(math.ceil(tonumber(FinalNumber)))
        end

        NotationToUse = FinalNumber..TableOfLetters[math.ceil(DigitsInNumber/3)]

        return NotationToUse
    end

    function Function:StringToNum(q)
        local TableOfValues = {"k","m","b"}
        local Number = 1
        for i,v in pairs(TableOfValues) do
            q = string.gsub(q,v,function()
                Number = Number * (10 ^ (i * 3))
                return ""
            end)
        end
        return Number * q
    end

    function Function:RaidUpdate()
        local q =
        {
            "Divine Guardian Raid",
            "Blue Devil Raid",
            "Psycho Student Raid",
            "Buff Boy Raid",
            "Warlord Raid",
            "King of Curses Raid",
            "Black Pasta Raid",
            "Cosmic Wolfman Raid",
            "Joto Raid",
            "Matsuri Raid",
            "Tonjuro Sun God Raid",
            "Vio Raid",
            "Demon Lord Raid",
            "Ichini Fullbring Raid",
            "Roku Ultra Instinct Raid",
            "Chainsaw Raid",
            "Nardo Beast Raid",
            "Cursed Sage Raid",
            "Red Emperor Raid",
            "Tengu Raid",
            "Yomichi Raid",
            "Christmas Raid",
            "Infinity Nojo Raid",
            "Combat Titan Raid",
            "Esper Raid",
            "Gear 5 Fluffy Raid",
            "Tengoku Raid",
            "Hirito Raid",
            "Titan Raid"
        }
        return q
    end

    function Function:TextG(t, x)
        if string.find(t, x) then
            local g = t:gsub(x, "")
            return g
        else
            return t
        end
    end

    function Function:SetNoclip(a)
        for o, x in ipairs(game:GetService"Players".LocalPlayer.Character:GetChildren()) do
            if x:IsA("BasePart") and x.CanCollide ~= a then
                x.CanCollide = a
            end
        end
    end

    function Function:ObjectGet(a)
        local dist, thing = math.huge, false
        for o, x in ipairs(a:GetChildren()) do
            if x:IsA("Part") or x:IsA("MeshPart") then
                local g = (game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.Position - x.Position).magnitude
                if g < dist then
                    dist = g
                    thing = x
                end
            end
        end
        return thing
    end

    function Function:Character()
        return
        {
            {["n"] = "`Character [Sakura]`", ["i"] = "rbxassetid://13406949044"},
            {["n"] = "`Character [Natsu]`", ["i"] = "rbxassetid://12992685998"},
            {["n"] = "`Character [Killua]`", ["i"] = "rbxassetid://7037255754"},
            {["n"] = "`Character [Asta]`", ["i"] = "rbxassetid://7053221313"},
            {["n"] = "`Character [Itadori]`", ["i"] = "rbxassetid://16629613718"},
            {["n"] = "`Character [Akaza]`", ["i"] = "rbxassetid://12992687663"},
            {["n"] = "`Character [Sasuke]`", ["i"] = "rbxassetid://13621197278"},
            {["n"] = "`Character [Gray]`", ["i"] = "rbxassetid://7057569994"},
            {["n"] = "`Character [Sukuna]`", ["i"] = "rbxassetid://16629618004"},
            {["n"] = "`Character [Rukai]`", ["i"] = "rbxassetid://7132704621"},
            {["n"] = "`Character [Shinra]`", ["i"] = "rbxassetid://13621200238"},
            {["n"] = "`Character [All Might]`", ["i"] = "rbxassetid://15699330111"},
            {["n"] = "`Character [Zoro]`", ["i"] = "rbxassetid://16834106549"},
            {["n"] = "`Character [Asuna]`", ["i"] = "rbxassetid://13621194902"},
            {["n"] = "`Character [Emiya Archer]`", ["i"] = "rbxassetid://7542006362"},
            {["n"] = "`Character [Kaneki]`", ["i"] = "rbxassetid://7785010433"},
            {["n"] = "`Character [Lancer]`", ["i"] = "rbxassetid://8270023417"},
            {["n"] = "`Character [Saber Alter]`", ["i"] = "rbxassetid://9038000341"},
            {["n"] = "`Character [Diablo]`", ["i"] = "rbxassetid://9672496119"},
            {["n"] = "`Character [Rimuru]`", ["i"] = "rbxassetid://13406949528"},
            {["n"] = "`Character [Power]`", ["i"] = "rbxassetid://16834116921"},
            {["n"] = "`Character [Yamato]`", ["i"] = "rbxassetid://17096447919"},
            {["n"] = "`Character [Sonic]`", ["i"] = "rbxassetid://16620398317"},
            {["n"] = "`Character [Rank ??? Hunter]`", ["i"] = "rbxassetid://16745228465"},
            {["n"] = "`Character [Broly]`", ["i"] = "rbxassetid://16832873774"},
            {["n"] = "`Character [Alice]`", ["i"] = "rbxassetid://7401067364"},
            {["n"] = "`Character [Gilgamesh]`", ["i"] = "rbxassetid://7386538151"},
            {["n"] = "`Character [Kokushibo]`", ["i"] = "rbxassetid://7384650558"},
            {["n"] = "`Character [RinOkumura]`", ["i"] = "rbxassetid://17524638400"},
            {["n"] = "`Character [Mob]`", ["i"] = "rbxassetid://17257820522"},
            {["n"] = "`Character [Mash]`", ["i"] = "rbxassetid://16913579571"},
            {["n"] = "`Character [Mihawk]`", ["i"] = "rbxassetid://16833352600"},
            {["n"] = "`Character [SukunaShibuya]`", ["i"] = "rbxassetid://16629617713"},
            {["n"] = "`Character [Asta (Black Asta)]`", ["i"] = "rbxassetid://14785556998"},
            {["n"] = "`Character [Cosmic Garou]`", ["i"] = "rbxassetid://13736210016"},
            {["n"] = "`Character [Jotaro]`", ["i"] = "rbxassetid://14295913088"},
            {["n"] = "`Character [Tanjiro (Sun God)]`", ["i"] = "rbxassetid://12548891547"},
            {["n"] = "`Character [Mitsuri]`", ["i"] = "rbxassetid://13294872244"},
            {["n"] = "`Character [Dio]`", ["i"] = "rbxassetid://12275838772"},
            {["n"] = "`Character [RimuruDemonLord]`", ["i"] = "rbxassetid://8827725106"},
            {["n"] = "`Character [Ichigo (Fullbring Bankai)]`", ["i"] = "rbxassetid://12087483204"},
            {["n"] = "`Character [Goku UI]`", ["i"] = "rbxassetid://16833324796"},
            {["n"] = "`Character [Denji]`", ["i"] = "rbxassetid://16832872564"},
            {["n"] = "`Character [Naruto (Kurama Mode)]`", ["i"] = "rbxassetid://10835672920"},
            {["n"] = "`Character [Obito]`", ["i"] = "rbxassetid://10688580603"},
            {["n"] = "`Character [Shanks]`", ["i"] = "rbxassetid://16834112408"},
            {["n"] = "`Character [Yoriichi]`", ["i"] = "rbxassetid://8466801602"},
            {["n"] = "`Character [Uzui]`", ["i"] = "rbxassetid://10182602891"},
            {["n"] = "`Character [Ice Queen Esdeath]`", ["i"] = "rbxassetid://16802362266"},
            {["n"] = "`Character [Infinity Gojo]`", ["i"] = "rbxassetid://16629613889"},
            {["n"] = "`Character [Attack Titan]`", ["i"] = "rbxassetid://16832874929"},
            {["n"] = "`Character [Accelerator]`", ["i"] = "rbxassetid://9432939692"},
            {["n"] = "`Character [Gear 5 Luffy]`", ["i"] = "rbxassetid://17076062883"},
            {["n"] = "`Character [Rengoku]`", ["i"] = "rbxassetid://7210567835"},
            {["n"] = "`Character [Kirito]`", ["i"] = "rbxassetid://13621198974"},
            {["n"] = "`Character [Levi]`", ["i"] = "rbxassetid://16833356947"}
        }
    end

end

return Function


