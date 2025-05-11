if not FiveCloudSystemEvent then
    FiveCloudSystemEvent = class({})
end


function FiveCloudSystemEvent:Index(e)
    FiveCloudSDK:Print(e,"FiveCloudSystemEvent")
    if type(FiveCloudSystemEvent[e.event]) == "function" then
        FiveCloudSystemEvent[e.event](self, e)
    else
        FiveCloudSDK:Message("#NoFunction event : " .. e.event, e.playerid, "error")
    end
end