inf = 1e309

---==[ MINE ]==---


-- LOCATION OF THE CENTER OF THE MINE
--     the y value should be set to the height
--     1 above the surface:
--
--            Y
--     ####### #######
--     ####### #######
mine_entrance = {x = -68, y = 64, z = -797}
c = mine_entrance


-- WHETHER OR NOT TURTLES NEED PAIRS
--     added this because a good number of
--     people were asking for the ability to
--     disale chunky turtles in case they
--     couldn't access the peripherals mod.
--     WARNING: not using chunky turtles will
--     result in narcoleptic turtles!
use_chunky_turtles = true


-- SPACE IN BLOCKS BETWEEN MINESHAFTS
--     too close means less chance of finding
--     ore veins, too far means longer commute
--     times for turtles.
grid_width = 6


-- MAXIMUM MINING AMOUNT PER TRIP
-- PER TURTLE
--     most efficient would be to make this
--     number huge, but turtles may be gone a
--     while (plus harder to recall).
mission_length = 150


-- MAXIMUM BLOCKS A TURTLE MINES IN A
-- SINGLE ORE VEIN
--     veins can contain multiple types of ore
--     and still count as one. also turtles will
--     continue on a vein even when their
--     inventory fills up, so this prevents them
--     losing too many rousources.
vein_max = 16


-- EXTRA FUEL FOR TURTLES TO BRING ALONG,
-- JUST IN CASE
fuel_padding = 30


-- FUEL PER ITEM 
--     for coal default is 80. Other fuel sources
--     can be used without changing this number,
--     should be fine.
fuel_per_unit = 80


-- TIME AFTER LAST PING TO DECLARE TURTLE
-- DISCONNECTED
turtle_timeout = 5


-- TIME AFTER LAST PING TO DECLARE POCKET
-- COMPUTER DISCONNECTED
pocket_timeout = 5


-- TIME TO WAIT AFTER SENDING TASK WITH NO
-- RESPONSE TO RESEND
task_timeout = 0.5


-- EVERY BLOCK NAME CONTAINING ANY OF THESE
-- STRINGS WILL NOT BE MINED
--     e.g. "chest" will prevent "minecraft:trapped_chest".
--     ore types should not be put on this list,
--     but if not desired should be removed from
--     <orenames> below.
dig_disallow = {
    'computer',
    'chest',
}


mine_levels = {
    -- LEVELS INCLUDED IN THE MINE
    --     turtles will pick randomly with weight
    --     between each listed level.
    --
    -- Level chances should sum to 1.0
    -- e.g.
    -- 
    -- {level = 50, chance = 0.3},
    -- {level = 40, chance = 0.2},
    -- {level = 12, chance = 0.5},

    {level = 12, chance = 1.0},
}


paths = {
    -- THE ORDER IN WHICH TURTLES WILL
    -- TRAVERSE AXES BETWEEN AREAS
    --     recommended not to change this one.
    home_to_home_exit          = 'zyx',
    control_room_to_home_enter = 'yzx',
    home_to_waiting_room       = 'zyx',
    waiting_room_to_mine_exit  = 'yzx',
    mine_enter_to_strip        = 'yxz',
}


