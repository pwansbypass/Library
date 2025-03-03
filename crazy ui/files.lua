local Folders = {} do
    function Folders:MakeFolder(folder)
        if not isfolder((folder or "CrazyDay")) then
            repeat
                makefolder((folder or "CrazyDay"))
                wait()
            until isfolder((folder or "CrazyDay"))
        end
    end
    function Folders:CheckFiles(file, val)
        if not file then return end
        if not isfile(file) then
            repeat
                writefile(file, val)
                wait()
            until isfile(file)
        end
    end
    function Folders:DeleteFolder(folder)
        if isfolder((folder or "CrazyDay")) then
            repeat
                delfolder((folder or "CrazyDay"))
                wait()
            until not isfolder((folder or "CrazyDay"))
        end
    end
    function Folders:DeleteFile(file)
        if isfile(file) then
            repeat
                delfile(file)
                wait()
            until not isfile(file)
        end
    end
    function Folders:ListFiles(path, str)
        local TablesOfFiles = {}
        local Name
        if not path then return end
        for i,v in ipairs(listfiles(path)) do
            if v:match([[/]]) or v.find(v,[[/]]) then
                Name = v:gsub([[/]],"")
                if Name and (Name:match([[\]]) or Name.find(Name,[[\]])) then
                    Name = Name:gsub([[\]],"")
                end
            elseif v:match([[\]]) or v.find(v,[[\]]) then
                Name = v:gsub([[\]],"")
            end
            if Name and Name.find(Name,".lua") then Name = Name:gsub(".lua","") elseif Name and Name.find(Name,".json") then Name = Name:gsub(".json", "") end
            if str and Name and Name.find(Name,str) then Name = Name:gsub(str,"") end
            table.insert(TablesOfFiles, Name or v)
        end
        return TablesOfFiles
    end
end
return Folders
