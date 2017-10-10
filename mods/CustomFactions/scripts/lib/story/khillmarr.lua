package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

require ("randomext")
require ("utility")
require ("stringutility")
require ("planutility")
require ("defaultscripts")
local FighterGenerator = require ("fightergenerator")
local TurretGenerator = require ("turretgenerator")
local UpgradeGenerator = require ("upgradegenerator")
local ShipUtility = require ("shiputility")
local PlanGenerator = require ("plangenerator")


local Khillmarr = {}

function Khillmarr.getFaction()
    local name = "The Khillmarr Pirates"%_T

    local galaxy = Galaxy()
    local faction = galaxy:findFaction(name)
    if faction == nil then
        faction = galaxy:createFaction(name, 0, 0)
        faction.initialRelations = -100000
        faction.initialRelationsToPlayer = 0
        faction.staticRelationsToPlayers = true

        for trait, value in pairs(faction:getTraits()) do
            faction:setTrait(trait, 0) -- completely neutral / unknown
        end
    end

    return faction
end

function Khillmarr.createShip(position, shipSize)
    position = position or Matrix()
    local volume = Balancing_GetSectorShipVolume(Sector():getCoordinates())

    volume = (shipSize or 1)

    local x, y = Sector():getCoordinates()
    local probabilities = Balancing_GetMaterialProbability(x, y)
    local material = Material(getValueFromDistribution(probabilities))
    local sector = Sector()
    local distFromCenter = length(vec2(x, y))

    if material.value == 6 and distFromCenter > Balancing_GetBlockRingMin() then
          material.value = 5
    end

    local faction = Khillmarr.getFaction()

	-- assign Different Blueprint according to size, pherhaps later with
  -- real volume volume and blueprints are in the config
	local s = 1.0
	local title = "ship"

	if volume == 1 then
	    plan = LoadPlanFromFile("data/plans/khillmarr/KhillmarrDaggerCorvette_1.xml")
		title = "Khillmarr Dagger Corvette"
	elseif volume == 2 then
		plan = LoadPlanFromFile("data/plans/khillmarr/KhillmarrLightDestroyer_2.xml")
		title = "Khillmarr Light Destroyer"
	elseif 	volume == 3 then
		plan = LoadPlanFromFile("data/plans/khillmarr/KhillmarrLightCruiserPride_3.xml")
		title = "Khillmarr Light Cruiser"
	elseif 	volume == 4 then
		plan = LoadPlanFromFile("data/plans/khillmarr/KhillmarrLightCruiserMK2_4_5.xml")
		title = "Khillmarr Light Cruiser MK II"
	elseif 	volume == 5 then
		plan = LoadPlanFromFile("data/plans/khillmarr/KhillmarrLightCruiserMK2_4_5.xml")
		title = "Khillmarr Cruiser"
		s = 1.5
	end

	plan:scale(vec3(s, s, s))

    if material.value > 0 then
      plan:setMaterial(Material(material.value-1))
    end
    plan:setMaterial(material)
    local ship = Sector():createShip(faction, "", plan, position)

    -- Khillmarr have random turrets, but a bit more then Xsotan (*0.75 => * 1)
    TurretGenerator.initialize(random():createSeed())
    local turret = TurretGenerator.generateArmed(x, y)
    local numTurrets = math.max(2, Balancing_GetEnemySectorTurrets(x, y) * 1) -- *.75 => * 1

    ShipUtility.addTurretsToCraft(ship, turret, numTurrets)
    ship:setTitle("${ship }", {ship = title})
    ship.crew = ship.minCrew
    ship.shieldDurability = ship.shieldMaxDurability

    AddDefaultShipScripts(ship)

    ship:addScript("ai/patrol.lua")
    ship:addScript("story/khillmarrbehaviour.lua")
    ship:setValue("is_Khillmarr", 1)

    return ship
end

return Khillmarr
