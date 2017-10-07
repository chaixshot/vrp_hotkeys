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
pointing = false

-- YOU ARE ON A CLIENT SCRIPT ( Just reminding you ;) )
-- Keys IDs can be found at https://wiki.fivem.net/wiki/Controls

-- Hotkeys Configuration: cfg.hotkeys = {[Key] = {group = 1, pressed = function() end, released = function() end},}
cfg.hotkeys = {
  [73] = {
    -- X Toggle HandsUp
    group = 1, 
	pressed = function() 
      --if not IsPauseMenuActive() and not IsPedInAnyVehicle(player, true) then -- Uncomment to block use in vehicle
	  handsup = not handsup
	  SetEnableHandcuffs(player, handsup)
	  if handsup then
	    vRP.playAnim({true,{{"random@mugging3", "handsup_standing_base", 1}},true})
	  else
	    vRP.stopAnim({true})
		SetPedStealthMovement(player,false,"") 
	  end
	  --end -- Uncomment to block use in vehicle
	end,
	released = function()
	  --[[ Remove the []s to use on hold
      --if not IsPauseMenuActive() and not IsPedInAnyVehicle(player, true) then -- Uncomment to block use in vehicle
	  handsup = not handsup
	  vRP.stopAnim({true})
	  SetPedStealthMovement(player,false,"") 
	  --end -- Uncomment to block use in vehicle
	  ]]
	end,
  },
  [29] = {
    -- Hold B to Point
    group = 1, 
	pressed = function() 
      --if not IsPauseMenuActive() and not IsPedInAnyVehicle(player, true) then -- Uncomment to block use in vehicle
	  pointing = not pointing
	  SetEnableHandcuffs(player, pointing)
	  if pointing then
	    vRP.playAnim({true,{{"oddjobs@hunter", "point_fwd", 1}},true})
	  else
	    vRP.stopAnim({true})
		SetPedStealthMovement(player,false,"") 
	  end
	  --end -- Uncomment to block use in vehicle
	end,
	released = function()
	  -- Remove the []s to use on hold
      --if not IsPauseMenuActive() and not IsPedInAnyVehicle(player, true) then -- Uncomment to block use in vehicle
	  pointing = not pointing
	  vRP.stopAnim({true})
	  SetPedStealthMovement(player,false,"") 
	  --end -- Uncomment to block use in vehicle
	  
	end,
  },
  [36] = {
    --CTRL for Crouch
    group = 0, 
	pressed = function() 
      if not IsPauseMenuActive() and not IsPedInAnyVehicle(player, true) then 
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
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
}