-- printAllVariables_test.lua
-- unit test

require 'makeVp'
require 'printAllVariables'

local vp, verboseLevel = makeVp(0, 'tester')

local function f()
   local v123 = 123
   local vabc = 'abc'
   local vTable = {key1 = 'one', key2 = 'abc'}
   local function g(i) end

   if verboseLevel > 0 then
      printAllVariables()
   end
end

f()

print('ok printAllVariables')
