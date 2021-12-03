local composer = require "composer"
local math = require "math"
local physics = require("physics")

Creater = "WowsApp Studio"

print("Creater:", Creater)

display.setStatusBar( display.HiddenStatusBar)

Mode = "normal"
FPS = 60
damage = true
moneys = 0

isFire = false
linear=false
start = false

playersize = 0.5
deathdelay = 1700
windelay = 1700
GunTime = 650
HP = 3

MAX_HP = 5

bird1ploskiy = "img/birds/Animations/Bird_1_Donw.png"

birdislock3 = true
bird2_anim   =  "img/birds/Animations/Bird_2.png"

birdislock3 = false
bird3_anim   =  "img/birds/Animations/Bird_3.png"

filename = bird1ploskiy

life_easy_1 = "img/game_objects/lifes/png/life_1.png"
lifename = life_easy_1

life_full_1 = "img/game_objects/lifes/png/life_full_1.png"
fulllifename = life_full_1

laser_weapon_1 = "img/game_objects/weapons/weapons/png/laser_weapom_1.png"
weaponfile = laser_weapon_1

lasergun1 = "img/game_objects/weapons/weapons/png/laser_weapom_1.png"
lasergun = lasergun1

playerlazer1 = "img/game_objects/weapons/laser_red.png"
playerlaser = playerlazer1

-------------UI UI UI UI UI UI--------------
--0010110101001011100101010100011100110010--
-------------UI UI UI UI UI UI--------------



l2 = "Locked"
l3 = "Locked"

_W = display.contentWidth
_H = display.contentHeight
X = display.contentCenterX
Y = display.contentCenterY
_WP = math.floor(((_W/100)+0.5))
_HP = math.floor(((_H/100)+0.5))

-----Normal Levels---------
islevel1 = true
islevel2 = true
islevel3 = false

-------Boss Levels----------
islevel4 = true

---------------------------------------------------------
-------------functions-------------------------------
-------------------------------------------------
--------------------------------------------
-------------------------------------

function pipe(fn, Group, x, y, width, height)
  piper = display.newImageRect(Group, fn, width, height)
  piper.x = x
  piper.y = y
  piper.surfaceType = "superbounce"
  physics.addBody(piper, "static")
end


composer.gotoScene("scn.menu")
