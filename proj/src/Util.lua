 local Util = {}

 function Util.tprint (tbl, indent)
    if not indent then indent = 0 end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2 
    for k, v in pairs(tbl) do
      toprint = toprint .. string.rep(" ", indent)
      if (type(k) == "number") then
        toprint = toprint .. "[" .. k .. "] = "
      elseif (type(k) == "string") then
        toprint = toprint  .. k ..  "= "   
      end
      if (type(v) == "number") then
        toprint = toprint .. v .. ",\r\n"
      elseif (type(v) == "string") then
        toprint = toprint .. "\"" .. v .. "\",\r\n"
      elseif (type(v) == "table") then
        toprint = toprint .. Util.tprint(v, indent + 2) .. ",\r\n"
      else
        toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
      end
    end
    toprint = toprint .. string.rep(" ", indent-2) .. "}"
    print(toprint) 
  end

function Util.tableToString(tab) 
    local str = ""
    for _, v in pairs(tab) do
        if(type(v) == "string") then
            str = str..v
        else
            warn("Table contains non string value")
            return
        end
    end
    return str
  end

  function Util.disp_time(time)
    local days = math.floor(time/86400)
    local hours = math.floor((time % 86400)/3600)
    local minutes = math.floor((time % 3600)/60)
    local seconds = math.floor((time % 60))
    return string.format("%d days %02d hours %02d minutes %02d seconds",days,hours,minutes,seconds)
  end

  function Util.file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
  end

  function Util.lines_from(file)
    if not Util.file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
  end

  return Util