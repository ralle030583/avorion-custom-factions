--For EXTERNAL configuration files
exsist, CustomFactionsConfig = pcall(require, 'mods/CustomFactions/config/CustomFactionsConfig')

function EventSheduler.addCustomEvents(events)
  if exsists then
    -- TODO READ FROM CONFIG
    events.insert({schedule = random():getInt(25, 50) * 60, script = "mods/CustomFactions/scripts/player/khillmarrattack", arguments = {0}, minimum = 5 * 60, from = 0, to = 500})
    events.insert({schedule = random():getInt(35, 70) * 60, script = "mods/CustomFactions/scripts/player/khillmarrattack", arguments = {1}, minimum = 25 * 60, to = 500})
    events.insert({schedule = random():getInt(60, 80) * 60, script = "mods/CustomFactions/scripts/player/khillmarrattack", arguments = {2}, minimum = 60 * 60, to = 350})
    events.insert({schedule = random():getInt(80, 120) * 60, script = mods/CustomFactions/scripts/player/khillmarrattack", arguments = {3}, minimum = 120 * 60, to = 300})
  end
  return events
end

function EventSheduler.getCustomPauseTime()
  if exsist then
    return CustomFactionsConfig.pauseTime
  else
    return 5 -- default vanilla setting
  end
end
