-- 重置英雄
function FiveCloudCustomEvent:ResetHero(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent:IsHero() and ent:IsAlive() and not ent:IsClone() then
            FiveCloudCustomEvent:DoResetHero(ent)
        end
    end
    FiveCloudCustomEvent:GetAbilityList(e)
end

-- 重置英雄技能
function FiveCloudCustomEvent:DoResetHero(unit)
    PlayerResource:ReplaceHeroWithNoTransfer(unit:GetPlayerID(), PlayerResource:GetSelectedHeroName(unit:GetPlayerID()),
        PlayerResource:GetGold(unit:GetPlayerID()), 0)
    FiveCloudCustomEvent:RemoveHero(unit)
end

-- 复活英雄
function FiveCloudCustomEvent:RespawnHero(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent:IsHero() and not ent:IsClone() then
            if ent:IsAlive() then
                FiveCloudSDK:Message("#RespawnHeroError1", e.playerid, "error")
            else
                ent:RespawnHero(false, false)
            end
        else
            FiveCloudSDK:Message("#RespawnHeroError2", e.playerid, "error")
        end
    end
end

-- 更换英雄
function FiveCloudCustomEvent:ReplaceHero(e)
    for key, entIndex in pairs(e.selectedUnits) do
        local ent = EntIndexToHScript(entIndex)
        if ent:IsHero() and not ent:IsClone() then
            local hero = PlayerResource:ReplaceHeroWith(ent:GetPlayerID(),
                "npc_dota_hero_" .. DOTAGameManager:GetHeroNameByID(e.heroid), PlayerResource:GetGold(e.playerid), 0)
        end
    end
    FiveCloudCustomEvent:GetAbilityList(e)
end



-- 添加英雄
function FiveCloudCustomEvent:AddHero(e)
    local player = PlayerResource:GetPlayer(e.playerid)
    local heroName = "npc_dota_hero_" .. DOTAGameManager:GetHeroNameByID(e.heroid)
    local team = PlayerResource:GetTeam(e.playerid)
    local hero = player:GetAssignedHero()
    local team_target = team
    if e.isFriend == 0 then
        if team == DOTA_TEAM_GOODGUYS then
            team_target = DOTA_TEAM_BADGUYS
        end
        if team == DOTA_TEAM_BADGUYS then
            team_target = DOTA_TEAM_GOODGUYS
        end
    end

    DebugCreateUnit(player, heroName, team_target, false, function(unit)
        unit:SetControllableByPlayer(e.playerid, false)
    end)
end






-- 添加技能
function FiveCloudCustomEvent:AddAbility(e)
    Omg:AddAbility(e.playerid, e.replaceHeroid, e.abilityname)
    -- 服务端申请刷新一下英雄的技能，应该是同步
    FiveCloudCustomEvent:GetAbilityList(e)
end

-- 删除技能
function FiveCloudCustomEvent:RemoveAbility(e)
    Omg:RemoveAbility(e.playerid, e.replaceHeroid, e.abilityname)
    FiveCloudCustomEvent:GetAbilityList(e)

end

-- 交换技能
function FiveCloudCustomEvent:SwapAbility(e)
    FiveCloudSDK.Print("123server SwapAbility")
    FiveCloudSDK.Print(e.replaceHeroid)

    local hero = EntIndexToHScript(e.replaceHeroid)
    hero:SwapAbilities(e.ability1, e.ability2, true, true)
    FiveCloudCustomEvent:GetAbilityList(e)
end

function FiveCloudCustomEvent:RemoveHero(unit)
    if unit:HasAbility("monkey_king_wukongs_command") then
        local heroName = unit:GetClassname()
        local ents = Entities:FindAllByClassname(heroName)
        for k, ent in pairs(ents) do
            if ent:HasModifier("modifier_monkey_king_fur_army_soldier") then
                ent:RemoveSelf()
            end
        end
    end
    unit:Destroy()
end

