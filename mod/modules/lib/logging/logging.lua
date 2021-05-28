-- Logging - Utility to help classify and deterministically print output
-- Uses LuaLogging, http://neopallium.github.io/lualogging/manual.html, as inspiration
-- The module does not work well with Civ 6, hence the wrapper

DEBUG = "DEBUG"
INFO = "INFO"
WARN = "WARN"
ERROR = "ERROR"
FATAL = "FATAL"

local LEVEL = {"DEBUG", "INFO", "WARN", "ERROR", "FATAL"}
local MAX_LEVELS = #LEVEL
local CURR_LEVEL = "DEBUG"
-- translate levels to ints
for i=1,MAX_LEVELS do
    LEVEL[LEVEL[i]] = i
end


Logging = {
    LEVEL = {field = "LEVEL", default = DEBUG}
}
Logging.__index = Logging

local function VALID_LOG_LEVEL(level)
    if not level then
        return false
    end

    currLevel = Logging:GetLevel()
    currOrder = LEVEL[currLevel]
    testOrder = LEVEL[level]
    if not testOrder then
        return false
    end

    return testOrder >= currOrder 
end

-- assuming fmt is a string
local function LOG_MSG(self, level, fmt, ...)
    if not VALID_LOG_LEVEL(level) then
        return
    end

    if select("#", ...) > 0 then
        stringList = {}
        for _, v in pairs({...}) do
            if type(v) == "string" then
                table.insert(stringList, v)
            else
                table.insert(stringList, tostring(v))
            end
        end

        return self:print(level, string.format(fmt, unpack(stringList)))
    end 

    return self:print(level, fmt)
end

local LEVEL_FUNCS = {}
for i=1, MAX_LEVELS do
    local level = LEVEL[i]
    LEVEL_FUNCS[i] = function(self, ...)
        return LOG_MSG(self, level, ...)
    end
end

-- improved assertion funciton.
local function assert(exp, ...)
    -- if exp is true, we are finished so don't do any processing of the parameters
    if exp then return exp, ... end
    -- assertion failed, raise error
    error(string.format(...), 2)
end

function Logging:New(prefix)
    local logger = {}
    logger.prefix = prefix
    logger.print = function(self, level, msg)
        local prefix = self.name
        if not prefix then
            prefix = ""
        end

        print(string.format("%s[%s]: %s", prefix, tostring(level), msg))
    end

    -- enable/disable levels
    for i=1,MAX_LEVELS do
        local name = LEVEL[i]:lower()
        logger[name] = LEVEL_FUNCS[i]
    end
    

    -- generic log function.
    logger.log = function (self, level, ...)
        return LOG_MSG(self, level, ...)
    end

    logger.object = function (self, obj)
        if type(obj) == "table" or type(obj) == "struct" then
            for k, v in pairs(obj) do
                self:debug("key [%s] value [%s]", k, v)
            end
        elseif type(obj) == "uerdata" then
            self:object(getmetatable(obj))
        end
    end

    logger.metaObject = function (self, obj)
        self.object(getmetatable(obj).__index)
    end

    -- initialize log level
    return logger
end

function Logging:SetLevel(newLvl)
    local order = LEVEL[newLvl]
    assert(order, "undefined level [%s]", tostring(newLvl))

    CURR_LEVEL = newLvl
end

function Logging:GetLevel()
    return CURR_LEVEL
end