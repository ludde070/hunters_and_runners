#> Create hnr:compass storage and update nbt
execute in minecraft:overworld run data modify storage hnr:compass Items[] set from entity @s Inventory[{tag:{compass_type:"tracking_device"}}]
execute in minecraft:overworld run data modify storage hnr:compass Items[].Slot set value 0b

#> Set dimension to our current dimension
execute in minecraft:overworld if entity @s[nbt={Dimension:0}] run data modify storage hnr:compass Items[].tag.LodestoneDimension set value "minecraft:overworld"
execute in minecraft:overworld if entity @s[nbt={Dimension:-1}] run data modify storage hnr:compass Items[].tag.LodestoneDimension set value "minecraft:the_nether"
execute in minecraft:overworld if entity @s[nbt={Dimension:1}] run data modify storage hnr:compass Items[].tag.LodestoneDimension set value "minecraft:the_end"
execute if entity @s[team=hunters,nbt={Dimension:0}] unless entity @a[tag=tracking,nbt={Dimension:0}] run data modify storage hnr:compass Items[].tag.LodestoneDimension set value "minecraft:the_end"
execute if entity @s[team=hunters,nbt={Dimension:-1}] unless entity @a[tag=tracking,nbt={Dimension:-1}] run data modify storage hnr:compass Items[].tag.LodestoneDimension set value "minecraft:the_end"
execute if entity @s[team=hunters,nbt={Dimension:1}] unless entity @a[tag=tracking,nbt={Dimension:1}] run data modify storage hnr:compass Items[].tag.LodestoneDimension set value "minecraft:the_nether"

#> updates x, y and z positions of the compass
execute in minecraft:overworld run execute store result storage hnr:compass Items[].tag.LodestonePos.X int 1 run scoreboard players get @a[tag=tracking,limit=1,sort=nearest] hnr.xpos
execute in minecraft:overworld run execute store result storage hnr:compass Items[].tag.LodestonePos.Y int 1 run scoreboard players get @a[tag=tracking,limit=1,sort=nearest] hnr.ypos
execute in minecraft:overworld run execute store result storage hnr:compass Items[].tag.LodestonePos.Z int 1 run scoreboard players get @a[tag=tracking,limit=1,sort=nearest] hnr.zpos
execute in minecraft:overworld run data merge block 0 2 1 {Text1:'{"selector":"@a[tag=tracking]"}'}
execute in minecraft:overworld if score rename_compass_to_runner hnr.settings matches 1 run data modify storage hnr:compass Items[].tag.display.Name set from block 0 2 1 Text1
execute in minecraft:overworld if score rename_compass_to_runner hnr.settings matches 0 run data modify storage hnr:compass Items[].tag.display.Name set value '{"text":"Tracking Compass"}'
tag @a[tag=tracking] remove tracking

#> updates shulker box from hnr:compass storage Items[]
execute in minecraft:overworld run data modify block 0 1 1 Items[] set from storage hnr:compass Items[]

#> Replace "tracking_device" in offhand, mainhand and last hotbar slot, updating Runner position
execute in minecraft:overworld run loot replace entity @s[nbt={SelectedItem:{tag:{compass_type:"tracking_device"}}}] weapon.mainhand mine 0 1 1 air{drop_contents:1b}
execute in minecraft:overworld run loot replace entity @s[nbt={Inventory:[{Slot:-106b,tag:{compass_type:"tracking_device"}}]}] weapon.offhand mine 0 1 1 air{drop_contents:1b}
execute in minecraft:overworld run loot replace entity @s[nbt={Inventory:[{Slot:8b,tag:{compass_type:"tracking_device"}}]}] hotbar.8 mine 0 1 1 air{drop_contents:1b}

#> Remove hnr:compass and block items
execute in minecraft:overworld run data remove storage hnr:compass Items
execute in minecraft:overworld run data remove block 0 1 1 Items