locations = {
    -- THE VARIUS PLACES THE TURTLES MOVE
    -- BETWEEN
    --     coordinates are relative to the
    --     <mine_center> variable. areas are for
    --     altering turtle behavior to prevent
    --     collisions and stuff.

     -- THE BLOCK TURTLES WILL GO TO BEFORE
     -- DECENDING
    mine_enter = {x = c.x+0, y = c.y+0, z = c.z+0},

     -- THE BLOCK TURTLES WILL COME UP TO
     -- FROM THE MINE
     --     one block higher by default.
    mine_exit = {x = c.x+0, y = c.y+1, z = c.z+1},

     -- THE BLOCK TURTLES GO TO IN ORDER
     -- TO ACCESS THE CHEST FOR ITEMS
    item_drop = {x = c.x+2, y = c.y+1, z = c.z+1, orientation = 'east'},

     -- THE BLOCK TURTLES GO TO IN ORDER
     -- TO ACCESS THE CHEST FOR FUEL
    refuel = {x = c.x+2, y = c.y+1, z = c.z+0, orientation = 'east'},

     -- THE AREA ENCOMPASSING TURTLE HOMES
     --     where they sleep.
    greater_home_area = {
        min_x =  -inf,
        max_x = c.x-3,
        min_y = c.y+0,
        max_y = c.y+1,
        min_z = c.z-1,
        max_z = c.z+2
    },

     -- THE ROOM WHERE THE MAGIC HAPPENS
     --     turtles can find there way home from
     --     here.
    control_room_area = {
        min_x = c.x-16,
        max_x = c.x+8,
        min_y = c.y+0,
        max_y = c.y+8,
        min_z = c.z-8,
        max_z = c.z+8
    },

     -- WHERE TURTLES QUEUE TO BE PAIRED UP
    waiting_room_line_area = {
        min_x =  -inf,
        max_x = c.x-2,
        min_y = c.y+0,
        max_y = c.y+0,
        min_z =  c.z+0,
        max_z = c.z+1
    },

     -- THE AREA ENCOMPASSING BOTH WHERE
     -- TURTLES PAIR UP, AND THE PATH THEY
     -- TAKE TO THE MINE ENTRANCE
    waiting_room_area = {
        min_x = c.x-2,
        max_x = c.x+0,
        min_y = c.y+0,
        max_y = c.y+0,
        min_z =  c.z+0,
        max_z = c.z+1
    },

     -- THE LOOP TURTLES GO IN BETWEEN THEIR
     -- HOMES, THE ITEM DROP STATION, AND THE
     -- REFUELING STATION
     --     routes work like linked lists.
     --     keys are current positions, and
     --     values are the associated ajecent
     --     blocks to move to. this loop should
     --     be closed, and it should not be
     --     possible for a collision to occur
     --     between a turtle following the loop,
     --     and a turtle pairing, traveling to
     --     the mine entrance, or any other
     --     movement.
    main_loop_route = {

         -- MINING TURTLE HOME ENTER
        [c.x-1 .. ',' .. c.y+1 .. ',' .. c.z-1] = {x = c.x-2, y = c.y+1, z = c.z-1},

         -- MINING TURTLE HOME EXIT
        [c.x-2 .. ',' .. c.y+1 .. ',' .. c.z-1] = {x = c.x-2, y = c.y+1, z = c.z+0},

         -- CHUNKY TURTLE HOME EXIT
        [c.x-2 .. ',' .. c.y+1 .. ',' .. c.z+0] = {x = c.x-2, y = c.y+1, z = c.z+1},

         -- CHUNKY TURTLE HOME ENTER
        [c.x-2 .. ',' .. c.y+1 .. ',' .. c.z+1] = {x = c.x-2, y = c.y+1, z = c.z+2},

        [c.x-2 .. ',' .. c.y+1 .. ',' .. c.z+2] = {x = c.x-1, y = c.y+1, z = c.z+2},
        [c.x-1 .. ',' .. c.y+1 .. ',' .. c.z+2] = {x = c.x+0, y = c.y+1, z = c.z+2},
        [c.x+0 .. ',' .. c.y+1 .. ',' .. c.z+2] = {x = c.x+0, y = c.y+1, z = c.z+1},
        [c.x+0 .. ',' .. c.y+1 .. ',' .. c.z+1] = {x = c.x+1, y = c.y+1, z = c.z+1},

         -- ITEM DROP STATION
        [c.x+1 .. ',' .. c.y+1 .. ',' .. c.z+1] = {x = c.x+2, y = c.y+1, z = c.z+1},

         -- REFUELING STATION
        [c.x+2 .. ',' .. c.y+1 .. ',' .. c.z+1] = {x = c.x+2, y = c.y+1, z = c.z+0},

        [c.x+2 .. ',' .. c.y+1 .. ',' .. c.z+0] = {x = c.x+2, y = c.y+1, z = c.z-1},
        [c.x+2 .. ',' .. c.y+1 .. ',' .. c.z-1] = {x = c.x+1, y = c.y+1, z = c.z-1},
        [c.x+1 .. ',' .. c.y+1 .. ',' .. c.z-1] = {x = c.x+0, y = c.y+1, z = c.z-1},
        [c.x+0 .. ',' .. c.y+1 .. ',' .. c.z-1] = {x = c.x-1, y = c.y+1, z = c.z-1},
    },
}


mining_turtle_locations = {
    -- LOCATIONS THAT ARE SPECIFIC TO
    -- MINING TURTLES

     -- TURTLE HOMES
     --     this is where the first turtle parking
     --     spot will be, and each following will
     --     be in the <increment> direction.
    homes = {x = c.x-3, y = c.y+0, z = c.z-3, increment = 'west'},

     -- THE AREA ENCOMPASSING THE HOME
     -- LINE, AS WELL AS THE PATH TURTLES
     -- TAKE TO GET TO THEIR HOME
    home_area = {
        min_x = -inf,
        max_x = c.x-3,
        min_y = c.y+0,
        max_y = c.y+0,
        min_z = c.z-1,
        max_z = c.z-1
    },

     -- WHERE TURTLES ENTER THE LINE TO
     -- GET TO THEIR HOME
    home_enter = {x = c.x-2, y = c.y+1, z = c.z-1, orientation = 'west'},

     -- WHERE TURTLES EXIT THEIR HOMES
    home_exit = {x = c.x-2, y = c.y+1, z = c.z+0},

     -- WHERE TURTLES WAIT TO BE PAIRED
    waiting_room = {x = c.x-2, y = c.y+0, z = c.z+0},

     -- THE PATH TURTLES WILL TAKE AFTER
     -- PAIRING
    waiting_room_to_mine_enter_route = {
        [c.x-2 .. ',' .. c.y+0 .. ',' .. c.z+0] = {x = c.x-1, y = c.y+0, z = c.z+0},
        [c.x-1 .. ',' .. c.y+0 .. ',' .. c.z+0] = {x = c.x+0, y = c.y+0, z = c.z+0},
    }
}


