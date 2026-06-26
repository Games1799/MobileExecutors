local UseNewCclosure = true -- true / false
local CreateCFunction = true -- true / false
local CreateAliases = true -- true / false 

local newcclosure = newcclosure or new_c_closure or function(a) return a end
local newcclosure2 = newcclosure

if UseNewCclosure == false then
   newcclosure = function(a) 
      return a
   end
end

if newcclosure2 == false then
   newcclosure2 = function(a) 
      return a
   end
end

getgenv().hookmetamethod = newcclosure2(function(table, method, func)
   local mt = getrawmetatable(table)
   setreadonly(mt, false)
   if method == "__namecall" then
      local old = mt.__namecall
      mt.__namecall = newcclosure(function(self, ...)
         return func(self, ...)
      end)
      return old
   elseif method == "__index" then
      local old = mt.__index
      mt.__index = newcclosure(function(self, key, ...)
         return func(self, key, ...)
      end)
      return old
   elseif method == "__newindex" then
      local old = mt.__newindex
      mt.__newindex = newcclosure(function(self, key, value, ...)
         return func(self, key, value, ...)
      end)
      return old
   elseif method == "__tostring" then
      local old = mt.__tostring 
      mt.__tostring = newcclosure(function(self, ...)
         return func(self, ...)
      end)
      return old
   elseif method == "__add" then
      local old = mt.__add
      mt.__add = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__sub" then
      local old = mt.__sub
      mt.__sub = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__mul" then
      local old = mt.__mul
      mt.__mul = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__div" then
      local old = mt.__div
      mt.__div = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__idiv" then
      local old = mt.__idiv
      mt.__idiv = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__mod" then
      local old = mt.__mod
      mt.__mod = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__pow" then
      local old = mt.__pow
      mt.__pow = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__unm" then
      local old = mt.__unm
      mt.__unm = newcclosure(function(a, ...)
         return func(a, ...)
      end)
      return old
   elseif method == "__concat" then
      local old = mt.__concat
      mt.__concat = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__len" then
      local old = mt.__len
      mt.__len = newcclosure(function(a, ...)
         return func(a, ...)
      end)
      return old
   elseif method == "__eq" then
      local old = mt.__eq
      mt.__eq = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__lt" then
      local old = mt.__lt
      mt.__lt = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__le" then
      local old = mt.__le
      mt.__le = newcclosure(function(a, b, ...)
         return func(a, b, ...)
      end)
      return old
   elseif method == "__call" then
      local old = mt.__call
      mt.__call = newcclosure(function(...)
         return func(...)
      end)
      return old
   elseif method == "__iter" then
      local old = mt.__iter
      mt.__iter = newcclosure(function(a, ...)
         return func(a, ...)
      end)
      return old
   end
end)

if CreateAliases == true then
   getgenv().hook_meta_method = getgenv().hookmetamethod
   getgenv().HookMetaMethod = getgenv().hookmetamethod
   getgenv().Hook_Meta_Method = getgenv().hookmetamethod
end
