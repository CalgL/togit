if not FiveCloudGameEvent then
    FiveCloudGameEvent = class({})
end

function FiveCloudGameEvent:OnGameRulesStateChange(e)
    FiveCloudSDK:Print(e, "OnGameRulesStateChange")
    local game_state = GameRules:State_Get()
    --------------------- 设置队伍阶段 ---------------------
    if game_state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
        GameState:GameStateCustomGameSetup()
        --------------------- 选择英雄阶段 ---------------------
    elseif game_state == DOTA_GAMERULES_STATE_HERO_SELECTION then
        GameState:GameStateHeroSelection()
        ----------------------- 决策阶段 -----------------------
    elseif game_state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
        GameState:GameStateStrategyTime()
        --------------------- 队伍展示阶段 ---------------------
    elseif game_state == DOTA_GAMERULES_STATE_TEAM_SHOWCASE then
        GameState:GameStateTeamShowcase()
        ------------------- 等待地图加载阶段 -------------------
    elseif game_state == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD then
        GameState:GameStateWaitForMapToLoad()
        ----------------------- 预备阶段 -----------------------
    elseif game_state == DOTA_GAMERULES_STATE_PRE_GAME then
        GameState:GameStatePreGame()
        ----------------------- 开始游戏 -----------------------
    elseif game_state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameState:GameStateInProgress()
        ----------------------- 游戏结束 -----------------------
    elseif game_state == DOTA_GAMERULES_STATE_POST_GAME then
        GameState:GameStatePostGame()
    end
end




