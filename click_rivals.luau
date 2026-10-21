for i = 1, 900 do
	if game:IsLoaded() and game:GetService("Players").LocalPlayer then break end
	task.wait(0.1)
end
local uis = game:GetService("UserInputService")
local players = game:GetService("Players")
local ws = game:GetService("Workspace")
local rs = game:GetService("ReplicatedStorage")
local run = game:GetService("RunService")
local lp = players.LocalPlayer
local vec2 = Vector2.new
local rgb = Color3.fromRGB
local min, max, abs = math.min, math.max, math.abs

task.spawn(function()
	pcall(function()
		if hookfunction and newcclosure then
			local o = nil
			o = hookfunction(setmetatable, newcclosure(function(t, m)
				if type(m) == "table" and rawget(m, "__mode") == "kv" then
					local s = getcallingscript and getcallingscript()
					if s and s.Name == "MiscellaneousController" then return o(t, {}) end
				end
				return o(t, m)
			end))
			local o2 = nil
			o2 = hookfunction(rawlen, newcclosure(function(t)
				if type(t) == "table" then
					local s = getcallingscript and getcallingscript()
					if s and s.Name == "MiscellaneousController" then return 3 end
				end
				return o2(t)
			end))
		end
	end)
	pcall(function()
		if not (hookfunction and newcclosure and getrenv) then return end
		local o = nil
		o = hookfunction(getrenv().setmetatable, newcclosure(function(t, m)
			if m and type(m) == "table" and rawget(m, "__mode") == "kv" then
				local tb = debug.traceback()
				if tb:find("MiscellaneousController") then return o({1, 2, 3}, {}) end
			end
			return o(t, m)
		end))
	end)
	coroutine.wrap(function()
		local bad = {"anticheat", "ac", "detection", "ban", "kick", "security", "moderation"}
		local function kill(s)
			if s:IsA("LocalScript") or s:IsA("ModuleScript") then
				local n = string.lower(s.Name)
				for _, k in ipairs(bad) do
					if string.find(n, k, 1, true) then pcall(function() s.Disabled = true end) break end
				end
			end
		end
		pcall(function() game.DescendantAdded:Connect(kill) end)
		pcall(function()
			local d = game:GetDescendants()
			for i = 1, #d do
				kill(d[i])
				if i % 4000 == 0 then task.wait() end
			end
		end)
	end)()
	pcall(function()
		local nc = game:GetService("NetworkClient")
		nc.ChildAdded:Connect(function(c)
			pcall(function()
				local ok, n = pcall(function() return c.Name:lower() end)
				if ok and n and (n:find("anticheat") or n:find("detection")) then pcall(function() c:Destroy() end) end
			end)
		end)
	end)
	pcall(function()
		local r = Instance.new("RemoteEvent")
		r.Name = "ClientAlert"
		r.Parent = lp
	end)
	pcall(function()
		if type(getgc) ~= "function" then return end
		local ls3 = game:GetService("ReplicatedFirst"):WaitForChild("LocalScript3", 10)
		local gc = getgc(false)
		for i = 1, #gc do
			local f = gc[i]
			if type(f) == "function" and (type(islclosure) ~= "function" or islclosure(f)) then
				local ok, env = pcall(getfenv, f)
				if ok and type(env) == "table" then
					local ok2, scr = pcall(function() return rawget(env, "script") end)
					if ok2 and scr and typeof(scr) == "Instance" then
						local ok3, sn = pcall(tostring, scr)
						if ok3 and (scr == ls3 or (type(sn) == "string" and sn:find("LoadingScreen"))) then
							local ok4, consts = pcall(debug.getconstants, f)
							if ok4 and type(consts) == "table" then
								for _, c in ipairs(consts) do
									if type(c) == "string" and (c:find("TakeTheL") or c:find("ban") or c:find("kick")) then
										pcall(function() hookfunction(f, function() end) end)
										break
									end
								end
							end
						end
					end
				end
			end
			if i % 1500 == 0 then task.wait() end
		end
	end)
	local blind = {localscript3 = true, miscellaneouscontroller = true}
	local cache = setmetatable({}, {__mode = "k"})
	local oi = nil
	pcall(function()
		if not (hookmetamethod and newcclosure and getcallingscript) then return end
		oi = hookmetamethod(game, "__index", newcclosure(function(self, k)
			if k == "Name" or k == "Text" then
				local s = getcallingscript()
				if s then
					local b = cache[s]
					if b == nil then
						local ok, n = pcall(function() return blind[string.lower(oi(s, "Name"))] == true end)
						b = ok and n or false
						cache[s] = b
					end
					if b then return "" end
				end
			end
			return oi(self, k)
		end))
	end)
end)

if getgenv().rvUnload then pcall(getgenv().rvUnload) end

local Library = getgenv().Library or Library
local Utility = getgenv().Utility
if Library and Library.SelfDestruct then
	local __sd = Library.SelfDestruct
	function Library.SelfDestruct(...)
		warn("[rv] SelfDestruct called\n" .. debug.traceback("", 2))
		return __sd(...)
	end
