socket=require("socket")
lfs=require("lfs")
dofile("lua/util.lua")
dofile("lua/fs.lua")

-- read config

configfile=configfile or "config.txt"
local dconfig=config
function loadconfig()
	local file=assert(io.open(configfile))
	config={}
	setfenv(assert(loadstring(file:read("*a"))),config)()
	assert(config.domains)
	assert(config.domains.default)
	setmetatable(config.domains,{
		__index=function(s,n)
			return config.domains.default
		end
	})
	for k,v in pairs(config.domains) do
		if k~="default" then
			setmetatable(v,{
				__index=config.domains.default,
			})
		end
	end
	if dconfig then
		merge(dconfig,config)
	end
	print("loaded "..configfile)
end
loadconfig()

-- load apis

dofile("lua/hook.lua")
dofile("lua/client.lua")
dofile("lua/receivehead.lua")
dofile("lua/runlua.lua")
dofile("lua/serve.lua")