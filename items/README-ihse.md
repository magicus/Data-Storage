REMAINING:

legendaryisland [name / price] OK
hive [name / price] OK

quest [name (/information / description / screenshots ) ] OK

gathering -- [name/location/screenshot ] OK
discovery - [desc/screenshots] OK

dungeonmerchant [ name / price ( / location)] can be many!
merchant [ name / price / (location / coords )] can be many!
specialdrop [description / (name / location / coords / screenshots)] can be many items!


potions are duplicate, but different for different levels

    "name": "Potion of Agility",
    "name": "Potion of Defense",
    "name": "Potion of Dexterity",
    "name": "Potion of Healing",
    "name": "Potion of Intelligence",
    "name": "Potion of Strength",
    "name": "Potion of Wisdom",

UNCLEAR:
    "Rat Skull" -- dropped from dungeon "Unknown", level 10.
    "Spiderweb String" -- dropped from dungeon "Unknown", level 17.


    "bossaltar" OK
    "raid" OK
    "discontinued" OK
    "unobtainable" OK
    "merchant" OK
    "dungeonmerchant" OK
    "specialdrop" OK
    "discovery" OK
    "forgerychest" OK
    "gathering" OK
    "legendaryisland" OK
    "hive" OK
    "dungeon" OK
    "quest" OK

FIRST STEP:
jq '[ .[] | select(has("merchant"))] ' < obtaining.json  > ob_m2.json

MIDDLE STEP:
jq 'reduce .[] as $item ({}; .[$item.name] = $item.merchant)' <  ob_m2.json > ob_MERCH_ALL_half.json

LAST STEP:
jq 'to_entries | map(.value |= map({type: "merchant", name, details: (del(.name, .type) | with_entries(select(.key != "name")))})) | from_entries' < ob_MERCH_ALL_half.json  > ob_MERCH_ALL_DONE.json

COMBINE:
jq --slurp 'reduce .[] as $item ({}; . * $item)'  ob_rebuild.json ob_raid.json > ob_reb2.json
----
jq '[ .[] | select(has("specialdrop"))] ' < obtaining.json  > ob_m2.json

MIDDLE STEP:
jq 'reduce .[] as $item ({}; .[$item.name] = $item.specialdrop)' <  ob_m2.json > ob_MERCH_ALL_half.json

LAST STEP:
jq 'to_entries | map(.value |= map({type: "specialdrop", name, details: (del(.name, .type) | with_entries(select(.key != "name")))})) | from_entries' < ob_MERCH_ALL_half.json  > ob_MERCH_ALL_DONE.json

COMBINE:
jq --slurp 'reduce .[] as $item ({}; . * $item)'  ob_rebuild.json ob_raid.json > ob_reb2.json
