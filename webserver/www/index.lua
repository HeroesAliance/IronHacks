local fonts={
	["http://puu.sh/ggOw2.png"]="text.png",
	["http://puu.sh/ggOzH.png"]="text2.png",
	["http://puu.sh/ggOBh.png"]="text3.png",
	["http://puu.sh/ggOBY.png"]="text4.png",
	["http://puu.sh/ggOCA.png"]="text5.png",
	["http://puu.sh/ggPKP.png"]="text6.png",
	["http://puu.sh/ggOGn.png"]="text7.png",
	["http://puu.sh/ggOIb.png"]="text8.png",
}
local cfont=get.font or "text8.png"
print([[
	<html>
		<head>
			<title>Logo generator</title>
			<link rel="stylesheet" type="text/css" href="style.css"/>
			<link rel="shortcut icon" type="image/ico" href="http://puu.sh/ggJOs.ico"/>
		</head>
		<body>
			<div id="main">
				<div id="logo">
					<img src="]]..(get.text and ("http://ptoast.tk/genlogo.lua?t="..urlencode(cfont..","..(get.text or ""))) or "http://puu.sh/ggISI.png")..[["/>
				</div>
				<div id="input">
					<form action="index.lua">
						<input type="text" name="text" value="]]..htmlencode(get.text or "")..[[" style="font-size:20px;">
						<input type="hidden" name="font" value="]]..htmlencode(cfont)..[[">
						<input type="submit" value="Submit" style="font-size:20px;"/>
					</form>
				</div>
				<div id="fonts"/>]])
					local n=0
					for k,v in pairs(fonts) do
						n=n+1
						print([[
						<a href="index.lua?font=]]..v..[[&text=]]..urlencode(get.text or "")..[[">
							<div class="]]..(v==cfont and "clfont" or "font")..[[">
								<img width=200 height=200 src="]]..k..[["/>
							</div>
						</a>]])
					end
					print([[
				</div>
				<div id="copyright">
					Copyright (c) 2015
				</div>
			</div>
		</body>
	</html>
]])
