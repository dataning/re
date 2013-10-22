-- TableCached.lua
-- A lua table that can be written to a CSV file and read back in

require 'fileAssureExists'
require 'makeVp'

-- API overview
if false then
   tc = TableCached('path/to/file')  -- create file if necessary

   -- storing and fetching keys and values from the cache
   tc:store(123, {'abc', true})  -- key, value
   tc:store('x', 45.6)

   seq = tc:fetch(123) -- seq == {'abc', true}
   x = tc:fetch('x')   -- seq == 45.6

   -- iterating over elements
   for k, v in tc:pairs() do 
      print(k) print(v) 
   end

   -- reading and writing to associated disk file 
   -- in binary serialization format
   tc:writeToFile()
   tc:replaceWithFile()   

   -- empty the table
   tc:reset()
end

-- construction
local TableCached = torch.class('TableCached')

function TableCached:__init(filePath)
   local vp = makeVp(0, 'TableCached:__init')
   vp(1, 'filePath', filePath)
   validateAttributes(filePath, 'string')

   -- make sure that file is accessible
   fileAssureExists(filePath)

   -- initialize instance variables
   self.filePath = filePath
   self.table = {}
end

-- fetch
function TableCached:fetch(key)
   return self.table[key]
end

-- pairs
function TableCached:pairs()
   return pairs(self.table)
end

-- replaceWithFile
function TableCached:replaceWithFile()
   self.table = torch.load(self.filePath, 'ascii')
end

-- reset
function TableCached:reset()
   self.table = {}
end

-- store
function TableCached:store(key, value)
   self.table[key] = value
end

-- writeToFile
function TableCached:writeToFile()
   torch.save(self.filePath, self.table, 'ascii')  -- write in platform independent way
end

