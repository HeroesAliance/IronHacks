-- webserver by PixelToast
version="0.1"

-- start server

local sv=assert(socket.bind(config.bindTo or "*",config.port))
sv:settimeout(0) -- non-blocking
hook.newsocket(sv)
print("listening on port "..config.port)

hook.new("select",function(rq,sq)
	if rq[sv] then
		local sk=assert(sv:accept())
		while sk do
			print("got client "..sk:getfd().." "..(sk:getpeername() or "*"))
			hook.newsocket(sk)
			sk:settimeout(0)
			client.new(sk)
			sk=sv:accept()
		end
	end
end,"server socket manager")

-- main blocking loop

while true do
	local rq,sq=socket.select(hook.sel,hook.rsel,math.min(5,hook.interval or 5))
	hook.queue("select",rq,sq)
end


