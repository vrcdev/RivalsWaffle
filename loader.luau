local BASE = "https://raw.githubusercontent.com/vrcdev/RivalsWaffle/main/"
local function fetch(path)
	local ok, res = pcall(function() return game:HttpGet(BASE .. path) end)
	if ok and type(res) == "string" and #res > 100 then return res end
	if type(res) == "userdata" and res ~= nil then
		local ok2, s = pcall(function() return tostring(res) end)
		if ok2 and #s > 100 then return s end
	end
	if httpget then
		local ok3, res3 = pcall(httpget, BASE .. path)
		if ok3 and type(res3) == "string" then return res3 end
	end
	if request then
		local ok4, res4 = pcall(request, {Url = BASE .. path, Method = "GET"})
		if ok4 and res4 and type(res4.Body) == "string" then return res4.Body end
	end
	return nil
end

local src = fetch("windui_rivals.luau")
if not src then warn("[rv] fetch failed") return end
local fn, err = loadstring(src)
if fn then fn() else warn("[rv] loadstring: " .. tostring(err)) end
