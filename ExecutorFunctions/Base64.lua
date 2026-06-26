local CreateCFunction = true -- true / false
local CreateAliasesForEncode = true -- true / false
local CreateAliasesForDecode = true -- true / false

local newcclosure = newcclosure or new_c_closure or function(a) return a end

if CreateCFunction == false then
   newcclosure = function(a) 
      return a
   end
end

local All = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local Check = {}

getgenv().base64encode = newcclosure(function(Strings)
   local Out = {}
   for i = 1, #Strings, 3 do
      local a = Strings:byte(i) or 0
      local b = Strings:byte(i + 1) or 0
      local c = Strings:byte(i + 2) or 0
      local d = (a << 16) | (b << 8) | c
      Out[#Out + 1] = All:sub(((d >> 18) & 63) + 1, ((d >> 18) & 63) + 1)
      Out[#Out + 1] = All:sub(((d >> 12) & 63) + 1, ((d >> 12) & 63) + 1)
      Out[#Out + 1] = All:sub(((d >> 6) & 63) + 1, ((d >> 6) & 63) + 1)
      Out[#Out + 1] = All:sub((d & 63) + 1, (d & 63) + 1)
   end
   local Idk = #Strings % 3
   if Idk == 1 then
      Out[#Out] = "="
      Out[#Out - 1] = "="
   elseif Idk == 2 then
      Out[#Out] = "="
   end
   return table.concat(Out)
end)

for i = 1, #All do
  Check[All:sub(i, i)] = i - 1
end 

getgenv().base64decode = newcclosure(function(Strings)
   Strings = Strings:gsub("%s", "")
   local Out = {}
   for i = 1, #Strings, 4 do
      local a = Check[Strings:sub(i, i)] or 0
      local b = Check[Strings:sub(i + 1, i + 1)] or 0
      local c = Check[Strings:sub(i + 2, i + 2)] or 0
      local d = Check[Strings:sub(i + 3, i + 3)] or 0
      local f = (a << 18) | (b << 12) | (c << 6) | d
      Out[#Out + 1]  = string.char((f >> 16) & 255)
      
      if Strings:sub(i + 2, i + 2) ~= "=" then
       Out[#Out + 1] = string.char((f >> 8) & 255)
      end
      if Strings:sub(i + 3, i + 3) ~= "=" then
       Out[#Out + 1] = string.char(f & 255)
      end
   end
   return table.concat(Out)
end)

if CreateAliasesForEncode == true then
   if not getgenv().base64 then
      getgenv().base64 = {}
   end
   if not getgenv().crypt then
      getgenv().crypt = {}
   end
   getgenv().base64.encode = getgenv().base64encode
   getgenv().base64_encode = getgenv().base64encode
   getgenv().crypt.base64.encode = getgenv().base64encode
   getgenv().crypt.base64_encode = getgenv().base64encode
   getgenv().crypt.base64encode = getgenv().base64encode
end

if CreateAliasesForDecode == true then
   if not getgenv().base64 then
      getgenv().base64 = {}
   end
   if not getgenv().crypt then
      getgenv().crypt = {}
   end
   getgenv().base64.decode = getgenv().base64decode 
   getgenv().base64_decode = getgenv().base64decode 
   getgenv().crypt.base64.decode = getgenv().base64decode 
   getgenv().crypt.base64_decode = getgenv().base64decode 
   getgenv().crypt.base64decode = getgenv().base64decode 
end

