

-- 获取当前技能
function FiveCloudCustomEvent:GetAbilityList(e)
    FiveCloudSDK:Print('123GetAbilityList')
    local ent = e.ent
    local unit
    if ent then
        unit = EntIndexToHScript(ent)
    else
        unit = PlayerResource:GetPlayer(e.playerid):GetAssignedHero()
    end
    local count = unit:GetAbilityCount()
    local abilityList = {}
    for i = 0, count - 1 do
        local ability = unit:GetAbilityByIndex(i)
        if ability then
            local entindex = ability:GetEntityIndex()
            table.insert(abilityList, entindex)
        end
    end
    GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("GetAbilityList"), function()
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(e.playerid), "RefreshServerAbility", {
            abilityList = abilityList
        })
    end, 0.3)
end
