local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")
vRPhk = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_hotkeys")
HKclient = Tunnel.getInterface("vrp_hotkeys","vrp_hotkeys")
Tunnel.bindInterface("vrp_hotkeys",vRPhk)
-- USE FOR NECESSARY SERVER FUNCTIONS

function vRPhk.test(msg)
  print("msg "..msg.." received from "..source)
  return 42
end

local player_lists = {}
function vRPhk.openUserList()
  local player = source
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    if player_lists[player] then -- hide
      player_lists[player] = nil
      vRPclient.removeDiv(player,{"user_list"})
    else -- show
      local content = "ID => NICKNAME | FIRSTNAME NAME | JOB"
      local count = 0
	  local users = vRP.getUsers({})
      for k,v in pairs(users) do
        count = count+1
        local user_source = vRP.getUserSource({k})
        vRP.getUserIdentity({k, function(identity)
		  if user_source ~= nil then
            content = content.."<br />"..k.." => <span class=\"pseudo\">"..vRP.getPlayerName({user_source}).."</span>"
            if identity then
              content = content.." | <span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span> | <span class=\"job\">"..vRP.getUserGroupByType({user_id,"job"}).."</span>"
            end
          end
		  
          -- check end
          count = count-1
          if count == 0 then
            player_lists[player] = true
            local css = [[
              .div_user_list{ 
                margin: auto; 
				text-align: center;
                padding: 8px; 
                width: 650px; 
                margin-top: 80px; 
                background: black; 
                color: white; 
                font-weight: bold; 
                font-size: 1.1em;
              } 
              .div_user_list .pseudo{ 
                color: rgb(66, 244, 107);
              }
              .div_user_list .name{ 
                color: rgb(92, 170, 249);
              }
			  .div_user_list .job{ 
                color: rgb(247, 193, 93);
			  }
            ]]
            vRPclient.setDiv(player,{"user_list", css, content})
          end
		end})
      end
    end
  end
end