function FiveCloud:InitGameMode()
  

    SendToServerConsole("sever five_cloud init")




    -- 模块化的监听了各个阶段，但是没做任何操作(只做了不选英雄就随机选)
    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(FiveCloudGameEvent, "OnGameRulesStateChange"),
        FiveCloudGameEvent) -- 监听游戏进程


    -- 核心监听；游戏配置生效的部分
    CustomGameEventManager:RegisterListener("five_cloud_custom_event", Dynamic_Wrap(FiveCloudCustomEvent, "Index"))
    CustomGameEventManager:RegisterListener("five_cloud_system_event", Dynamic_Wrap(FiveCloudSystemEvent, "Index"))

    if IsInToolsMode() then
        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("collectgarbage"), function()
            local m = collectgarbage('count')
            FiveCloudSDK:Print(string.format("%.3f KB  %.3f MB", m, m / 1024), "Lua Memory")
            return 60
        end, 0)

    end
end

