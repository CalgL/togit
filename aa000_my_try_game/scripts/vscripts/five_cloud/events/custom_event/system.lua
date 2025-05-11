function FiveCloudCustomEvent:OnJsCompleted(e)




    if Convars:GetBool("dota_ability_debug") then
        CustomGameEventManager:Send_ServerToAllClients("UpdateServerStatus", {
            name = "FreeSpells",
            data = true
        })
    end
    
    

end

-- 发送控制台命令
function FiveCloudCustomEvent:SendToServerConsole(e)
    FiveCloudSDK:Print(e,'SendToServerConsole')
    if GameRules:IsCheatMode() then
        SendToServerConsole(e.command)
    else
        FiveCloudSDK:Message("#NotIsCheatMode", e.playerid, "error")
    end
end
