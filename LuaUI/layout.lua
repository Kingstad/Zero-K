--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    layout.lua
--  brief:   dummy and default LayoutButtons() routines
--  author:  Dave Rodgers
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  ConfigLayoutHandler(data) is defined at the end of this file.
--
--    data ==  true:  use DefaultHandler
--    data == false:  use DummyHandler
--    data ==  func:  use the provided function
--    data ==   nil:  use Spring's default control panel
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local showPanelLabel = false


-- for DefaultHandler
local FrameTex   = "bitmaps/icons/frame_slate_128x96.png"
local FrameScale = "&0.1x0.1&"
local PageNumTex = "bitmaps/circularthingy.tga"

local PageNumCmd = {
	name    = "1",
	texture = PageNumTex,
	tooltip = "Active Page Number\n(click to toggle buildiconsfirst)",
	actions = { "buildiconsfirst", "firstmenu" }
}


--------------------------------------------------------------------------------

local function DummyHandler(xIcons, yIcons, cmdCount, commands)
	
	widgetHandler.commands   = commands
	widgetHandler.commands.n = cmdCount
	widgetHandler:CommandsChanged()
	
	return "", xIcons, yIcons, {}, {}, {}, {}, {}, {}, {}, {}
end


--------------------------------------------------------------------------------

local function DefaultHandler(xIcons, yIcons, cmdCount, commands)
	
	widgetHandler.commands   = commands
	widgetHandler.commands.n = cmdCount
	widgetHandler:CommandsChanged()
	
	-- FIXME: custom commands
	if (cmdCount <= 0) then
		return "", xIcons, yIcons, {}, {}, {}, {}, {}, {}, {}, {}
	end
	
	local menuName = ''
	local removeCmds = {}
	local customCmds = widgetHandler.customCommands
	local onlyTexCmds = {}
	local reTexCmds = {}
	local reNamedCmds = {}
	local reTooltipCmds = {}
	local reParamsCmds = {}
	local iconList = {}
	
	local cmdsFirst = (commands[1].id >= 0)
	
	if (showPanelLabel) then
		if (cmdsFirst) then
			menuName = 'Commands'
		else
			menuName = 'Build Orders'
		end
	end

	local ipp = (xIcons * yIcons)  -- iconsPerPage

	local prevCmd = cmdCount - 1
	local nextCmd = cmdCount - 0
	local prevPos = ipp - xIcons
	local nextPos = ipp - 1
	if (prevCmd >= 1) then reTexCmds[prevCmd] = FrameTex end
	if (nextCmd >= 1) then reTexCmds[nextCmd] = FrameTex end
	
	local pageNumCmd = -1
	local pageNumPos = (prevPos + nextPos) / 2
	if (xIcons > 2) then
		local activePage = activePage or 0
		local pageNum = '' .. (activePage + 1) .. ''
		PageNumCmd.name = '   ' .. pageNum .. '   '
		table.insert(customCmds, PageNumCmd)
		pageNumCmd = cmdCount + 1
	end
	
	local pos = 0;
	local firstSpecial = (xIcons * (yIcons - 1))
	
	for cmdSlot = 1, (cmdCount - 2) do
		
		-- fill the last row with special buttons
		while ((pos % ipp) >= firstSpecial) do
			pos = pos + 1
		end
		local onLastRow = (math.abs(pos % ipp) < 0.1)
		
		if (onLastRow) then
			local pageStart = math.floor(ipp * math.floor(pos / ipp))
			if (pageStart > 0) then
				iconList[prevPos + pageStart] = prevCmd
				iconList[nextPos + pageStart] = nextCmd
				if (pageNumCmd > 0) then
					iconList[pageNumPos + pageStart] = pageNumCmd
				end
			end
			if (pageStart == ipp) then
				iconList[prevPos] = prevCmd
				iconList[nextPos] = nextCmd
				if (pageNumCmd > 0) then
					iconList[pageNumPos] = pageNumCmd
				end
			end
		end
		
		-- add the command icons to iconList
		local cmd = commands[cmdSlot]
		
		if ((cmd ~= nil) and (cmd.hidden == false)) then
			
			iconList[pos] = cmdSlot
			pos = pos + 1
			
			local cmdTex = cmd.texture
			if (#cmdTex > 0) then
				if (cmdTex:byte(1) ~= 38) then  --  '&' == 38
					reTexCmds[cmdSlot] = FrameScale..cmdTex..'&'..FrameTex
				end
			else
				if (cmd.id >= 0) then
					reTexCmds[cmdSlot] = FrameTex
				else
					reTexCmds[cmdSlot] = FrameScale..'#'..(-cmd.id)..'&'..FrameTex
					table.insert(onlyTexCmds, cmdSlot)
				end
			end
			
			-- FIXME: apparently this is the place to put translations
			-- for native engine commands? Needs to be looked into.
		end
	end
	
	return menuName, xIcons, yIcons, removeCmds, customCmds, onlyTexCmds, reTexCmds, reNamedCmds, reTooltipCmds, reParamsCmds, iconList
end


--------------------------------------------------------------------------------

function ConfigLayoutHandler(data)
  if (type(data) == 'function') then
    LayoutButtons = data
  elseif (type(data) == 'boolean') then
    if (data) then
      LayoutButtons = DefaultHandler
    else
      LayoutButtons = DummyHandler
    end
  elseif (data == nil) then
    LayoutButtons = nil
  end

  forceLayout = true
end


LayoutButtons = DefaultHandler


--------------------------------------------------------------------------------
