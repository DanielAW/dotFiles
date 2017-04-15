---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
---------------------------------------------------

-- {{{ Grab environment
local tonumber = tonumber
local math = { ceil = math.ceil }
local setmetatable = setmetatable
local helpers = require("vicious.helpers")
local io = {
    open  = io.open,
    popen = io.popen
}
local string = {
    find  = string.find,
    match = string.match
}
-- }}}

-- iw dev wlp3s0 link

-- Wifi: provides wireless information for a requested interface
-- vicious.widgets.wifi
local wifi_all = {}


-- {{{ Variable definitions
local iw = "iw"
local iwcpaths = { "/sbin", "/usr/sbin", "/usr/local/sbin", "/usr/bin" }
-- }}}


-- {{{ Wireless widget type
local function worker(format, warg)
    if not warg then return end

    -- Default values
    local winfo = {
        ["{ssid}"] = "N/A",
        ["{rate}"] = 0,
        ["{chan}"] = 0,
        ["{dbm}"] = 0,
    }

    -- Get data from iwconfig where available
    local f = io.popen(iw .." dev ".. warg .. " link 2>&1")
    local iw = f:read("*all")
    f:close()

    -- iwconfig wasn't found, isn't executable, or non-wireless interface
    if iw == nil or string.find(iw, "No such device") then
        return winfo
    end

    -- Output differs from system to system, some stats can be
    -- separated by =, and not all drivers report all stats
    winfo["{ssid}"] =  -- SSID can have almost anything in it
      helpers.escape(string.match(iw, "SSID[=:][%s]?([A-Za-z0-9\t .-]+)") or winfo["{ssid}"])
    winfo["{chan}"] =  -- Channels are plain digits
      tonumber(string.match(iw, "freq[=:][%s]?([%d]+)") or winfo["{chan}"])
    winfo["{rate}"] =  -- Bitrate can start with a space, we don't want to display Mb/s
      tonumber(string.match(iw, "tx bitrate[=:]([%s]?[%d%.]*)") or winfo["{rate}"])

    winfo["{dbm}"] =  -- Link quality can contain a slash (32/70), match only the first number
      tonumber(string.match(iw, "signal[=:][%s]?([%-]?[%d]+)") or winfo["{dbm}"])
    
    --winfo["{sign}"] =  -- Signal level can be a negative value, don't display decibel notation
      --tonumber(string.match(iw, "Signal level[=:]([%-]?[%d]+)") or winfo["{sign}"])

    -- Link quality percentage if quality was available
    --if winfo["{link}"] ~= 0 then winfo["{linp}"] = math.ceil(winfo["{link}"] / 0.7) end

    return winfo
end
-- }}}

return setmetatable(wifi_all, { __call = function(_, ...) return worker(...) end })
