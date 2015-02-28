local letters
local bg
local graphics=love.graphics
function love.load()
	local r,err=pcall(function()
		bg=graphics.newImage("bg.png")
		local texti=graphics.newImage(love.filesystem.read("font.txt"):match("[^\r\n]+"))
		local textd=texti:getData()
		local textw,texth=texti:getDimensions()
		local text=graphics.newCanvas(textw,texth)
		graphics.setCanvas(text)
		graphics.draw(texti)
		graphics.setCanvas()
		local st
		letters={
			[" "]={
				draw=graphics.newCanvas(1,1),
				width=100,
			}
		}
		local nletters=0
		local sletters="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		for l1=0,textw-1 do
			local ma=0
			for l2=0,texth-1 do
				local r,g,b,a=textd:getPixel(l1,l2)
				ma=math.max(ma,a)
			end
			if st then
				if ma==0 then
					local nc=graphics.newCanvas((l1-st)+1,texth-1)
					graphics.setCanvas(nc)
					graphics.draw(text,1-st,-1)
					graphics.setCanvas()
					nletters=nletters+1
					letters[sletters:sub(nletters,nletters)]={
						draw=nc,
						width=(l1-st)+1,
					}
					st=nil
				end	
			elseif ma~=0 then
				st=l1
			end
		end
		local text=love.filesystem.read("text.txt"):match("[^\r\n]*")
		text=text:upper()
		local tw=0
		for l in text:gmatch(".") do
			assert(letters[l],l)
			tw=tw+letters[l].width
		end
		local cvw,cvh=tw,texth
		local outcv=graphics.newCanvas(cvw,cvh)
		graphics.setCanvas(outcv)
		--graphics.draw(bg)
		local cw=math.floor((cvw/2)-(tw/2))
		for l in text:gmatch(".") do
			local c=letters[l]
			graphics.draw(c.draw,cw,math.floor((cvh/2)-((texth-1)/2)))
			cw=cw+c.width
		end
		graphics.setCanvas()
		local o=""
		math.randomseed(os.time())
		for l1=1,5 do
			o=o..string.char((math.random(0x41,0x59)+(math.random(0,1)*0x20)))
		end
		outcv:getImageData():encode(o..".png")
		print("done "..o)
	end)
	if not r then
		print("error "..err)
	end
	love.event.quit()
end
