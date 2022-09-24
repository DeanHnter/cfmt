local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")
micro.Log("Loaded")

function onSave(bp)
	cfmt(bp)
end

function cfmt(bp)
	if bp.Buf:FileType() == "c" then
		bp:Save()
		local _,err = shell.RunCommand("c_formatter_42 < ".. bp.Buf.Path)
		if err ~= nil then
			micro.InfoBar():Error(err)
			return
		end
		bp.Buf:ReOpen()
	end
end

function init()
	config.MakeCommand("cfmt",gofmt,config.NoComplete)
end
