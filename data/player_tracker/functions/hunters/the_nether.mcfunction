#> ;creates import:pos storage & overwrites pulled item nbt
execute in minecraft:overworld run data modify storage import:pos Items[] set from entity @s Inventory[{tag:{compass_type:"tracking_device"}}]
execute in minecraft:overworld run data modify storage import:pos Items[].Slot set value 0b

#> dimension limited only to "minecraft:overworld" temporarily
execute in minecraft:overworld run data modify storage import:pos Items[].tag.LodestoneDimension set value "minecraft:the_nether"

#> imports xpos, ypos, zpos scores into import:pos{tag.LodestonePos.AXIS} tag
execute in minecraft:overworld run execute store result storage import:pos Items[].tag.LodestonePos.X int 1 run scoreboard players get @e[team=runners,limit=1,sort=nearest] xpos
execute in minecraft:overworld run execute store result storage import:pos Items[].tag.LodestonePos.Y int 1 run scoreboard players get @e[team=runners,limit=1,sort=nearest] ypos
execute in minecraft:overworld run execute store result storage import:pos Items[].tag.LodestonePos.Z int 1 run scoreboard players get @e[team=runners,limit=1,sort=nearest] zpos

# modifies shulker box (at 0 1 1) Items[] tag from import:pos storage
execute in minecraft:overworld run data modify block 0 1 1 Items[] set from storage import:pos Items[]

#> checks and replaces item "tracking_compass" in offhand, mainhand and last hotbar slot, updating LodestonePos.AXIS
execute in minecraft:overworld run loot replace entity @s[nbt={SelectedItem:{tag:{compass_type:"tracking_device"}}}] weapon.mainhand mine 0 1 1 air{drop_contents:1b}
execute in minecraft:overworld run loot replace entity @s[nbt={Inventory:[{Slot:-106b,tag:{compass_type:"tracking_device"}}]}] weapon.offhand mine 0 1 1 air{drop_contents:1b}
execute in minecraft:overworld run loot replace entity @s[nbt={Inventory:[{Slot:8b,tag:{compass_type:"tracking_device"}}]}] hotbar.8 mine 0 1 1 air{drop_contents:1b}

#> removal of Items[] tags in both storage and block (at 0 1 1)
execute in minecraft:overworld run data remove storage import:pos Items
execute in minecraft:overworld run data remove block 0 1 1 Items
