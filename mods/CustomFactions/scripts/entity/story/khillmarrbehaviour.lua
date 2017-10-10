if onServer() then

package.path = package.path .. ";data/scripts/lib/?.lua"

require ("randomext")
Balancing = require("galaxy")

function initialize()
    Sector():registerCallback("onStartFiring", "onSetToAggressive")
    Entity():registerCallback("onDestroyed", "onDestroyed")
end

function onSetToAggressive(entityId)
    local entity = Entity(entityId)
    local self = Entity()

    if entity.factionIndex ~= self.factionIndex then
        ShipAI():registerEnemyFaction(entity.factionIndex)
    end
end

function onDestroyed()
    local position = vec2(Sector():getCoordinates())

    -- TODO loot / bounty ?

end


end
