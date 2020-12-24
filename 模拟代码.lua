groupTable = {}
hangarTable = {}
for key, value in pairs(VP_GetSide({name = "BLUE"}).units) do
    detail = ScenEdit_GetUnit({guid = value.guid})
    if detail.group ~= nil then
      if (string.find(detail.name, "Hardened")) then
        if (groupTable[detail.group.name] == nil) then
          groupTable[detail.group.name] = {[detail.guid] = detail.name}
        else 
          groupTable[detail.group.name][detail.guid] = detail.name
        end
        groupTable[detail.group.name] = detail.group.guid
        hangarTable = {detail}
      end
    end
end
    
  --if (string.find(value.name, "Hardened")) then
  --hangarTable[value.guid] = value.name
    --end
print(groupTable)


AC = 140
while (AC>0) do
    for key, value in pairs(VP_GetSide({name = "BLUE"}).units) do

        detail = ScenEdit_GetUnit({guid = value.guid})
        if (string.find(detail.name, "Hardened")) then
        ScenEdit_AddUnit({type = "Aircraft", name = AC, side = detail.side, dbid = 3962, base = detail.guid, loadoutid = 22783})
        --print(detail.name)
        AC = AC - 1
        if AC == 0 then break end
        end
    end
end

print(AC)

print(ScenEdit_GetUnit({name='F-16A Blk 20 Falcon [F-16V]', guid='IHXSIQ-0HM57UCV9EL66'}).dbid)
print(ScenEdit_GetUnit({name='F-16A Blk 20 Falcon [F-16V]', guid='IHXSIQ-0HM57UCV9EL66'}).loadoutdbid)


