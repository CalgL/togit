-- 控制台输出
-- @param content any 内容
-- @param identifier string 标识符
-- @param showMetatable bool 输出额外内容
function FiveCloudSDK:Print(content, identifier, extra)
    if IsInToolsMode() then
        if extra == nil then
            extra = true
        end
        local result = ""
        if extra then
            if IsClient() then
                result = result .. "客户端 | "
            end
            if IsServer() then
                result = result .. "服务端 | "
            end
        end
        if identifier then
            result = result .. identifier .. " : "
        end
        local content_string = tostring(content)
        result = result .. content_string
        if type(content) == "table" then
            result = result .. "\n----------------- " .. content_string .. " start -----------------"
            local temp_str = ""
            for k, v in pairs(content) do
                result = result .. "\n" .. string.format("%-20s", k) .. " = " .. tostring(v) .. " (" .. type(v) .. ")"
            end
            result = result .. "\n------------------ " .. content_string .. " end ------------------\n"
        end
        print(result)
    end
end