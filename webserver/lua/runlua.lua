local out=""
local env=setmetatable({
	print=function(...)
		out=out..table.concat({...}," ").."\r\n"
	end,
	write=function(...)
		out=out..table.concat({...}," ")
	end,
	_g=_G,
},{
	__index=_G,
})
env._G=env
local function errf(cl,txt)
	local res={
		headers=defHeaders(),
		code=500,
		format="html",
		data="<html><head><title>Script error</title></head><h1>Script error</h1><br><h3>\n"..htmlencode(txt).."\n</h3></html>",
	}
	serveres(cl,res)
end
function runlua(code,cl,res)
	local func,rr=loadstring(code,"="..cl.path)
	if not func then
		return errf(cl,rr)
	end
	setfenv(func,env)
	env.cl=cl
	env.res=res
	env.post=cl.post
	env.get=cl.get
	env.headers=res.headers
	out=""
	print("calling func")
	local ok,err=xpcall(func,debug.traceback)
	if not ok then
		return errf(cl,err)
	end
	print("done")
	res.data=out
	serveres(cl,res)
end