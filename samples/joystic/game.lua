
local composer = require( "composer" )
local os = require"os"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local physics = require("physics")
physics.start()
physics.setGravity(0, 800)

local perspective = require("perspective")
--------------------------------------------------------------------------------------
-- VIRTUAL CONTROLLER CODE
--------------------------------------------------------------------------------------
-- This section contains everything you need to create and display the controller
-- This isn't the best place to have all of this code, but I wanted to keep it all
-- in one place so you can find it easily
-- setupController gets called in scene:create()
--------------------------------------------------------------------------------------
local camera = perspective.createView()
camera:setBounds(0, 5000, 0, 0)
-- This line brings in the controller which basically acts like a class
local factory = require("controller.virtual_controller_factory")
local controller = factory:newController()

-- This enables both joysticks to be used at the same time. All of the code to make
-- sure that touch events are handled by the correct joystick is encased in the controller
-- so you don't have to worry about that.
system.activate("multitouch")

-- These are variables to hold the joysticks so that I can
-- use them in a timer later on
local js1
local js2

camera:appendLayer()

local function setupController(displayGroup)
	local js1Properties = {
		nToCRatio = 0.5,
		radius = 60,
		x = 100,
		y = 100,
		restingXValue = 0,
		restingYValue = 0,
		rangeX = 200,
		rangeY = 200,
		touchHandler = {
			onTouch = movePlayer
		}
	}

	local js1Name = "js1"
	js1 = controller:addJoystick(js1Name, js1Properties)

	local js2Properties = {
		nToCRatio = 0.5,
		radius = 60,
		x = display.contentWidth - 50,
		y = 100,
		restingXValue = 0,
		restingYValue = 0,
		rangeX = 600,
		rangeY = 600,
		touchHandler = {
			onTouch = fireSinglebullet
		}
	}

	local js2Name = "js2"
	js2 = controller:addJoystick(js2Name, js2Properties)

	controller:displayController(displayGroup)

end

local jumpBUTTON = display.newCircle(860, 100, 60 )
jumpBUTTON:setFillColor(0.5, 0.6)
local JumpText = display.newText("J", 860, 100, system.nativeFont, 60)
JumpText:setFillColor(1, 0, 0, 0.6)
----------------------------------------------------------------------------------------
-- END VIRTUAL CONTROLLER CODE
----------------------------------------------------------------------------------------

local bullet_list = 0

local died = false
local orientation = "R"

local player
local gameLoopTimer
local fireTimer
local movementTimer

local backGroup
local mainGroup
local uiGroup

local function touchAction( event )

    if ( event.phase == "began" and player.sensorOverlaps > 0 ) then
        -- Jump procedure here
				transition.to(player, { time=600, y= player.y-325 } )
    end
end

function movePlayer(self, x, y)
	x = x*8
	player:setLinearVelocity(x)
end

function fireSinglebullet(self, x, y)
	if bullet_list < 1 then
		if(x == 0 and y == 0) then
			return true
		end

		local newbullet = display.newCircle(mainGroup, player.x, player.y*4, 5)
		physics.addBody(newbullet, "dynamic", {isSensor = true})
		newbullet.isBullet = true
		newbullet.myName = "bullet"
		newbullet.gravityScale = 0

		newbullet:toBack()
		bullet_list = bullet_list + 1

		coords = js2:getXYValues()
		if coords.x  > 0 then
			orientation = "R"
		elseif coords.x < 0 then
			orientation = "L"
		end

		if orientation == "R" then
			transition.to(newbullet, {x = 1080, time = 500,
				onComplete = function() display.remove( newbullet );bullet_list = bullet_list-1 end
			})
		elseif orientation == "L" then
			transition.to(newbullet, {x = -200, time = 500,
				onComplete = function() display.remove( newbullet );bullet_list = bullet_list-1 end
			})
		end
		return true
	end
end
local function endGame()
		composer.gotoScene("restart")
end

local function gameLoop()
	if player.y > 1000  then
		display.remove(player)
		display.remove(sceneGroup)
		camera:cancel()
		camera:destroy()
		endGame()
	end
	if lives == 0 then
		display.remove(player)
		display.remove(sceneGroup)
		camera:cancel()
		camera:destroy()
		local function new22()
		endGame()
	end
	timer.performWithDelay(1000, new22, 1)
	end
end