chunky_turtle_locations = {
    -- LOCATIONS THAT ARE SPECIFIC TO
    -- MINING TURTLES

     -- TURTLE HOMES
     --     this is where the first turtle parking
     --     spot will be, and each following will
     --     be in the <increment> direction.
    homes = {x = c.x-3, y = c.y+0, z = c.z+2, increment = 'west'},

     -- THE AREA ENCOMPASSING THE HOME
     -- LINE, AS WELL AS THE PATH TURTLES
     -- TAKE TO GET TO THEIR HOME
    home_area = {
        min_x = -inf,
        max_x = c.x-3,
        min_y = c.y+0,
        max_y = c.y+0,
        min_z = c.z+2,
        max_z = c.z+2
    },

     -- WHERE TURTLES ENTER THE LINE TO
     -- GET TO THEIR HOME
    home_enter = {x = c.x-2, y = c.y+1, z = c.z+2, orientation = 'west'},

     -- WHERE TURTLES EXIT THEIR HOMES
    home_exit = {x = c.x-2, y = c.y+1, z = c.z+1},

     -- WHERE TURTLES WAIT TO BE PAIRED
    waiting_room = {x = c.x-2, y = c.y+0, z = c.z+1},

     -- THE PATH TURTLES WILL TAKE AFTER
     -- PAIRING
    waiting_room_to_mine_enter_route = {
        [c.x-2 .. ',' .. c.y+0 .. ',' .. c.z+1] = {x = c.x-1, y = c.y+0, z = c.z+1},
        [c.x-1 .. ',' .. c.y+0 .. ',' .. c.z+1] = {x = c.x-1, y = c.y+0, z = c.z+0},
        [c.x-1 .. ',' .. c.y+0 .. ',' .. c.z+0] = {x = c.x+0, y = c.y+0, z = c.z+0},
    }
}


gravitynames = {
    -- ALL BLOCKS AFFECTED BY GRAVITY
    --     if a turtle sees these it will take
    --     extra care to make sure they're delt
    --     with. works at least a lot percent of
    --     the time
    ['minecraft:gravel'] = true,
    ['minecraft:sand'] = true,
}


orenames = {
    -- ALL THE BLOCKS A TURTLE CONSIDERS ORE
    --     a turtle will continue to mine out a
    --     vein until it reaches <vein_max> or
    --     it stops seeing blocks with names in
    --     this list. block names are exact.
    ['IC2:blockOreCopper'] = true,
    ['IC2:blockOreLead'] = true,
    ['IC2:blockOreTin'] = true,
    ['IC2:blockOreUran'] = true,
    ['ic2:resource'] = true,
    ['ThermalFoundation:Ore'] = true,
    ['thermalfoundation:ore'] = true,
    ['thermalfoundation:ore_fluid'] = true,
    ['thaumcraft:ore_amber'] = true,
    ['minecraft:coal'] = true,
    ['minecraft:coal_ore'] = true,
    ['minecraft:diamond'] = true,
    ['minecraft:diamond_ore'] = true,
    ['minecraft:dye'] = true,
    ['minecraft:emerald'] = true,
    ['minecraft:emerald_ore'] = true,
    ['minecraft:gold_ore'] = true,
    ['minecraft:iron_ore'] = true,
    ['minecraft:lapis_ore'] = true,
    ['minecraft:redstone'] = true,
    ['minecraft:redstone_ore'] = true,
    ['galacticraftcore:basic_block_core'] = true,
    ['mekanism:oreblock'] = true,
    ['appliedenergistics2:quartz_ore'] = true,
    ['create:zinc_ore'] = true,
    ['forbidden_arcanus:stellarite_piece'] = true,
    ['druidcraft:rockroot'] = true
}

blocktags = {
    -- ALL BLOCKS WITH ONE OF THESE TAGS A TURTLE CONSIDERS ORE
    --     most mods categorize ores with the forge:ores tag.
    --     this is an easy way to detect all but a few ores,
    --     which don't posess this exact tag (for example certus quartzfrom AE2)
    ['forge:ores'] = true,
    -- adds Certus Quartz and Charged Certus Quartz
    ['forge:ores/certus_quartz'] = true
}

fuelnames = {
    -- ITEMS THE TURTLE CONSIDERS FUEL
    ['minecraft:coal'] = true,
}


---==[ SCREEN ]==---


-- MAXIMUM ZOOM OUT (INVERSE) OF THE
-- MAP SCREEN
monitor_max_zoom_level = 5


-- DEFAULT ZOOM OF THE MAP SCREEN
--     0 is [1 pixel : 1 block]
default_monitor_zoom_level = 0


-- CENTER OF THE MAP SCREEN
--     probably want the mine center
default_monitor_location = {x = c.x, z = c.z}