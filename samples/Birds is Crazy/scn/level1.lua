
local composer = require( "composer" )
local physics = require("physics")
physics.setDrawMode( Mode )

local perspective = require("scn.perspective")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	physics.start()
	physics.setDrawMode(Mode)
	local background = display.newImageRect(sceneGroup, "img/backgrounds/background1.png", 720*2.5, 1080*2.5)
	background.x = X
	background.y = Y
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		camera = perspective.createView()
		camera:setBounds(0, 4000 ,0,	0)
		sceneGroup:insert(camera)

		player_width =  98 / playersize
    player_height = 72 / playersize

		local Sound1 = audio.loadSound( "sounds/level1.wav" )
	  local playsound = audio.play( Sound1 )

	  --2nd image sheet
	  local sheetData2 = { width = 197, height=116, numFrames=2, sheetContentWidth=394, sheetContentHeight=116 }
	  local sheet2 = graphics.newImageSheet(filename, sheetData2 )


	  -- In your sequences, add the parameter 'sheet=', referencing which image sheet the sequence should use
	  local sequenceData = {
	                  { name="seq2", sheet=sheet2, start=1, count=2, time=250, loopCount=0 }
	                  }

	  player = display.newSprite( sheet2, sequenceData )
		physics.addBody(player, {
															box = { halfWidth=74*playersize, halfHeight=60*playersize, x=0, y=0 }, isSensor=true })
    player:setSequence("seq2")
		player:play()
		player:scale(playersize, playersize)
		player.gravityScale = 0
		player.isFixedRotation = false
		player.isSensor = true
		player.surfaceType = "bird"
		player.angle = 0


		camera:add(player)
		camera:setFocus(player)
		camera:track()

		local pouchitel = display.newRect(sceneGroup, X*1.674, 360, 670, Y*2)
		pouchitel:setFillColor(1, 1, 1, 0.7)
		local pouchitel_text = display.newText(sceneGroup, "Tap this before flying!", X*1.674, 360, system.nativeFont, 36)
		pouchitel_text:setFillColor(0.5, 0.5, 0.5, 0.7)
		local function dontlight()
			pouchitel.alpha = pouchitel.alpha - 0.1
			pouchitel_text.alpha = pouchitel_text.alpha - 0.1
		end


		timer.performWithDelay( 100, dontlight, 9)
		local function back()
			pouchitel:toBack()
			pouchitel_text:toBack()
		end
		timer.performWithDelay( 1000,back,1  )

	--	local pouchitel2 = display.newRect(sceneGroup, X/2.3, 360, 670, Y*2)
	--	pouchitel2:setFillColor(1, 1, 1, 0.7)

		local moveDown = 10
		local moveUp = 0
		local function flapBird (event)
			if(event.phase == "began") then
				moveUp = 20
				if player.angle > -45 then
					player:rotate(-45)
					player.angle = player.angle - 45
				end
			end
		end

		Speed = 10


		local function onUpdate()
			if(moveUp > 0) then
				player.y = player.y - moveUp
				moveUp = moveUp - 0.8
			end


		if player.angle < 45 then
			if not linear then
			  player:rotate(2)
			  player.angle = player.angle + 2
		  end
    end

			if player.angle > 45 then
				true_angle = 45 - player.angle
				player:rotate(true_angle)
				player.angle = player.angle + true_angle
			end


			player.x = player.x + Speed
			player.y = player.y + moveDown

			if(player.y < -360) then
				GameOver()
			elseif(player.y > 360) then
				GameOver()
			end
		end

		function pipe(fn, x, y, width, height)
		  piper = display.newImageRect(sceneGroup, fn, width, height)
		  piper.x = x
		  piper.y = y
		  piper.surfaceType = "piper"
		  physics.addBody(piper, "static")
			camera:add(piper, 2)
		end
		pipe("img/Pipes/PipeDown_red.png", 700, 360, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 700, -704, 147, 864)
		pipe("img/Pipes/PipeDown_red.png", 1300, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 1300, -360, 147, 864)
		pipe("img/Pipes/PipeDown_red.png", 2000, 302, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 2000, -762, 147, 864)
		pipe("img/Pipes/PipeDown_red.png", 2500, 402, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 2500, -662, 147, 864)
		pipe("img/Pipes/PipeDown_red.png", 3000, 532, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 3000, -532, 147, 864)
		pipe("img/Pipes/PipeDown_red.png", 3500, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 3500, -360, 147, 864)
		pipe("img/Pipes/PipeDown_red.png", 4100, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 4100, -360, 147, 864)
		pipe("img/Pipes/PipeDown_red.png", 4575, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 4575, -360, 147, 864)

		local money = display.newImageRect(sceneGroup, "img/game_objects/moneys/money.png", 61, 60)
		money.x = X
		money.y = 100
		money.alpha = 0

		money_text = display.newText(sceneGroup, moneys, money.x + 100, money.y, system.nativeFont, 36)
		money_text.alpha = 0

		local money1 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_1.png", 61, 60)
		camera:add(money1, 4)
		money1.x = 2000
		money1.y = -202
		physics.addBody(money1)
		money1.gravityScale = 0

		local money2 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_5.png", 61, 60)
		camera:add(money2, 2)
		money2.x = 3000
		money2.y = 22
		physics.addBody(money2)
		money2.gravityScale = 0

		local money3 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_10.png", 61, 60)
		camera:add(money3, 4)
		money3.x = 4100
		money3.y = 202
		physics.addBody(money3)
		money3.gravityScale = 0

		local finish = display.newImageRect(sceneGroup, "img/finishes/Finish.png", 145, 199)
		finish.x = 4584
		finish.y = 169
		finish.alpha = 0.5
		physics.addBody(finish)
		finish.gravityScale = 0
		camera:add(finish, 2)

		local function alphanotis()
			money.alpha = money.alpha - 0.1
			money_text.alpha = money_text.alpha - 0.1
		end

		local function moneys_visibles()
			money.alpha = 1
			money_text.alpha = 1
			timer.performWithDelay(100, alphanotis, 10)
		end


		function remover1(event)
			display.remove(money1)
		end
		function remover2(event)
			display.remove(money2)
		end
		function remover3(event)
			display.remove(money3)
		end

		local function onCollision( self, event )
			if damage == true then
   			local collideObject = event.other
   			if ( collideObject.surfaceType == "piper" ) then
					GameOver()
   			end
			end
		end
		local function money1plus( self, event )
				local collideObject = event.other
				if ( collideObject.surfaceType == "bird" ) then
					money1:removeEventListener("collision")
					moneys = moneys + 1
					money_text.text = moneys
					moneys_visibles()
					timer.performWithDelay(1,function() return remover1(event) end )
				end
			end
			local function money5plus( self, event )
					local collideObject = event.other
					if ( collideObject.surfaceType == "bird" ) then
						money2:removeEventListener("collision")
						moneys = moneys + 5
						money_text.text = moneys
						moneys_visibles()
						timer.performWithDelay(1,function() return remover2(event) end )
					end
				end
				local function money10plus( self, event )
						local collideObject = event.other
						if ( collideObject.surfaceType == "bird" ) then
							money3:removeEventListener("collision")
							moneys = moneys + 10
							money_text.text = moneys
							moneys_visibles()
							timer.performWithDelay(1,function() return remover3(event) end )
						end
					end

		local function onWin( self, event )
				local collideObject = event.other
				if ( collideObject.surfaceType == "bird" ) then
					timer.performWithDelay(1,function() return Win(event) end )
			end
		end
		player.collision = onCollision
		player:addEventListener( "collision" )
		finish.collision = onWin
		finish:addEventListener( "collision" )
		money1.collision =  money1plus
		money1:addEventListener("collision")
		money2.collision =  money5plus
		money2:addEventListener("collision")
		money3.collision =  money10plus
		money3:addEventListener("collision")

		function gotorestart()
			camera:destroy()
			composer.removeScene("scn.level1", false)
			composer.gotoScene("scn.restart1", { effect="crossFade", time=333 })
		end

		function gotowin()
			islevel1 = true
			camera:destroy()
			composer.removeScene("scn.level1", false)
			composer.gotoScene("scn.levels", { effect="crossFade", time=333 })
		end

		function GameOver()
			transition.to(player, {y=390, time=1000})

			Runtime:removeEventListener("touch", flapBird)
			Runtime:removeEventListener("enterFrame", onUpdate)
			player:removeEventListener( "collision" )
			finish:removeEventListener( "collision" )
			physics.pause()
			audio.stop(playsound)
			playsound = nil
			timer.performWithDelay(deathdelay, gotorestart, 1)
		end

		function Win(event)
			player.x = player.x + 20
			Runtime:removeEventListener("touch", flapBird)
			Runtime:removeEventListener("enterFrame", onUpdate)
			player:removeEventListener( "collision" )
			finish:removeEventListener( "collision" )
			physics.pause()
			audio.stop(playsound)
			playsound = nil
			timer.performWithDelay(windelay, gotowin, 1)
		end

		Runtime:addEventListener("enterFrame", onUpdate)
		pouchitel:addEventListener("touch", flapBird)


	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

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
