local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")

function init()
	config.MakeCommand("cfmt",cfmt,config.NoComplete)
	config.TryBindKey("Alt-z","command:cfmt",true)
end

function onSave(bp)
	cfmt(bp)
end

function cfmt(bp)
	if bp.Buf:FileType() == "c" or bp.Buf:FileType() == "h" then
		bp:Save()
		local _,err = shell.RunCommand("c_formatter_42 < ".. bp.Buf.Path)
		if err ~= nil then
			micro.InfoBar():Error(err)
			return
		end
		bp.Buf:ReOpen()
	end
end
