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
crouched = false

-- YOU ARE ON A CLIENT SCRIPT ( Just reminding you ;) )
-- Keys IDs can be found at https://wiki.fivem.net/wiki/Controls

-- Hotkeys Configuration: cfg.hotkeys = {[Key] = {group = 1, pressed = function() end, released = function() end},}
cfg.hotkeys = {
  [73] = {
    -- X toggle HandsUp
    group = 1, 
	pressed = function() 
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(player, true) then -- Comment to allow use in vehicle
	    handsup = not handsup
	    SetEnableHandcuffs(player, handsup)
	    if handsup then
	      vRP.playAnim({true,{{"random@mugging3", "handsup_standing_base", 1}},true})
	    else
	      vRP.stopAnim({true})
		  SetPedStealthMovement(player,false,"") 
	    end
	  end -- Comment to allow use in vehicle
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [36] = {
    -- CTRL toggle Crouch
    group = 0, 
	pressed = function() 
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(player, true) then  -- Comment to allow use in vehicle
        RequestAnimSet("move_ped_crouched")
		while not HasAnimSetLoaded("move_ped_crouched") do 
          Citizen.Wait(100)
        end 
        crouched = not crouched 
		if crouched then 
          ResetPedMovementClipset(player, 0)
        else
          SetPedMovementClipset(player, "move_ped_crouched", 0.25)
        end 
	  end -- Comment to allow use in vehicle
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  [213] = {
    -- HOME toggle User List
    group = 0, 
	pressed = function() 
	  HKserver.openUserList({})
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
}