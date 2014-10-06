---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2014, Daniel Wegemer <daniel@wegemer.com>
---------------------------------------------------

-- {{{ Grab environment
local io = { popen = io.popen }
local setmetatable = setmetatable
local table = { insert = table.insert }
local helpers = require("vicious.helpers")
-- }}}

local function build_array(...)
  local arr = {}
  for v in ... do
    arr[#arr + 1] = v
  end
  return arr
end


local ac = {}

-- {{{ AC widget type
local function worker(format, warg)
	local acpi = helpers.pathtotable("/proc/acpi")
	local state = acpi.bbswitch
	local ret = {}
	ret = build_array(string.gmatch(state, "[^%s]+")) 
	if state == nil then
		return {"N/A"}
	else
		return {ret[2]}
	end
end
-- }}}

return setmetatable(ac, { __call = function(_, ...) return worker(...) end })
