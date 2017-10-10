if onServer() then

package.path = package.path .. ";data/scripts/lib/?.lua"

require ("randomext")
require ("utility")

--For EXTERNAL configuration files
package.path = package.path .. ";mods/CustomFactions/config/?.lua"
MoveUIConfig = nil
exsist, CustomFactionsConfig = pcall(require, 'CustomFactionsConfig')

-- Vanilla events , own events are added in EventSheduler.addCustomWaves();
local events =
{
    {schedule = random():getInt(45, 60) * 60, script = "convoidistresssignal", arguments = {true}, to = 560},
    {schedule = random():getInt(60, 80) * 60, script = "fakedistresssignal", arguments = {true}, to = 560},
    {schedule = random():getInt(60, 80) * 60, script = "pirateattackstarter", to = 560},
    {schedule = random():getInt(60, 80) * 60, script = "traderattackedbypiratesstarter", to = 560},
    {schedule = random():getInt(25, 50) * 60, script = "alienattack", arguments = {0}, minimum = 5 * 60, from = 0, to = 500},
    {schedule = random():getInt(35, 70) * 60, script = "alienattack", arguments = {1}, minimum = 25 * 60, to = 500},
    {schedule = random():getInt(60, 80) * 60, script = "alienattack", arguments = {2}, minimum = 60 * 60, to = 350},
    {schedule = random():getInt(80, 120) * 60, script = "alienattack", arguments = {3}, minimum = 120 * 60, to = 300},
    {schedule = random():getInt(50, 70) * 60, script = "spawntravellingmerchant", to = 520},
}

local pause = CustomFactionsConfig.pauseTime * 60
local pauseTime = pause

-- Don't remove or alter the following comment, it tells the game the namespace this script lives in. If you remove it, the script will break.
-- namespace EventScheduler
EventScheduler = {}

function EventScheduler.initialize()
    -- adding custom events to the vanilla ones
    events = addCustomEvents(events)

    for _, event in pairs(events) do
        event.time = (event.minimum or 5 * 60) + math.random() * event.schedule
    end

    local frequency = 0
    for _, event in pairs(events) do
        frequency = frequency + 1 / event.schedule
    end

    print ("player events roughly every " .. round((1 / frequency + pause) / 60, 2) .. " minutes")
end

funciton EventSheduler.addCustomEvents(events)

  -- TODO READ FROM CONFIG
  events.insert({schedule = random():getInt(25, 50) * 60, script = "khillmarrattack", arguments = {0}, minimum = 5 * 60, from = 0, to = 500})
  events.insert({schedule = random():getInt(35, 70) * 60, script = "khillmarrattack", arguments = {1}, minimum = 25 * 60, to = 500})
  events.insert({schedule = random():getInt(60, 80) * 60, script = "khillmarrattack", arguments = {2}, minimum = 60 * 60, to = 350})
  events.insert({schedule = random():getInt(80, 120) * 60, script = "khillmarrattack", arguments = {3}, minimum = 120 * 60, to = 300})

  return events
end

function EventScheduler.updateServer(timeStep)
    local player = Player()

    local x, y = Sector():getCoordinates()
    if x == 0 and y == 0 then return end

    -- timeStep = timeStep * 60

    -- only run script for the lowest player index in the sector -> no stacking events
    local players = {Sector():getPlayers()}
    for _, p in pairs(players) do
        -- when there is a player with a lower index, we return
        if p.index < player.index then return end
    end

    -- but, if we're not alone, we speed up events by 50%
    if #players > 1 then timeStep = timeStep * 1.5 end

    if pauseTime > 0 then
        pauseTime = pauseTime - timeStep
        return
    end

    -- update times of events
    for _, event in pairs(events) do
        event.time = event.time - timeStep

        if event.time < 0 then
            -- check if the location is OK
            local from = event.from or 0
            local to = event.to or math.huge

            local position = length(vec2(Sector():getCoordinates()))
            if position >= from and position <= to then
                -- start event
                local arguments = event.arguments or {}
                Player():addScriptOnce(event.script, unpack(arguments))
                event.time = event.schedule

                print ("starting event " .. event.script)

                pauseTime = pause

                break;
            end
        end
    end

end


function EventScheduler.secure()
    local times = {}

    for _, event in pairs(events) do
        table.insert(times, event.time)
    end

    return times
end

function EventScheduler.restore(times)
    for i = 1, math.min(#times, #events) do
        events[i].time = times[i]
    end
end


end
