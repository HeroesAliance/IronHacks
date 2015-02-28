local arg=...
if arg then
	loadstring(...)()
end
dofile("lua/include.lua")
dofile("project.lua")
dofile("lua/main.lua")
