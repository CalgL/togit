if not FiveCloudCustomEvent then
    FiveCloudCustomEvent = class({})
    FiveCloudCustomEvent.heroListKV = LoadKeyValues('scripts/npc/npc_heroes.txt')
    FiveCloudCustomEvent.unitListKV = LoadKeyValues('scripts/npc/npc_units.txt')
    FiveCloudCustomEvent.abilityListKV = LoadKeyValues('scripts/npc/npc_abilities.txt')
    FiveCloudCustomEvent.heroListById = {}
    FiveCloudCustomEvent.heroListByName = {}
    FiveCloudCustomEvent.unitListByName = {}
    FiveCloudCustomEvent.ShowRangeDialogList = {}
end
require("five_cloud.events.custom_event.hero")
require("five_cloud.events.custom_event.kv")
require("five_cloud.events.custom_event.unit")


function FiveCloudCustomEvent:Index(e)
    FiveCloudSDK:Print(e,"FiveCloudCustomEvent")
    if type(FiveCloudCustomEvent[e.event]) == "function" then
        
        FiveCloudCustomEvent[e.event](self, e)
        
    else
        FiveCloudSDK:Message("#NoFunction event : " .. e.event, e.playerid, "error")
    end
end