local function sensorCollide( self, event )
  if ( event.selfElement == 2 and event.other.objType == "ground" ) then

	  -- Foot sensor has entered (overlapped) a ground object
	  if ( event.phase == "began" ) then
	  	self.sensorOverlaps = self.sensorOverlaps + 1
	  	-- Foot sensor has exited a ground object
	  elseif ( event.phase == "ended" ) then
	  	self.sensorOverlaps = self.sensorOverlaps - 1
		end
	end

	if ( event.selfElement == 2 and event.other.objType == "coin1" ) then

					-- Foot sensor has entered (overlapped) a ground object
			if ( event.phase == "began" ) then
						camera:remove(coin1)
						display.remove(coin1)
						moneys = moneys + 1
			elseif ( event.phase == "ended" ) then
			end
	end

	if ( event.selfElement == 2 and event.other.objType == "enemy1" ) then

					-- Foot sensor has entered (overlapped) a ground object
			if ( event.phase == "began" ) then
						if orientation == "L" then
							player.x = player.x + 100
						elseif orientation == "R" then
							player.x =player.x - 100
						end
			elseif ( event.phase == "ended" ) then
						lives = lives -1
			end
	end

end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
os.clock(1000)
-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause()
	physics.setDrawMode("normal")

	backGroup = display.newGroup()
	sceneGroup:insert(backGroup)

	backGroup:insert(jumpBUTTON)
	sceneGroup:insert(JumpText)

	mainGroup = display.newGroup()
	sceneGroup:insert(mainGroup)

	uiGroup = display.newGroup()
	sceneGroup:insert(uiGroup)


	setupController(uiGroup)

	local background = display.newImageRect(backGroup, "Bg1.png", display.contentWidth*1.5, display.contentHeight)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background.alpha = 0.7

	player = display.newImageRect(mainGroup, "Pers.png" , 100, 100)
	player.x = display.contentCenterX
	player.y = display.contentCenterY/4
	player.myName = "player"
	player.alpha = 0.8
	physics.addBody(player, "dynamic", { box={ halfWidth=30, halfHeight=10, x=0, y=50 }, isSensor=true },  { box={ halfWidth=56, halfHeight=50, x=0, y=0 }, isSensor=false })
	player.isFixedRotation = true
	player.sensorOverlaps = 0
	camera:add(player, 1)
	camera:setFocus(player)
	camera:track()

	jumpBUTTON:addEventListener( "touch", touchAction )

	local function ground(x, y, w, h)
		grounds = display.newImageRect(mainGroup, "block1ultimate.png", w, h)
		grounds.x = x
		grounds.y = y
		grounds.myName = "ground"
		grounds.objType = "ground"
		grounds:toBack()
		physics.addBody(grounds, "static", { box={ halfWidth=370, halfHeight=10, x=0, y=-40 }, isSensor=false })
		camera:add(grounds, 2)
	end

	local function cloud(x, y, w, h)
		clouds = display.newImageRect(mainGroup, "Cloud1.png", w, h)
		clouds.x = x
		clouds.y = y
		clouds:toBack()
		camera:add(clouds, 3)
	end

	coin1 = display.newImageRect(sceneGroup, "coin1.png", 100, 100)
	coin1.x = display.contentCenterX*2.5
	coin1.y = display.contentHeight  - 800
	physics.addBody(coin1, "dynamic", { box={ halfWidth=56, halfHeight=40, x=0, y=0 }, isSensor=false })
	coin1.isFixedRotation = true
	coin1.sensorOverlaps = 0
	coin1.gravityScale = 0
	coin1.objType = "coin1"
	camera:add(coin1)

	enemy1 = display.newImageRect(sceneGroup, "enemy1.png", 100, 100)
	enemy1.x, enemy1.y = display.contentCenterX-200, _H-600
	physics.addBody(enemy1, "static", {box={halfWidth=56, halfHeight=40, x = 0, y=0}, issensor = true})
	enemy1.isFixedRotation = true
	enemy1.sensorOverlaps = 0
	enemy1.objType = "enemy1"
	camera:add(enemy1)

	ground(_X-200, _H-500, 778, 100)
	ground(_X*3, _H-500, 778, 100)

	cloud(_X-200, _H-400, 778, 100)
	cloud(_X*2-100, _H-400, 778, 100)
	cloud(_X*3, _H-400, 778, 100)
	cloud(_X*4-100, _H-400, 778, 100)
	camera:appendLayer()
	local menuButton = display.newText(uiGroup, "Menu", display.contentCenterX, 100, native.systemFont, 44)
	menuButton:setFillColor(1, 1, 1, 1)
	menuButton:addEventListener("tap", endGame)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		player.collision = sensorCollide
		player:addEventListener( "collision" )
		gameLoopTimer = timer.performWithDelay(500, gameLoop, 0)
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		timer.cancel(gameLoopTimer)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		Runtime:removeEventListener("collision", onCollision)
		physics.pause()
		composer.removeScene("game")
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	controller = nil
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
