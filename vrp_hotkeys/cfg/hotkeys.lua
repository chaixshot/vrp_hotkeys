-- TUNNEL AND PROXY
cfg = {}
vRPhk = {}
Tunnel.bindInterface("vrp_hotkeys",vRPhk)
vRPserver = Tunnel.getInterface("vRP","vrp_hotkeys")
HKserver = Tunnel.getInterface("vrp_hotkeys","vrp_hotkeys")
vRP = Proxy.getInterface("vRP")

-- GLOBAL VARIABLES
player = GetPlayerPed(-1)
handsup = false

-- YOU ARE ON A CLIENT SCRIPT ( Just reminding you ;) )
-- Keys IDs can be found at https://wiki.fivem.net/wiki/Controls

-- Hotkeys Configuration: cfg.hotkeys = {[Key] = {group = 1, pressed = function() end, released = function() end},}
cfg.hotkeys = {
  [323] = {
    -- X toggle HandsUp as Example!
    group = 1, 
	pressed = function() 
	  handsup = not handsup
	  SetEnableHandcuffs(player, handsup)
	  if handsup then
	    vRP.playAnim({true,{{"random@mugging3", "handsup_standing_base", 1}},true})
	  else
	    vRP.stopAnim({true})
		SetPedStealthMovement(player,false,"") 
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
}
