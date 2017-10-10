local CustomFactionsConfig = {}
CustomFactionsConfig.Author = "Ralle030583"
CustomFactionsConfig.version = "[0.0.3]"
CustomFactionsConfig.ModName = "[CustomFactions]"
CustomFactionsConfig.pauseTime = 10 -- Pausetime after events in minutes

-- Shipclasses according to vanilla shiputility
CustomFactionsConfig.CLASS.MILITARY.SCOUT = 0
CustomFactionsConfig.CLASS.MILITARY.SENTINEL = 1
CustomFactionsConfig.CLASS.MILITARY.HUNTER = 2
CustomFactionsConfig.CLASS.MILITARY.FRIGATE = 3
CustomFactionsConfig.CLASS.MILITARY.CRUISER = 4
CustomFactionsConfig.CLASS.MILITARY.DESTROYER = 5
CustomFactionsConfig.CLASS.MILITARY.DREADNOUGHT = 6
CustomFactionsConfig.CLASS.MILITARY.BATTLESHIP = 7
CustomFactionsConfig.CLASS.CIVIL.TRADER = 8
CustomFactionsConfig.CLASS.CIVIL.MERCHANT = 9
CustomFactionsConfig.CLASS.CIVIL.SALESMAN = 10

-- Factions
CustomFactionsConfig.factions = {"Khillmarr", "ExampleFaction"}

-- Ships per Factions
CustomFactionsConfig.ships["Khillmarr"][CustomFactionsConfig.CLASS.MILITARY.SENTINEL]
  = {{title = "Dagger Corvette" , plan = "mods/CustomFactions/plans/khillmarr/KhillmarrDaggerCorvette_1.xml", scale = 1.0}}
CustomFactionsConfig.ships["Khillmarr"][CustomFactionsConfig.CLASS.MILITARY.HUNTER]
  = {{title = "Light Destroyer" , plan = "mods/CustomFactions/plans/khillmarr/KhillmarrLightDestroyer_2.xml", scale = 1.0}}
CustomFactionsConfig.ships["Khillmarr"][CustomFactionsConfig.CLASS.MILITARY.FRIGATE]
  = {{title = "Light Cruiser" , plan = "mods/CustomFactions/plans/khillmarr/KhillmarrLightCruiserPride_3.xml", scale = 1.0}}
CustomFactionsConfig.ships["Khillmarr"][CustomFactionsConfig.CLASS.MILITARY.CRUISER]
  = {{title = "Light Cruiser MK II" , plan = "mods/CustomFactions/plans/khillmarr/KhillmarrLightCruiserMK2_4_5.xml", scale = 1.0}}
CustomFactionsConfig.ships["Khillmarr"][CustomFactionsConfig.CLASS.MILITARY.DESTROYER]
  = {{title = "Cruiser MK II" , plan = "mods/CustomFactions/plans/khillmarr/KhillmarrLightCruiserMK2_4_5.xml", scale = 1.5}}

CustomFactionsConfig.ships["ExampleFaction"][CustomFactionsConfig.CLASS.MILITARY.FRIGATE] =
    { {title = "Example Frigatte A" , plan = "mods/CustomFactions/plans/khillmarr/KhillmarrDaggerCorvette_1.xml", scale = 1.0},
      {title = "Example Frigatte B" , plan = "mods/CustomFactions/plans/khillmarr/KhillmarrDaggerCorvette_1.xml", scale = 1.0},
      {title = "Example Frigatte C" , plan = "mods/CustomFactions/plans/khillmarr/KhilälmarrDaggerCorvette_1.xml", scale = 1.0}
  }

-- Custom events, currently only attacks with Faction and then shipcompositon
CustomFactionsConfig.customEvents = {
  {schedule = random():getInt(25, 50) * 60, script = "mods/CustomFactions/scripts/player/customAttack",
    arguments = {"Khillmarr", {CustomFactionsConfig.CLASS.MILITARY.SENTINEL,
                               CustomFactionsConfig.CLASS.MILITARY.SENTINEL,
                               CustomFactionsConfig.CLASS.MILITARY.SENTINEL}},
    minimum = 5 * 60, from = 0, to = 500},
  {schedule = random():getInt(35, 70) * 60, script = "mods/CustomFactions/scripts/player/customAttack",
    arguments = {"Khillmarr", {CustomFactionsConfig.CLASS.MILITARY.SENTINEL,
                               CustomFactionsConfig.CLASS.MILITARY.FRIGATE,
                               CustomFactionsConfig.CLASS.MILITARY.FRIGATE,
                               CustomFactionsConfig.CLASS.MILITARY.SENTINEL}},
    minimum = 25 * 60, to = 500},
  {schedule = random():getInt(60, 80) * 60, script = "mods/CustomFactions/scripts/player/customAttack",
   arguments = {"Khillmarr", {CustomFactionsConfig.CLASS.MILITARY.SENTINEL,
                              CustomFactionsConfig.CLASS.MILITARY.HUNTER,
                              CustomFactionsConfig.CLASS.MILITARY.FRIGATE,
                              CustomFactionsConfig.CLASS.MILITARY.CRUISER,
                              CustomFactionsConfig.CLASS.MILITARY.FRIGATE,
                              CustomFactionsConfig.CLASS.MILITARY.HUNTER,
                              CustomFactionsConfig.CLASS.MILITARY.SENTINEL}},
   minimum = 60 * 60, to = 350},
  {schedule = random():getInt(80, 120) * 60, script = "mods/CustomFactions/scripts/player/customAttack",
  arguments = {"Khillmarr", {CustomFactionsConfig.CLASS.MILITARY.SENTINEL,
                             CustomFactionsConfig.CLASS.MILITARY.HUNTER,
                             CustomFactionsConfig.CLASS.MILITARY.FRIGATE,
                             CustomFactionsConfig.CLASS.MILITARY.CRUISER,
                             CustomFactionsConfig.CLASS.MILITARY.DESTROYER,
                             CustomFactionsConfig.CLASS.MILITARY.CRUISER,
                             CustomFactionsConfig.CLASS.MILITARY.FRIGATE,
                             CustomFactionsConfig.CLASS.MILITARY.HUNTER,
                             CustomFactionsConfig.CLASS.MILITARY.SENTINEL}},
   minimum = 120 * 60, to = 300},
}
return CustomFactionsConfig