end
if Utility and Utility.AddImage then
	pcall(function()
		if makefolder then
			pcall(makefolder, "Abyss") pcall(makefolder, "Abyss/Caches") pcall(makefolder, "Abyss/Assets")
			pcall(makefolder, "Abyss/Assets/UI") pcall(makefolder, "Abyss/Configs") pcall(makefolder, "Abyss/Scripts")
			pcall(makefolder, "Waffle") pcall(makefolder, "Waffle/Assets")
		end
		local T = Library.Theme
		T.Gradient = T.Gradient or Utility.AddImage("Abyss/Assets/UI/Gradient.png", "https://raw.githubusercontent.com/mvonwalk/Exterium/main/Gradient.png")
		T.Hue = T.Hue or Utility.AddImage("Abyss/Assets/UI/Hue.png", "https://raw.githubusercontent.com/mvonwalk/Exterium/main/HuePicker.png")
		T.Saturation = T.Saturation or Utility.AddImage("Abyss/Assets/UI/Saturation.png", "https://raw.githubusercontent.com/mvonwalk/Exterium/main/SaturationPicker.png")
		T.SaturationCursor = T.SaturationCursor or Utility.AddImage("Abyss/Assets/UI/HueCursor.png", "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
		T.Logo = T.Logo or Utility.AddImage("Waffle/Assets/waffle.png", "https://raw.githubusercontent.com/vrcdev/RivalsWaffle/main/waffle.png")
		T.Astolfo = T.Astolfo or Utility.AddImage("Abyss/Assets/UI/Astolfo.png", "https://i.imgur.com/T20cWY9.png")
		T.Aiko = T.Aiko or Utility.AddImage("Abyss/Assets/UI/Aiko.png", "https://i.imgur.com/ykbRkhJ.png")
		T.Rem = T.Rem or Utility.AddImage("Abyss/Assets/UI/Rem.png", "https://i.imgur.com/ykbRkhJ.png")
		T.Violet = T.Violet or Utility.AddImage("Abyss/Assets/UI/Violet.png", "https://i.imgur.com/7B56w4a.png")
		T.Asuka = T.Asuka or Utility.AddImage("Abyss/Assets/UI/Asuka.png", "https://i.imgur.com/3hwztNM.png")
	end)
end

local Controls = {}
local function flag(k, d)
	if not Library or not Library.Flags then return d end
	local v = Library.Flags[k]
	if v == nil then return d end
	return v
end

local CFG = {
	FOV = 220,
	Smooth = 0.3,
	WallCheck = true,
	AimPart = "HitboxHead",
	Chance = 100,
	MaxDist = 600,
}
local colEnemy = rgb(255, 80, 80)
local colFriend = rgb(80, 160, 255)

local DEAD = false
local conns = {}
local function conn(sig, fn)
	local c = sig:Connect(fn)
	table.insert(conns, c)
	return c
end

local function cam()
	return ws.CurrentCamera
end

local function myTeam()
	return lp:GetAttribute("TeamID")
end

local function isEnemy(p)
	if not flag("team_check", true) then return true end
	local t, mt = p:GetAttribute("TeamID"), myTeam()
	if t ~= nil and mt ~= nil then return t ~= mt end
	return true
end

local function alive(p)
	local c = p.Character
	if not c then return false end
	local h = c:FindFirstChildWhichIsA("Humanoid")
	return h and h.Health > 0
end

local function aimPart(p)
	local c = p.Character
	if not c then return nil end
	return c:FindFirstChild(CFG.AimPart) or c:FindFirstChild("HitboxHead") or c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart")
end

local getFighterCtl
local itemLib, itemOrig = nil, {}
local itemInstOrig = setmetatable({}, {__mode = "k"})
local function getItemLib()
	if itemLib then return itemLib end
	local mods = rs:FindFirstChild("Modules")
	local m = mods and mods:FindFirstChild("ItemLibrary")
	if m then local ok, t = pcall(require, m) if ok then itemLib = t end end
	return itemLib
end
local patchCfg
local function patchTable(t, orig)
	local rf, rfOn, nrOn, nsOn = patchCfg.rf, patchCfg.rfOn, patchCfg.nrOn, patchCfg.nsOn
	for k, v in pairs(t) do
		if type(v) == "number" then
			if orig[k] == nil then orig[k] = v end
			local o = orig[k]
			local kk = tostring(k)
			if rfOn and (kk:find("Cooldown") or kk:find("Delay") or kk:find("Interval") or kk:find("Rate") or kk:find("Reload") or kk:find("Equip") or kk:find("Recovery") or kk:find("Reset")) then
				t[k] = o * rf
			elseif nrOn and (kk:find("Recoil") or kk:find("Kick")) then
				t[k] = 0
			elseif nsOn and (kk:find("Spread") or kk:find("Accuracy") or kk:find("Bloom")) then
				t[k] = 0
			else
				t[k] = o
			end
		elseif type(v) == "table" then
			if type(orig[k]) ~= "table" then orig[k] = {} end
			patchTable(v, orig[k])
		end
	end
end
local function dumpStats(t, prefix, out, depth)
	for k, v in pairs(t) do
		local p = prefix .. "." .. tostring(k)
		if type(v) == "number" then
			local kk = tostring(k)
			if kk:find("Cooldown") or kk:find("Delay") or kk:find("Rate") or kk:find("Recoil") or kk:find("Spread") or kk:find("Interval") or kk:find("Reload") then
				out[#out + 1] = p .. "=" .. tostring(v)
			end
		elseif type(v) == "table" and depth < 3 then
			dumpStats(v, p, out, depth + 1)
		end
	end
end
function patchItems()
	local il = getItemLib()
	if not il or type(il.Items) ~= "table" then return end
	patchCfg = {rf = flag("rf_mult", 0.5), rfOn = flag("rapid_fire", false), nrOn = flag("no_recoil", false), nsOn = flag("no_spread", false)}
	local dbg = flag("shot_debug", false)
	local shown = 0
	for name, data in pairs(il.Items) do
		if type(data) == "table" then
			itemOrig[name] = itemOrig[name] or {}
			patchTable(data, itemOrig[name])
			if dbg and shown < 15 then
				shown = shown + 1
				local out = {}
				dumpStats(data, "", out, 0)
				print("[rv] item", name, table.concat(out, " | "))
			end
		end
	end
	local f
	local fc = getFighterCtl and getFighterCtl()
	if fc then pcall(function() f = fc:GetFighter(lp) end) end
	if f and f.Items then
		for _, itm in pairs(f.Items) do
			pcall(function()
				local d = itm:Get("Data") or rawget(itm, "Data")
				if type(d) == "table" then
					itemInstOrig[itm] = itemInstOrig[itm] or {}
					patchTable(d, itemInstOrig[itm])
				end
			end)
		end
	end
end

local visParams = RaycastParams.new()
visParams.FilterType = Enum.RaycastFilterType.Exclude
local function rayVisible(part)
	if not part then return false end
	local c = cam()
	if not c then return false end
	visParams.FilterDescendantsInstances = {lp.Character, c}
	local hit = ws:Raycast(c.CFrame.Position, part.Position - c.CFrame.Position, visParams)
	return (not hit) or hit.Instance:IsDescendantOf(part.Parent)
end

local targetParts = {}
local function rescanTargets()
	table.clear(targetParts)
	for _, d in ipairs(ws:GetDescendants()) do
		if d:IsA("BasePart") then
			local sz = d.Size
			if math.max(sz.X, sz.Y, sz.Z) > 20 then continue end
			local n = string.lower(d.Name)
			local hit = n:find("target") ~= nil or n:find("dummy") ~= nil
			if not hit then
				local par = d.Parent
				for _ = 1, 3 do
					if not par or par == ws then break end
					local pn = string.lower(par.Name)
					if pn:find("target") or pn:find("dummy") then hit = true break end
					if par:IsA("Model") and par:FindFirstChildWhichIsA("Humanoid") and not players:GetPlayerFromCharacter(par) then
						if n == "hitboxhead" or n == "head" or n == "humanoidrootpart" or n:find("hitbox") then hit = true end
						break
					end
					par = par.Parent
				end
			end
			if hit then targetParts[#targetParts + 1] = d end
		end
	end
end

local function pickTarget()
	local c = cam()
	if not c then return nil end
	local center = vec2(c.ViewportSize.X / 2, c.ViewportSize.Y / 2)
	local best, bestPart, bestD = nil, nil, math.huge
	local myPos = (lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Character.HumanoidRootPart.Position) or c.CFrame.Position
	local needRay = CFG.WallCheck
	for _, p in ipairs(players:GetPlayers()) do
		if p ~= lp and alive(p) and isEnemy(p) then
			local part = aimPart(p)
			if part then
				local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
				local inRange = (not hrp) or (hrp.Position - myPos).Magnitude <= CFG.MaxDist
				if inRange then
					local v, on = c:WorldToViewportPoint(part.Position)
					if on then
						local d = (vec2(v.X, v.Y) - center).Magnitude
						if d <= CFG.FOV and d < bestD then
							if (not needRay) or rayVisible(part) then
								best, bestPart, bestD = p, part, d
							end
						end
					end
				end
			end
		end
	end
	if flag("aim_dummies", false) then
		for _, part in ipairs(targetParts) do
			local m = part.Parent and part:FindFirstAncestorOfClass("Model")
			local aimAt = part
			if m then
				aimAt = m:FindFirstChild("HitboxHead") or m:FindFirstChild("Head") or m:FindFirstChild("HumanoidRootPart") or part
			end
			if aimAt.Parent and (aimAt.Position - myPos).Magnitude <= CFG.MaxDist then
				part = aimAt
				local v, on = c:WorldToViewportPoint(part.Position)
				if on then
					local d = (vec2(v.X, v.Y) - center).Magnitude
					if d <= CFG.FOV and d < bestD then
						if (not needRay) or rayVisible(part) then
							best, bestPart, bestD = part, part, d
						end
					end
				end
			end
		end
	end
	return best, bestPart
end

local function flipCam(pos)
	local c = cam()
	if not c or not pos then return false, nil, nil end
	local old = c.CFrame
	c.CFrame = CFrame.lookAt(c.CFrame.Position, pos)
	return true, c, old
end
local function unflipCam(ok, c, old)
	if ok and c and cam() == c then c.CFrame = old end
end

local modules = {}
local function resolveClass(name)
	if modules[name] then return modules[name] end
	local ps = lp:FindFirstChild("PlayerScripts")
	local mods = ps and ps:FindFirstChild("Modules")
	local it = mods and mods:FindFirstChild("ItemTypes")
	local items = mods and mods:FindFirstChild("Items")
	local m = (it and it:FindFirstChild(name)) or (items and items:FindFirstChild(name))
	if name == "ClientItem" then
		local crc = mods and mods:FindFirstChild("ClientReplicatedClasses")
		local cf = crc and crc:FindFirstChild("ClientFighter")
		m = cf and cf:FindFirstChild("ClientItem")
	end
	if not m then return nil end
	local ok, t = pcall(require, m)
	if ok and type(t) == "table" then modules[name] = t return t end
	return nil
end

local fighterCtl = nil
getFighterCtl = function()
	if fighterCtl then return fighterCtl end
	local ps = lp:FindFirstChild("PlayerScripts")
	local m = ps and ps:FindFirstChild("Controllers") and ps.Controllers:FindFirstChild("FighterController")
	if not m then return nil end
	local ok, t = pcall(require, m)
	if ok and type(t) == "table" then fighterCtl = t end
	return fighterCtl
end
local function localFighter()
	local fc = getFighterCtl()
	return fc and fc.LocalFighter or nil
end

local camCtl = nil
local function getCamCtl()
	if camCtl then return camCtl end
	local ps = lp:FindFirstChild("PlayerScripts")
	local m = ps and ps:FindFirstChild("Controllers") and ps.Controllers:FindFirstChild("CameraController")
	if not m then return nil end
	local ok, t = pcall(require, m)
	if ok and type(t) == "table" and type(t.SetRotation) == "function" then camCtl = t end
	return camCtl
end

local wrapped = {}
local reentr = setmetatable({}, {__mode = "k"})
local lastShot, lastUseT = nil, nil
local function wrapClass(cls)
	if not cls or type(cls.StartShooting) ~= "function" or wrapped[cls] then return end
	local orig = cls.StartShooting
	local function wrap(self, ...)
		if DEAD or reentr[coroutine.running()] then return orig(self, ...) end
		local sa = flag("silent_aim", false)
		local ns = flag("no_spread", false)
		if not sa and not ns then return orig(self, ...) end
		local ok, c, old = false, nil, nil
		if sa then
			if math.random(1, 100) <= (flag("aim_chance", CFG.Chance) or 100) then
				local tp, part = pickTarget()
				if part then
					ok, c, old = flipCam(part.Position)
					lastShot = {part = part, t = os.clock()}
					if flag("shot_debug", false) and tp then print("[rv] shot ->", tp.Name) end
				end
			end
		end
		local ct = coroutine.running()
		reentr[ct] = true
		local r = table.pack(pcall(orig, self, ...))
		reentr[ct] = nil
		unflipCam(ok, c, old)
		if not r[1] then error(r[2], 0) end
		if ns and r.n >= 4 then r[4 + 1] = true end
		return table.unpack(r, 2, r.n)
	end
	wrapped[cls] = {orig = orig, wrap = wrap}
	cls.StartShooting = wrap
end
local installSkinHooks
local function ensureHooks()
	for _, n in ipairs({"Gun", "Melee", "Gunblade", "ClientItem"}) do
		local c = resolveClass(n)
		if c then wrapClass(c) end
	end
	if installSkinHooks then installSkinHooks() end
end
ensureHooks()
task.spawn(function()
	while not DEAD do
		task.wait(2)
		ensureHooks()
		pcall(patchItems)
		if flag("aim_dummies", false) then pcall(rescanTargets) end
	end
end)

local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.NumSides = 64
fovCircle.Visible = false

local projHits = {}
conn(ws.DescendantAdded, function(inst)
	if DEAD or not flag("proj_tp", false) then return end
	if not inst:IsA("BasePart") and not inst:IsA("Model") then return end
	local char = lp.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	task.defer(function()
		if DEAD or not inst.Parent then return end
		local p = inst:IsA("BasePart") and inst or (inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart", true))
		if not p or not p.Parent or p.Anchored then return end
		if inst:IsA("Model") and inst:FindFirstChildWhichIsA("Humanoid") then return end
		local sz = p.Size
		if math.max(sz.X, sz.Y, sz.Z) > 12 then return end
		local ok, dist = pcall(function() return (p.Position - hrp.Position).Magnitude end)
		if not ok or dist >= 80 then return end
		local now = os.clock()
		local armed = (lastShot and now - lastShot.t <= 0.5) or (lastUseT and now - lastUseT <= 0.6)
		if not armed then return end
		local tp
		local shot = lastShot
		if shot and now - shot.t <= 0.5 and shot.part and shot.part.Parent then
			tp = shot.part
		elseif flag("silent_aim", false) then
			local _, part = pickTarget()
			tp = part
		end
		if not tp then return end
		if flag("shot_debug", false) then print("[rv] proj tp ->", inst:GetFullName(), inst.ClassName) end
		local function snap()
			local cf = CFrame.new(tp.Position)
			if inst:IsA("Model") then
				inst:PivotTo(cf)
			else
				p.CFrame = cf
			end
			pcall(function() p.AssemblyLinearVelocity = Vector3.zero p.AssemblyAngularVelocity = Vector3.zero end)
		end
		pcall(snap)
		projHits[inst] = {part = tp, until_ = os.clock() + 0.15, snap = snap}
	end)
end)
conn(run.Heartbeat, function()
	if next(projHits) == nil then return end
	local now = os.clock()
	for inst, h in pairs(projHits) do
		if now > h.until_ or not inst.Parent or not h.part.Parent then
			projHits[inst] = nil
		else
			pcall(h.snap)
		end
	end
end)

conn(run.RenderStepped, function()
	if DEAD then return end
	if flag("fov_circle", false) then
		fovCircle.Visible = flag("silent_aim", false) or flag("cam_aim", false)
	else
		fovCircle.Visible = false
	end
	local c0 = cam()
	if c0 then
		fovCircle.Radius = CFG.FOV
		fovCircle.Position = vec2(c0.ViewportSize.X / 2, c0.ViewportSize.Y / 2)
		fovCircle.Color = rgb(200, 200, 255)
	end
	if not flag("cam_aim", false) then return end
	if not uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end
	if math.random(1, 100) > (flag("aim_chance", CFG.Chance) or 100) then return end
	local _, part = pickTarget()
	if not part then return end
	local ctl = getCamCtl()
	local c = cam()
	if not ctl or not c then return end
	local pitch, yaw = (CFrame.lookAt(c.CFrame.Position, part.Position)):ToOrientation()
	local sm = 1 - math.clamp(flag("aim_smooth", CFG.Smooth) or 0, 0, 0.95)
	local cur = rawget(ctl, "Rotation")
	if typeof(cur) == "Vector2" then
		local dy = ((yaw - cur.Y) + math.pi) % (2 * math.pi) - math.pi
		local nv = vec2(cur.X + (pitch - cur.X) * sm, cur.Y + dy * sm)
		pcall(function() ctl:SetRotation(nv) end)
		pcall(function() rawset(ctl, "Rotation", nv) end)
	else
		pcall(function() ctl:SetRotation(vec2(pitch, yaw)) end)
	end
end)

task.spawn(function()
	while not DEAD do
		task.wait(0.05)
		if flag("triggerbot", false) then
			local c = cam()
			if c then
				local hit = ws:FindPartOnRayWithIgnoreList(Ray.new(c.CFrame.Position, c.CFrame.LookVector * 2500), {lp.Character})
				if hit and hit.Parent then
					local hum = hit.Parent:FindFirstChildWhichIsA("Humanoid")
					local pl = players:GetPlayerFromCharacter(hit.Parent)
					local friendly = flag("tb_team", true) and pl and pl:GetAttribute("TeamID") ~= nil and pl:GetAttribute("TeamID") == myTeam()
					if hum and hum.Health > 0 and not friendly then
						local ftr = localFighter()
						if ftr then
							pcall(function()
								setthreadidentity(2)
								ftr:Input("StartShooting")
								setthreadidentity(7)
							end)
						end
						task.wait(flag("tb_delay", 0.1))
					end
				end
			end
		end
	end
end)

task.spawn(function()
	while not DEAD do
		task.wait(flag("as_delay", 0.12))
		if flag("autoshoot", false) and flag("silent_aim", false) then
			local _, part = pickTarget()
			if part and rayVisible(part) and math.random(1, 100) <= (flag("aim_chance", CFG.Chance) or 100) then
				local ftr = localFighter()
				if ftr then
					local ok, c, old = flipCam(part.Position)
					pcall(function()
						setthreadidentity(2)
						ftr:Input("StartShooting")
						setthreadidentity(7)
					end)
					unflipCam(ok, c, old)
				end
			end
		end
	end
end)

local hbOrig = setmetatable({}, {__mode = "k"})
task.spawn(function()
	while not DEAD do
		task.wait(0.2)
		local on = flag("hb_expand", false)
		local scale = flag("hb_scale", 4)
		for _, p in ipairs(players:GetPlayers()) do
			local chr = p.Character
			if p ~= lp and chr then
				for _, d in ipairs(chr:GetDescendants()) do
					if d:IsA("BasePart") and d.Name:sub(1, 6) == "Hitbox" then
						if on and isEnemy(p) then
							if not hbOrig[d] then hbOrig[d] = d.Size end
							local want = hbOrig[d] * scale
							if d.Size ~= want then
								pcall(function()
									d.Size = want
									d.CanCollide = false
								end)
							end
						elseif hbOrig[d] then
							pcall(function() d.Size = hbOrig[d] end)
							hbOrig[d] = nil
						end
					end
				end
			end
		end
	end
	for d, s in pairs(hbOrig) do pcall(function() d.Size = s end) end
end)

local chamHl = {}
task.spawn(function()
	while not DEAD do
		task.wait(0.25)
		for _, p in ipairs(players:GetPlayers()) do
			if p ~= lp then
				local chr = p.Character
				local h = chamHl[p]
				local want = flag("chams", false) and chr ~= nil and alive(p) and isEnemy(p)
				if want and (not h or h.Parent ~= chr) then
					if h then pcall(function() h:Destroy() end) end
					local ok, nh = pcall(Instance.new, "Highlight")
					if ok and nh then
						nh.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						nh.FillTransparency = 0.55
						nh.OutlineTransparency = 0
						nh.FillColor = colEnemy
						nh.OutlineColor = rgb(255, 255, 255)
						nh.Parent = chr
						chamHl[p] = nh
					end
				elseif not want and h then
					pcall(function() h:Destroy() end)
					chamHl[p] = nil
				end
			end
		end
	end
end)

local cosLib, enumLib, pdc, repClass
local function resolveCos()
	if not cosLib then
		local mods = rs:FindFirstChild("Modules")
		local m = mods and mods:FindFirstChild("CosmeticLibrary")
		if m then local ok, t = pcall(require, m) if ok then cosLib = t end end
		m = mods and mods:FindFirstChild("EnumLibrary")
		if m then
			local ok, t = pcall(require, m)
			if ok then enumLib = t pcall(function() enumLib:WaitForEnumBuilder() end) end
		end
		m = mods and mods:FindFirstChild("ReplicatedClass")
		if m then local ok, t = pcall(require, m) if ok then repClass = t end end
	end
	if not pdc then
		local ps = lp:FindFirstChild("PlayerScripts")
		local m = ps and ps:FindFirstChild("Controllers") and ps.Controllers:FindFirstChild("PlayerDataController")
		if m then local ok, t = pcall(require, m) if ok then pdc = t end end
	end
	return cosLib ~= nil and pdc ~= nil
end

local COSMETIC_TYPES = {Skin = true, Wrap = true, Charm = true, Dance = true, Emote = true, Finisher = true, Arm = true, DeathEffect = true, KillEffect = true}
local function skinOK(c) return c ~= nil and COSMETIC_TYPES[c.Type] == true end
local equipMap, favMap, lastUseWep = {}, {}, nil
local function makeCosmetic(name, slotType, opts)
	local c = cosLib and cosLib.Cosmetics and cosLib.Cosmetics[name]
	if not c then return nil end
	local o = {}
	for k, v in pairs(c) do o[k] = v end
	o.Name = name
	o.Type = o.Type or slotType
	o.Seed = o.Seed or math.random(1, 1000000)
	if enumLib then
		local ok, e = pcall(enumLib.ToEnum, enumLib, name)
		if ok and e then o.Enum = e o.ObjectID = o.ObjectID or e end
	end
	if opts then
		if opts.inverted ~= nil then o.Inverted = opts.inverted end
		if opts.favoritesOnly ~= nil then o.OnlyUseFavorites = opts.favoritesOnly end
	end
	return o
end
local function refreshCosmetics()
	pcall(function()
		for _, k in ipairs({"CosmeticInventory", "WeaponInventory", "FavoritedCosmetics"}) do
			pdc.CurrentData:Replicate(k)
		end
	end)
end

local skinHooksDone = false
local function skinOn() return flag("skin_unlock", false) end
installSkinHooks = function()
	if skinHooksDone or not resolveCos() then return end
	skinHooksDone = true
	local function wantsOwnedCosmetic(...)
		for i = 2, select("#", ...) do
			local v = select(i, ...)
			if type(v) == "string" then
				local cc = cosLib.Cosmetics[v]
				if cc and skinOK(cc) and not v:find("MISSING_") and v ~= "Bubble Gun" then return true end
			end
		end
		return false
	end
	for _, n in ipairs({"OwnsCosmeticNormally", "OwnsCosmeticUniversally", "OwnsCosmeticForWeapon"}) do
		local orig = cosLib[n]
		if type(orig) == "function" then
			cosLib[n] = function(...)
				if not skinOn() then return orig(...) end
				if wantsOwnedCosmetic(...) then return true end
				return orig(...)
			end
		end
	end
	local oOwn = cosLib.OwnsCosmetic
	if type(oOwn) == "function" then
		cosLib.OwnsCosmetic = function(...)
			if not skinOn() then return oOwn(...) end
			if wantsOwnedCosmetic(...) then return true end
			return oOwn(...)
		end
	end
	local oGet = pdc.Get
	if type(oGet) == "function" then
		pdc.Get = function(s, key)
			if not skinOn() then return oGet(s, key) end
			local orig = oGet(s, key)
			if key == "CosmeticInventory" then
				local inv = {}
				for name, c in pairs(cosLib.Cosmetics) do
					if skinOK(c) and not name:find("MISSING_") and name ~= "Bubble Gun" then inv[name] = true end
				end
				if orig then for name, val in pairs(orig) do if val ~= nil then inv[name] = val end end end
				return setmetatable(inv, {__index = function(_, k)
					local cc = cosLib.Cosmetics[k]
					if cc and skinOK(cc) then return true end
					return nil
				end})
			end
			if key == "FavoritedCosmetics" then
				local f = orig and table.clone(orig) or {}
				for w, tbl in pairs(favMap) do
					f[w] = f[w] or {}
					for n, v in pairs(tbl) do
						local cc = cosLib.Cosmetics[n]
						if cc and skinOK(cc) then f[w][n] = v end
					end
				end
				return f
			end
			return orig
		end
	end
	local oGwd = pdc.GetWeaponData
	if type(oGwd) == "function" then
		pdc.GetWeaponData = function(s, name)
			local d = oGwd(s, name)
			if not d then return nil end
			local patchStats = flag("rapid_fire", false) or flag("no_recoil", false)
			if not patchStats and not (skinOn() and equipMap[name]) then return d end
			local o = {}
			for k, v in pairs(d) do
				if type(v) == "table" then
					local nt = {}
					for k2, v2 in pairs(v) do nt[k2] = v2 end
					o[k] = nt
				else
					o[k] = v
				end
			end
			o.Name = name
			if skinOn() and equipMap[name] then for k, v in pairs(equipMap[name]) do o[k] = v end end
			if patchStats then
				local rf = flag("rf_mult", 0.5)
				local rfOn, nrOn = flag("rapid_fire", false), flag("no_recoil", false)
				local function patchNums(t, depth)
					for k, v in pairs(t) do
						if type(v) == "number" then
							local okk, kn = pcall(tostring, k)
							kn = okk and kn or ""
							if rfOn and (kn:find("Delay") or kn:find("Interval") or kn:find("Cooldown") or kn:find("Reload") or kn:find("Equip") or kn:find("Rate")) then
								t[k] = v * rf
							end
							if nrOn and (kn:find("Recoil") or kn:find("Kick") or kn:find("Bloom") or kn:find("Spread")) then
								t[k] = 0
							end
						elseif type(v) == "table" and depth < 2 then
							patchNums(v, depth + 1)
						end
					end
				end
				patchNums(o, 0)
			end
			return o
		end
	end
	local remotes = rs:FindFirstChild("Remotes")
	local dataR = remotes and remotes:FindFirstChild("Data")
	local equipR = dataR and dataR:FindFirstChild("EquipCosmetic")
	local favR = dataR and dataR:FindFirstChild("FavoriteCosmetic")
	local replR = remotes and remotes:FindFirstChild("Replication")
	local fightR = replR and replR:FindFirstChild("Fighter")
	local useItemR = fightR and fightR:FindFirstChild("UseItem")
	if equipR and hookmetamethod and getnamecallmethod and newcclosure then
		local on = nil
		on = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
			if getnamecallmethod() ~= "FireServer" then return on(self, ...) end
			if self == useItemR then
				local ua = {...}
				lastUseT = os.clock()
				local fc = getFighterCtl()
				if fc then pcall(function()
					local f = fc:GetFighter(lp)
					if f and f.Items then
						for _, itm in pairs(f.Items) do
							if itm:Get("ObjectID") == ua[1] then lastUseWep = itm.Name break end
						end
					end
				end) end
				return on(self, ...)
			end
			if not skinOn() then return on(self, ...) end
			if self == equipR then
				local a = {...}
				local w, slot, cname, opts = a[1], a[2], a[3], a[4] or {}
				if cname and cname ~= "None" and cname ~= "" then
					local owned = false
					pcall(function()
						local inv = oGet(pdc, "CosmeticInventory")
						if inv and rawget(inv, cname) then owned = true end
					end)
					if owned then return on(self, ...) end
				end
				equipMap[w] = equipMap[w] or {}
				local t = slot
				if type(slot) ~= "string" then
					t = tostring(slot)
					pcall(function()
						local cc = cosLib.Cosmetics[cname]
						if cc and type(cc.Type) == "string" then t = cc.Type end
					end)
				end
				if not cname or cname == "None" or cname == "" then
					equipMap[w][t] = nil
					if t ~= slot then equipMap[w][slot] = nil end
					if not next(equipMap[w]) then equipMap[w] = nil end
				else
					local cobj = makeCosmetic(cname, t, {inverted = opts.IsInverted or opts.inverted, favoritesOnly = opts.OnlyUseFavorites or opts.favoritesOnly})
					if cobj then
						equipMap[w][t] = cobj
						if t ~= slot then equipMap[w][slot] = cobj end
						if cobj.Type then equipMap[w][cobj.Type] = cobj end
					end
				end
				task.defer(function() pcall(function() pdc.CurrentData:Replicate("WeaponInventory") end) end)
				return
			end
			if self == favR then
				local a = {...}
				if cosLib.Cosmetics[a[2]] then
					favMap[a[1]] = favMap[a[1]] or {}
					favMap[a[1]][a[2]] = a[3] or nil
					task.spawn(function() pcall(function() pdc.CurrentData:Replicate("FavoritedCosmetics") end) end)
				end
				return
			end
			return on(self, ...)
		end))
	end
	local ci = resolveClass("ClientItem")
	if ci and type(ci._CreateViewModel) == "function" then
		local ocvm = ci._CreateViewModel
		ci._CreateViewModel = function(item, C)
			if not skinOn() then return ocvm(item, C) end
			local iname = item.Name
			local pl = item.ClientFighter and item.ClientFighter.Player
			if pl == lp and equipMap[iname] then
				local m2 = equipMap[iname]
				local ok, W = pcall(function() return item:ToEnum("Data") end)
				if ok and W and C[W] then
					if m2.Skin then C[W][item:ToEnum("Skin")] = m2.Skin C[W][item:ToEnum("Name")] = m2.Skin.Name end
					if m2.Charm then C[W][item:ToEnum("Charm")] = m2.Charm end
					if m2.Wrap then C[W][item:ToEnum("Wrap")] = m2.Wrap end
				elseif C.Data then
					if m2.Skin then C.Data.Skin = m2.Skin C.Data.Name = m2.Skin.Name end
					if m2.Charm then C.Data.Charm = m2.Charm end
					if m2.Wrap then C.Data.Wrap = m2.Wrap end
				end
			end
			return ocvm(item, C)
		end
	end
	local cvmMod
	pcall(function()
		local ps = lp:FindFirstChild("PlayerScripts")
		local m = ps and ps.Modules.ClientReplicatedClasses.ClientFighter.ClientItem:FindFirstChild("ClientViewModel")
		if m then cvmMod = require(m) end
	end)
	if cvmMod and type(cvmMod.new) == "function" then
		local onew = cvmMod.new
		cvmMod.new = function(p, o)
			if not skinOn() then return onew(p, o) end
			local pl = o.ClientFighter and o.ClientFighter.Player
			local iname = o.Name
			local m2 = equipMap[iname] or (lastUseWep and equipMap[lastUseWep])
			if pl == lp and m2 and repClass then
				local de = repClass:ToEnum("Data")
				p[de] = p[de] or {}
				if m2.Skin then p[de][repClass:ToEnum("Skin")] = m2.Skin end
				if m2.Charm then p[de][repClass:ToEnum("Charm")] = m2.Charm end
				if m2.Wrap then p[de][repClass:ToEnum("Wrap")] = m2.Wrap end
			end
			local res = onew(p, o)
			if pl == lp and m2 and m2.Wrap and res and res._UpdateWrap then
				pcall(function() res:_UpdateWrap() end)
				task.delay(0.1, function() pcall(function() if res._UpdateWrap then res:_UpdateWrap() end end) end)
			end
			return res
		end
	end
	if cvmMod and type(cvmMod.GetWrap) == "function" then
		local ogw = cvmMod.GetWrap
		cvmMod.GetWrap = function(self)
			if skinOn() then
				local ci = self.ClientItem
				local wname = ci and ci.Name
				local wplr = ci and ci.ClientFighter and ci.ClientFighter.Player
				local weq = wplr == lp and ((wname and equipMap[wname]) or (lastUseWep and equipMap[lastUseWep]))
				if weq and weq.Wrap then return weq.Wrap end
			end
			return ogw(self)
		end
	end
end
installSkinHooks()

local espPool = {}
local BONES = {
	{"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
	{"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
	{"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
	{"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
	{"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"},
}
local BONES_R6 = {
	{"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"},
	{"Torso", "Left Leg"}, {"Torso", "Right Leg"},
}
local function dw(t, props)
	local d = Drawing.new(t)
	for k, v in pairs(props) do d[k] = v end
	return d
end
local function makeESP()
	local e = {}
	e.box = {dw("Line", {Thickness = 1}), dw("Line", {Thickness = 1}), dw("Line", {Thickness = 1}), dw("Line", {Thickness = 1})}
	e.hp = {dw("Line", {Thickness = 3, Color = rgb(0, 0, 0)}), dw("Line", {Thickness = 1})}
	e.name = dw("Text", {Size = 13, Center = true, Outline = true})
	e.dist = dw("Text", {Size = 12, Center = true, Outline = true})
	e.tracer = dw("Line", {Thickness = 1})
	e.arrow = dw("Triangle", {Filled = true})
	e.skel = {}
	for _ = 1, 14 do table.insert(e.skel, dw("Line", {Thickness = 1})) end
	return e
end
local function hideESP(e)
	for _, l in ipairs(e.box) do l.Visible = false end
	for _, l in ipairs(e.hp) do l.Visible = false end
	e.name.Visible = false e.dist.Visible = false e.tracer.Visible = false e.arrow.Visible = false
	for _, l in ipairs(e.skel) do l.Visible = false end
end

local specText = dw("Text", {Size = 14, Center = true, Outline = true, Color = rgb(255, 80, 80)})
specText.Visible = false
local SPEC_ATTRS = {"Spectating", "IsSpectating", "Spectator", "InSpectate", "SpectateTarget"}
task.spawn(function()
	while not DEAD do
		task.wait(0.5)
		if flag("spec_list", false) then
			local names = {}
			for _, p in ipairs(players:GetPlayers()) do
				if p ~= lp then
					local spec = false
					for _, a in ipairs(SPEC_ATTRS) do
						if p:GetAttribute(a) == true then spec = true break end
					end
					if not spec and not p.Character then spec = true end
					if spec then table.insert(names, p.Name) end
				end
			end
			specText.Text = #names > 0 and ("watching: " .. table.concat(names, ", ")) or ""
			local c = cam()
			if c then specText.Position = vec2(c.ViewportSize.X / 2, 40) end
			specText.Visible = #names > 0
		else
			specText.Visible = false
		end
	end
end)

conn(run.RenderStepped, function()
	if DEAD then return end
	for _, p in ipairs(players:GetPlayers()) do
		if p ~= lp then
			local e = espPool[p]
			if not e then e = makeESP() espPool[p] = e end
			local ok = flag("esp_on", false) and alive(p)
			local c = cam()
			if not (ok and c) then if e then hideESP(e) end
			else
				local chr = p.Character
				local hrp = chr and chr:FindFirstChild("HumanoidRootPart")
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				if not (hrp and hum) then hideESP(e)
				else
					local friendly = p:GetAttribute("TeamID") ~= nil and p:GetAttribute("TeamID") == myTeam()
					if flag("esp_team", false) and friendly then hideESP(e)
					else
						local col = friendly and colFriend or colEnemy
						local pos, on = c:WorldToViewportPoint(hrp.Position)
						local head = chr:FindFirstChild("Head")
						local top = head and c:WorldToViewportPoint(head.Position + Vector3.new(0, head.Size.Y / 2 + 0.3, 0)) or c:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
						local foot = c:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.2, 0))
						if on then
							local h = abs(foot.Y - top.Y)
							local w = h * 0.55
							local x, y = pos.X - w / 2, top.Y
							if flag("esp_box", false) then
								e.box[1].From, e.box[1].To = vec2(x, y), vec2(x + w, y)
								e.box[2].From, e.box[2].To = vec2(x + w, y), vec2(x + w, y + h)
								e.box[3].From, e.box[3].To = vec2(x + w, y + h), vec2(x, y + h)
								e.box[4].From, e.box[4].To = vec2(x, y + h), vec2(x, y)
								for _, l in ipairs(e.box) do l.Color = col l.Visible = true end
							else for _, l in ipairs(e.box) do l.Visible = false end end
							if flag("esp_hp", false) and hum.MaxHealth > 0 then
								local f = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
								local bx, bh = x - 5, h * f
								e.hp[1].From, e.hp[1].To = vec2(bx, y + h), vec2(bx, y)
								e.hp[2].From, e.hp[2].To = vec2(bx, y + h), vec2(bx, y + h - bh)
								e.hp[2].Color = rgb(255 * (1 - f), 255 * f, 40)
								e.hp[1].Visible, e.hp[2].Visible = true, true
							else e.hp[1].Visible, e.hp[2].Visible = false, false end
							if flag("esp_name", false) then
								e.name.Text = p.Name
								e.name.Position = vec2(pos.X, y - 15)
								e.name.Color = col
								e.name.Visible = true
							else e.name.Visible = false end
							if flag("esp_dist", false) then
								e.dist.Text = string.format("%dm", (hrp.Position - c.CFrame.Position).Magnitude)
								e.dist.Position = vec2(pos.X, y + h + 3)
								e.dist.Color = col
								e.dist.Visible = true
							else e.dist.Visible = false end
							if flag("esp_skel", false) then
								local bones = chr:FindFirstChild("UpperTorso") and BONES or BONES_R6
								for i, l in ipairs(e.skel) do
									local b = bones[i]
									if b then
										local p1, p2 = chr:FindFirstChild(b[1]), chr:FindFirstChild(b[2])
										if p1 and p2 then
											local a, ao = c:WorldToViewportPoint(p1.Position)
											local bb, bo = c:WorldToViewportPoint(p2.Position)
											if ao and bo then
												l.From, l.To = vec2(a.X, a.Y), vec2(bb.X, bb.Y)
												l.Color = col l.Visible = true
											else l.Visible = false end
										else l.Visible = false end
									else l.Visible = false end
								end
							else for _, l in ipairs(e.skel) do l.Visible = false end end
							if flag("esp_tracer", false) then
								e.tracer.From = vec2(c.ViewportSize.X / 2, c.ViewportSize.Y)
								e.tracer.To = vec2(pos.X, pos.Y)
								e.tracer.Color = col
								e.tracer.Visible = true
							else e.tracer.Visible = false end
							e.arrow.Visible = false
						else
							for _, l in ipairs(e.box) do l.Visible = false end
							for _, l in ipairs(e.hp) do l.Visible = false end
							e.name.Visible, e.dist.Visible = false, false
							for _, l in ipairs(e.skel) do l.Visible = false end
							e.tracer.Visible = false
							if flag("esp_arrow", false) then
								local edge = 40
								local vx, vy = pos.X, pos.Y
								local cx, cy = c.ViewportSize.X / 2, c.ViewportSize.Y / 2
								local dir = vec2(vx - cx, vy - cy)
								if dir.Magnitude > 1 then
									dir = dir.Unit
									local px = math.clamp(cx + dir.X * c.ViewportSize.X, edge, c.ViewportSize.X - edge)
									local py = math.clamp(cy + dir.Y * c.ViewportSize.Y, edge, c.ViewportSize.Y - edge)
									e.arrow.PointA = vec2(px, py)
									e.arrow.PointB = vec2(px - dir.X * 12 - dir.Y * 7, py - dir.Y * 12 + dir.X * 7)
									e.arrow.PointC = vec2(px - dir.X * 12 + dir.Y * 7, py - dir.Y * 12 - dir.X * 7)
									e.arrow.Color = col
									e.arrow.Visible = true
								else e.arrow.Visible = false end
							else e.arrow.Visible = false end
						end
					end
				end
			end
		end
	end
end)

conn(lp.Idled, function()
	if flag("anti_afk", true) then
		pcall(function()
			local vu = game:GetService("VirtualUser")
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end)
	end
end)

local Window = Library.Window("waffle // rivals", vec2(540, 620))
pcall(function() Window.Watermark("waffle") end)
pcall(function() Window.ChangeAnime("Astolfo") end)
pcall(function() Window.ToggleAnime(false) end)

local combat = Window:Tab("combat")
local aimSec = combat:Section("silent aim", "Left")
Controls.silent_aim = aimSec:Toggle({Title = "enabled", Flag = "silent_aim", Default = false})
aimSec:Slider({Title = "fov", Flag = "aim_fov", Min = 20, Max = 700, Default = CFG.FOV, Decimals = 1, Callback = function(v) CFG.FOV = v end})
aimSec:Dropdown({Title = "bone", Flag = "aim_part", List = {"HitboxHead", "Head", "HumanoidRootPart"}, Default = "HitboxHead", Callback = function(v) CFG.AimPart = v end})
aimSec:Slider({Title = "hit chance", Flag = "aim_chance", Min = 1, Max = 100, Default = 100, Decimals = 1, Callback = function(v) CFG.Chance = v end})
aimSec:Slider({Title = "max dist", Flag = "aim_dist", Min = 50, Max = 2500, Default = CFG.MaxDist, Decimals = 1, Callback = function(v) CFG.MaxDist = v end})
Controls.fov_circle = aimSec:Toggle({Title = "show fov", Flag = "fov_circle", Default = false})
Controls.wall_check = aimSec:Toggle({Title = "wall check", Flag = "wall_check", Default = true, Callback = function(v) CFG.WallCheck = v end})
Controls.shot_debug = aimSec:Toggle({Title = "shot debug", Flag = "shot_debug", Default = false})
Controls.proj_tp = aimSec:Toggle({Title = "projectile tp", Flag = "proj_tp", Default = true})
Controls.aim_dummies = aimSec:Toggle({Title = "target dummies", Flag = "aim_dummies", Default = false, Callback = function(v) if v then pcall(rescanTargets) end end})
Controls.autoshoot = aimSec:Toggle({Title = "auto fire", Flag = "autoshoot", Default = false})
aimSec:Label("auto fires on visible locks")
aimSec:Slider({Title = "auto delay", Flag = "as_delay", Min = 0.03, Max = 0.5, Default = 0.12, Decimals = 2})

local camSec = combat:Section("camera aim", "Right")
Controls.cam_aim = camSec:Toggle({Title = "enabled (hold M2)", Flag = "cam_aim", Default = false})
camSec:Slider({Title = "smoothing", Flag = "aim_smooth", Min = 0, Max = 0.95, Default = 0.3, Decimals = 100, Callback = function(v) CFG.Smooth = v end})
Controls.team_check = camSec:Toggle({Title = "team check", Flag = "team_check", Default = true})

local hbSec = combat:Section("hitbox", "Right")
Controls.hb_expand = hbSec:Toggle({Title = "expander", Flag = "hb_expand", Default = false})
hbSec:Label("inflates enemy hitboxes locally")
hbSec:Slider({Title = "scale", Flag = "hb_scale", Min = 1, Max = 15, Default = 4, Decimals = 1})

local tbSec = combat:Section("triggerbot", "Right")
Controls.triggerbot = tbSec:Toggle({Title = "enabled", Flag = "triggerbot", Default = false})
Controls.tb_team = tbSec:Toggle({Title = "team check", Flag = "tb_team", Default = true})
tbSec:Slider({Title = "delay", Flag = "tb_delay", Min = 0.02, Max = 0.6, Default = 0.1, Decimals = 100})

local gunSec = combat:Section("weapon", "Left")
Controls.no_spread = gunSec:Toggle({Title = "no spread", Flag = "no_spread", Default = false, Callback = function() patchItems() end})
Controls.rapid_fire = gunSec:Toggle({Title = "rapid fire", Flag = "rapid_fire", Default = false, Callback = function() patchItems() end})
gunSec:Slider({Title = "fire rate mult", Flag = "rf_mult", Min = 0.1, Max = 1, Default = 0.5, Decimals = 100, Callback = function() patchItems() end})
Controls.no_recoil = gunSec:Toggle({Title = "no recoil", Flag = "no_recoil", Default = false, Callback = function() patchItems() end})

local vis = Window:Tab("visuals")
local espSec = vis:Section("esp", "Left")
Controls.esp_on = espSec:Toggle({Title = "enabled", Flag = "esp_on", Default = false})
Controls.esp_box = espSec:Toggle({Title = "boxes", Flag = "esp_box", Default = true})
Controls.esp_name = espSec:Toggle({Title = "names", Flag = "esp_name", Default = true})
Controls.esp_hp = espSec:Toggle({Title = "health bar", Flag = "esp_hp", Default = true})
Controls.esp_dist = espSec:Toggle({Title = "distance", Flag = "esp_dist", Default = false})
Controls.esp_skel = espSec:Toggle({Title = "skeleton", Flag = "esp_skel", Default = false})
Controls.esp_tracer = espSec:Toggle({Title = "tracers", Flag = "esp_tracer", Default = false})
Controls.esp_arrow = espSec:Toggle({Title = "offscreen arrows", Flag = "esp_arrow", Default = false})
Controls.esp_team = espSec:Toggle({Title = "hide teammates", Flag = "esp_team", Default = true})
Controls.chams = espSec:Toggle({Title = "chams", Flag = "chams", Default = false})

local colSec = vis:Section("colors", "Right")
colSec:Colorpicker({Title = "enemy", Flag = "col_enemy", Color = colEnemy, Callback = function(v) colEnemy = v end})
colSec:Colorpicker({Title = "friendly", Flag = "col_friend", Color = colFriend, Callback = function(v) colFriend = v end})

local misc = Window:Tab("misc")
local miscSec = misc:Section("misc", "Left")
Controls.anti_afk = miscSec:Toggle({Title = "anti afk", Flag = "anti_afk", Default = true})
miscSec:Label("equip skins in the game menu — stays local")
Controls.skin_unlock = miscSec:Toggle({Title = "unlock all cosmetics", Flag = "skin_unlock", Default = false, Callback = function(v) if v then refreshCosmetics() end end})
miscSec:Button({Title = "refresh cosmetics", Callback = function() refreshCosmetics() end})
Controls.spec_list = miscSec:Toggle({Title = "spectator list", Flag = "spec_list", Default = false})

local unloadAll
local settings = Window:AddSettingsTab(function() if unloadAll then unloadAll() end end)
local cfgSec = settings:Section("config", "Right")
local slots = {"slot 1", "slot 2", "slot 3"}
local slotFiles = {["slot 1"] = "rv_cfg.json", ["slot 2"] = "rv_cfg_slot_2.json", ["slot 3"] = "rv_cfg_slot_3.json"}
local curSlot = "slot 1"
cfgSec:Dropdown({Title = "slot", Flag = "cfg_slot", List = slots, Default = "slot 1", Callback = function(v) curSlot = v end})
cfgSec:Button({Title = "save", Callback = function()
	pcall(function()
		local data = {}
		for k in pairs(Library.Flags) do data[k] = Library.Flags[k] end
		data._cfg = {FOV = CFG.FOV, Smooth = CFG.Smooth, WallCheck = CFG.WallCheck, AimPart = CFG.AimPart, Chance = CFG.Chance, MaxDist = CFG.MaxDist}
		data._col = {e = {colEnemy.R * 255, colEnemy.G * 255, colEnemy.B * 255}, f = {colFriend.R * 255, colFriend.G * 255, colFriend.B * 255}}
		writefile(slotFiles[curSlot], game:GetService("HttpService"):JSONEncode(data))
	end)
end})
local function loadSlot(file)
	pcall(function()
		if not isfile(file) then return end
		local data = game:GetService("HttpService"):JSONDecode(readfile(file))
		if data._cfg then
			CFG.FOV = data._cfg.FOV CFG.Smooth = data._cfg.Smooth CFG.WallCheck = data._cfg.WallCheck
			CFG.AimPart = data._cfg.AimPart CFG.Chance = data._cfg.Chance CFG.MaxDist = data._cfg.MaxDist or CFG.MaxDist
		end
		if data._col then
			colEnemy = rgb(data._col.e[1], data._col.e[2], data._col.e[3])
			colFriend = rgb(data._col.f[1], data._col.f[2], data._col.f[3])
		end
		for k, v in pairs(data) do
			if k ~= "_cfg" and k ~= "_col" then
				Library.Flags[k] = v
				local c = Controls[k]
				if c and c.SetValue then pcall(function() c:SetValue(v) end)
				elseif c and c.Set then pcall(function() c:Set(v) end) end
			end
		end
	end)
end
cfgSec:Button({Title = "load", Callback = function() loadSlot(slotFiles[curSlot]) end})
unloadAll = function()
	if DEAD then return end
	DEAD = true
	for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
	for cls, w in pairs(wrapped) do
		pcall(function() if cls.StartShooting == w.wrap then cls.StartShooting = w.orig end end)
	end
	for _, e in pairs(espPool) do
		for _, l in ipairs(e.box) do pcall(function() l:Remove() end) end
		for _, l in ipairs(e.hp) do pcall(function() l:Remove() end) end
		pcall(function() e.name:Remove() end) pcall(function() e.dist:Remove() end)
		pcall(function() e.tracer:Remove() end) pcall(function() e.arrow:Remove() end)
		for _, l in ipairs(e.skel) do pcall(function() l:Remove() end) end
	end
	for d, s in pairs(hbOrig) do pcall(function() d.Size = s end) end
	for p, h in pairs(chamHl) do pcall(function() h:Destroy() end) chamHl[p] = nil end
	pcall(function() fovCircle:Remove() end)
	pcall(function() specText:Remove() end)
	pcall(function() Library.SelfDestruct() end)
end

settings:Section("unload", "Left"):Button({Title = "unload (End)", Callback = unloadAll})

conn(uis.InputBegan, function(inp)
	if inp.KeyCode == Enum.KeyCode.End then unloadAll() end
end)

getgenv().rvUnload = unloadAll

pcall(function() Window:SwitchTab(combat) end)
if isfile(slotFiles["slot 1"]) then loadSlot(slotFiles["slot 1"]) end
patchItems()
task.delay(5, patchItems)
print("[rv] up — drawings:", Library and #Library.Drawings, "tabs:", Window and #Window.Tabs)
