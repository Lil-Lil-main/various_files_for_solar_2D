HP = MAX_HP
local composer = require( "composer" )
local physics = require("physics")

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
		camera:setBounds(0, 8000 ,0,	0)
		sceneGroup:insert(camera)

		local Sound1 = audio.loadSound( "sounds/level1.wav" )
		local playsound = audio.play( Sound1 )

		local player = display.newImageRect(sceneGroup, filename, 98, 72)
		physics.addBody(player)
		player.gravityScale = 0
		player.isFixedRotation = false
		player.isSensor = true
		player.surfaceType = "bird"

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

		laser_speed = 20
		local moveDown = 10
		local moveUp = 0
		local function flapBird (event)
			if(event.phase == "began") then
				moveUp = 20
			end
		end

		Speed = 10

		local function onUpdate()
			if(moveUp > 0) then
				player.y = player.y - moveUp
				moveUp = moveUp - 0.8
			end
			player.x = player.x + Speed
			player.y = player.y + moveDown

			if laser_1.y < 270 then
				laser_1.y = laser_1.y + laser_speed
			else
				laser_1.y = -270
			end

			if laser_2.y < 270 then
				laser_2.y = laser_2.y + laser_speed
			else
				laser_2.y = -270
			end

			if laser_3.y > -270 then
				laser_3.y = laser_3.y - laser_speed
			else
				laser_3.y = 270
			end

			if laser_4.y < 270 then
				laser_4.y = laser_4.y + 10
			else
				laser_4.y = -270
			end

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
		function pipex(fn, x, y, width, height)
			piper = display.newImageRect(sceneGroup, fn, width, height)
			piper.x = x
			piper.y = y
			camera:add(piper, 2)
		end

		laser_1 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_1:rotate(90)
		laser_1.x = 2500
		laser_1.y =  -270
		physics.addBody(laser_1)
		laser_1.isSensor = true
		laser_1.gravityScale = 0
		camera:add(laser_1, 3)

		laser_2 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_2:rotate(90)
		laser_2.x = 4575
		laser_2.y =  -270
		physics.addBody(laser_2)
		laser_2.isSensor = true
		laser_2.gravityScale = 0
		camera:add(laser_2, 3)

		laser_3 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_3:rotate(90)
		laser_3.x = 4100
		laser_3.y =  270
		physics.addBody(laser_3)
		laser_3.isSensor = true
		laser_3.gravityScale = 0
		camera:add(laser_3, 3)

		laser_4 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_4:rotate(90)
		laser_4.x = 5500
		laser_4.y =  270
		physics.addBody(laser_4)
		laser_4.isSensor = true
		laser_4.gravityScale = 0
		camera:add(laser_4, 3)

		laser_5 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_5:rotate(90)
		laser_5.x = 6400
		laser_5.y =  270
		physics.addBody(laser_5)
		laser_5.isSensor = true
		laser_5.gravityScale = 0
		camera:add(laser_5, 3)

		laser_6 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_6:rotate(90)
		laser_6.x = 6400
		laser_6.y =  270
		physics.addBody(laser_6)
		laser_6.isSensor = true
		laser_6.gravityScale = 0
		camera:add(laser_6, 3)
		--1
		local ramka_1 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_1.x = 2500
		ramka_1.y =  -270
		camera:add(ramka_1, 1)
		--2
		local ramka_2 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_2.x = 4100
		ramka_2.y =  -270
		camera:add(ramka_2, 1)
		--3
		local ramka_3 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_3.x = 4575
		ramka_3.y =  270
		camera:add(ramka_3, 1)
		--4
		local ramka_4 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_4.x = 5500
		ramka_4.y =  -250
		camera:add(ramka_4, 1)
		--5
		local ramka_5 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_5.x = 6400
		ramka_5.y =  -270
		camera:add(ramka_5, 1)

		local ramka_6 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_6.x = 6400
		ramka_6.y =  270
		camera:add(ramka_6, 1)
		--6


		--1
		pipe("img/Pipes/PipeDown_red.png", 700, 760, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 700, -304, 147, 864)
		--2
		pipe("img/Pipes/PipeDown_red.png", 1300, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 1300, -360, 147, 864)
		--3
		pipe("img/Pipes/PipeDown_red.png", 2000, 644, 147, 864)
		pipe("img/Pipes/pipe_always_red.png", 2000, -80, 107, 106)
		pipex("img/Pipes/pipe_always_red.png", 2000, -187, 107, 106)
		pipex("img/Pipes/pipe_always_red.png", 2000, -281, 107, 94)
		pipe("img/Pipes/pipe_always_red.png", 2000, -375, 107, 94)
		pipe("img/Pipes/Pipe_red.png", 2000, -6, 147, 74)
		--4
		pipe("img/Pipes/PipeDown_red.png", 2500, 602, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 2500, -662, 147, 864)
		--5
		pipe("img/Pipes/PipeDown_red.png", 3000, 532, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 3000, -532, 147, 864)
		--6
		pipe("img/Pipes/PipeDown_red.png", 3500, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 3500, -360, 147, 864)
		--7
		pipe("img/Pipes/PipeDown_red.png", 4100, 602, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 4100, -662, 147, 864)
		--8
		pipe("img/Pipes/PipeDown_red.png", 4575, 602, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 4575, -662, 147, 864)
		--9
		pipe("img/Pipes/PipeDown_red.png", 5100, 760, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 5100, -304, 147, 864)
		--10
		pipe("img/Pipes/PipeDown_red.png", 5500, 602, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 5500, -662, 147, 864)
		--11
		pipe("img/Pipes/PipeDown_red.png", 5900, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 5900, -360, 147, 864)
		--12
		pipe("img/Pipes/PipeDown_red.png", 6400, 602, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 6400, -662, 147, 864)
		--13
		pipe("img/Pipes/PipeDown_red.png", 6800, 644, 147, 864)
		pipe("img/Pipes/pipe_always_red.png", 6800, -80, 107, 106)
		pipex("img/Pipes/pipe_always_red.png", 6800, -187, 107, 106)
		pipex("img/Pipes/pipe_always_red.png", 6800, -281, 107, 94)
		pipe("img/Pipes/pipe_always_red.png", 6800, -375, 107, 94)
		pipe("img/Pipes/Pipe_red.png", 6800, -6, 147, 74)
		--14
		pipe("img/Pipes/PipeDown_red.png", 7200, 602, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 7200, -662, 147, 864)
		--15
		pipe("img/Pipes/PipeDown_red.png", 7700, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 7700, -360, 147, 864)
		--16
		pipe("img/Pipes/PipeDown_red.png", 8100, 602, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 8100, -662, 147, 864)
		--17
		pipe("img/Pipes/PipeDown_red.png", 8600, 532, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 8600, -532, 147, 864)
		local money = display.newImageRect(sceneGroup, "img/game_objects/moneys/money.png", 61, 60)
		money.x = X
		money.y = 100
		money.alpha = 0

		money_text = display.newText(sceneGroup, moneys, money.x + 100, money.y, system.nativeFont, 36)
		money_text.alpha = 0

		local money1 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_5.png", 61, 60)
		camera:add(money1, 2)
		money1.x = 2000
		money1.y = -182
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
		money3.y = -150
		physics.addBody(money3)
		money3.gravityScale = 0

		local finish = display.newImageRect(sceneGroup, "img/finishes/Finish.png", 145, 199)
		finish.x = 14584
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
					timer.performWithDelay(1,function() return GameOver(event) end )
				end
			end
		end
		local function money1plus( self, event )
				local collideObject = event.other
				if ( collideObject.surfaceType == "bird" ) then
					money1:removeEventListener("collision")
					moneys = moneys + 5
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

					function isdamage()
						damage = true
					end

					nockout = 1000

					function laser_1_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_1.y = -270
						HP = HP - 1
						print(HP)
					end
					function laser_2_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_2.y = -270
						HP = HP - 1
						print(HP)
					end
					function laser_3_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_3.y = 270
						HP = HP - 1
						print(HP)
					end
					function laser_4_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_4.y = -270
						HP = HP - 1
						print(HP)
					end

					local function lasercollision1( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_1_damage(event) end )
								end
							end
					end
					local function lasercollision2( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_2_damage(event) end )
								end
							end
					end
					local function lasercollision3( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_3_damage(event) end )
								end
							end
					end
					local function lasercollision4( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_4_damage(event) end )
								end
							end
					end
					local function onWin( self, event )
						local collideObject = event.other
						if ( collideObject.surfaceType == "bird" ) then
							Win()
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
					laser_1.collision = lasercollision1
					laser_1:addEventListener("collision")
					laser_2.collision = lasercollision2
					laser_2:addEventListener("collision")
					laser_3.collision = lasercollision3
					laser_3:addEventListener("collision")
					laser_4.collision = lasercollision4
					laser_4:addEventListener("collision")

					function gotorestart()
						timer.performWithDelay(120, camera:destroy(),  1)
						composer.removeScene("scn.level2", false)
						composer.gotoScene("scn.restart2", { effect="crossFade", time=333 })
					end

					function gotowin()
						islevel2 = true
						composer.removeScene("scn.level2", false)
						camera:cancel()
						camera:destroy()
						composer.gotoScene("scn.levels", { effect="crossFade", time=333 })
					end

					function GameOver(event)

						Runtime:removeEventListener("touch", flapBird)
						Runtime:removeEventListener("enterFrame", onUpdate)
						player:removeEventListener( "collision" )
						finish:removeEventListener( "collision" )
						physics.pause()
						audio.stop(playsound)
						playsound = nil
						timer.performWithDelay(1,function() return remover1(event) end )
						timer.performWithDelay(1,function() return remover2(event) end )
						timer.performWithDelay(1,function() return remover3(event) end )
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
