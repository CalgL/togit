function App:Init()



    -- 注册app_event事件，callback函数 AppEvent:Index?  AppEvent在哪定义的？
    -- AppEvent 在events/custom_event/index中定义的
    CustomGameEventManager:RegisterListener("app_event", Dynamic_Wrap(AppEvent, "Index"))

    -- 获取游戏模式的实体，并设置了一个过滤器; 获取游戏实体时增加一个过滤器， 过滤器Filter在APP/filter中定义
    GameRules:GetGameModeEntity():SetModifierGainedFilter(Dynamic_Wrap(Filter, "ModifierGainedFilter"), Filter)
end

function App:Precache(context)
    local kv_files = {"scripts/npc/npc_units_custom.txt", "scripts/npc/npc_abilities_custom.txt",
                        "scripts/npc/npc_heroes_custom.txt", "scripts/npc/npc_items_custom.txt",
                        "scripts/npc/npc_heroes.txt", "scripts/npc/npc_abilities.txt"}
    -- 递归遍历这些文件，把英雄所需的资源文件都预加载上
    FiveCloudSDK:PrecacheEveryThingFromKV(context, kv_files)
end

