isFire = false
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

-----------------------------------------------
-------------P. S.-----------------------------
---1 layer is bird
---2 layer is finish
---3 layer is moneys
---4 layer is ramka_laser
---5 layer is pipes
---6 layer is laser
---7 layer is laser_weapon


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

-----------------------------------------------------------------------
-------------Camera---Camera---Camera---------------------------------
-------------------------------------------------------------------

		camera = perspective.createView()
		camera:setBounds(0, 8000 ,0,	0)
		sceneGroup:insert(camera)

-----------------------------------------------------------------------
-------------Sound---Sound---Sound---------------------------------
-------------------------------------------------------------------
		local Sound1 = audio.loadSound( "sounds/level1.wav" )
	  local playsound = audio.play( Sound1 )

-----------------------------------------------------------------------
------------ANimations--Animations and Player, player---------------------------------
------------------------------------------------------------------

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
-----------------------------------------------------------------------
------------- Gun Gun GUn---------------------------------
-------------------------------------------------------------------
		local Gun = display.newImageRect(sceneGroup, lasergun, 45, 45)
		Gun.y = 8000
		player_laser = display.newImageRect(sceneGroup, playerlaser, 33, 11)
		physics.addBody(player_laser)
		player_laser.gravityScale = 0
		player_laser.isFixedRotation = false
		player_laser.isSensor = true
		player_laser.surfaceType = "TrueLaser"

		camera:add(player_laser, 2)
		camera:add(player, 1)
		camera:setFocus(player)
		camera:track()
-----------------------------------------------------------------------
-------------Touch Pads---------------------------------
-------------------------------------------------------------------
		local pouchitel = display.newRect(sceneGroup, X*1.674, 360, 670, Y*2)
		pouchitel:setFillColor(1, 1, 1, 0.7)
		local pouchitel2 = display.newRect( sceneGroup, X/3.2, Y, 800, Y*2)
		pouchitel2:setFillColor(1, 1, 1, 0.7)
		local pouchitel_text = display.newText(sceneGroup, "Tap this for flying!", X*1.974, 360, system.nativeFont, 36)
		pouchitel_text:setFillColor(0.5, 0.5, 0.5, 0.7)
		local pouchitel_text2 = display.newText(sceneGroup, "Tap this for Fire", X/7.77, 360, system.nativeFont, 36)
		pouchitel_text2:setFillColor(0.5, 0.5, 0.5, 0.7)
		local function dontlight()
			pouchitel.alpha = pouchitel.alpha - 0.1
			pouchitel_text.alpha = pouchitel_text.alpha - 0.1
		end
		local function dontlight2()
		  pouchitel2.alpha = pouchitel.alpha - 0.1
		  pouchitel_text2.alpha = pouchitel_text.alpha - 0.1
		end

		timer.performWithDelay( 100, dontlight, 9)
		timer.performWithDelay( 100, dontlight2, 9)

		local function back()
			pouchitel:toBack()
			pouchitel_text:toBack()
		end

		local function back2()
			pouchitel2:toBack()
			pouchitel_text2:toBack()
		end
------------------------------------------------
--------Activ-------------------
---------------------------
		timer.performWithDelay( 1000,back,1  )
		timer.performWithDelay( 1000,back2,1  )
---------------------------------------------
-------------Fire Fire Fire---------------
------------------------------------
		local function Fire()
			isFire = true
			transition.to(player_laser, {x = player_laser.x + 850, time = GunTime, onComplete = function() isFire = false end})
		end
----------------------------------------
-----------player moving-----------------
-------------------------------------
		laser_speed = 20
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
-------------------------------------
-----------on Update-------------------
---------------------------------
		local function onUpdate()
			if(moveUp > 0) then
				player.y = player.y - moveUp
				moveUp = moveUp - 0.8
			end
			player.x = player.x + Speed
			player.y = player.y + moveDown

		if player.angle < 45 then
			if not linear then
			  player:rotate(2)
			  player.angle = player.angle + 2
		  end
	 	end


		if isFire == false then
			player_laser.x = player.x
			player_laser.y = player.y
		  pouchitel2:addEventListener("tap", Fire)

		else
			pouchitel2:removeEventListener("tap", Fire)

		end

		if player.angle > 45 then
			true_angle = 45 - player.angle
			player:rotate(true_angle)
			player.angle = player.angle + true_angle
		end

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

			if laser_5.y > -270 then
				laser_5.y = laser_5.y - laser_speed
			else
				laser_5.y = 270
			end

			if laser_6.y < 270 then
				laser_6.y = laser_6.y + 20
			else
				laser_6.y = -270
			end

			if laser_7.y > -270 then
				laser_7.y = laser_7.y - laser_speed
			else
				laser_7.y = 270
			end

			if laser_8.y > -270 then
				laser_8.y = laser_8.y - laser_speed
			else
				laser_8.y = 270
			end

			if laser_9.y < 270 then
				laser_9.y = laser_9.y + 20
			else
				laser_9.y = -270
			end


			if HP == 4 then
				fulllife5.y = -700
			elseif HP == 3	then
				fulllife5.y = -700
				fulllife4.y = -700
			elseif HP == 2 then
				fulllife5.y = -700
				fulllife4.y = -700
				fulllife3.y = -700
			elseif HP == 1 then
				fulllife5.y = -700
				fulllife4.y = -700
				fulllife3.y = -700
				fulllife2.y = -700
			end

			if (HP<0) or (HP==0) then
				fulllife1.y = -700
				GameOver()
			end

			if(player.y < -360) then
				GameOver()
			elseif(player.y > 360) then
				GameOver()
			end
		end
--------------------------------------------------------------------------------------------------------

	function pipe(fn, x, y, width, height)
		piper = display.newImageRect(sceneGroup, fn, width, height)
		piper.x = x
		piper.y = y
		piper.surfaceType = "piper"
		physics.addBody(piper, "static")
		camera:add(piper, 5)
	end

	function case(fn, x, y, width, height)
		main_case = display.newImageRect(sceneGroup, fn, width, height)
		main_case.x = x
		main_case.y = y
		main_case.surfaceType = "case"
		physics.addBody(main_case, "dynamic")
		camera:add(main_case, 5)
	end

	function pipex(fn, x, y, width, height)
		piper = display.newImageRect(sceneGroup, fn, width, height)
		piper.x = x
		piper.y = y
		camera:add(piper, 5)
	end

		laser_1 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_1:rotate(90)
		laser_1.x = 2500
		laser_1.y =  -270
		physics.addBody(laser_1)
		laser_1.isSensor = true
		laser_1.gravityScale = 0
		camera:add(laser_1, 6)

		laser_2 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_2:rotate(90)
		laser_2.x = 4575
		laser_2.y =  -270
		physics.addBody(laser_2)
		laser_2.isSensor = true
		laser_2.gravityScale = 0
		camera:add(laser_2, 6)

		laser_3 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_3:rotate(90)
		laser_3.x = 4100
		laser_3.y =  270
		physics.addBody(laser_3)
		laser_3.isSensor = true
		laser_3.gravityScale = 0
		camera:add(laser_3, 6)

		laser_4 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_4:rotate(90)
		laser_4.x = 5500
		laser_4.y =  270
		physics.addBody(laser_4)
		laser_4.isSensor = true
		laser_4.gravityScale = 0
		camera:add(laser_4, 6)

		laser_5 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_5:rotate(90)
		laser_5.x = 6400
		laser_5.y =  270
		physics.addBody(laser_5)
		laser_5.isSensor = true
		laser_5.gravityScale = 0
		camera:add(laser_5, 6)

		laser_6 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_6:rotate(90)
		laser_6.x = 6400
		laser_6.y =  -270
		physics.addBody(laser_6)
		laser_6.isSensor = true
		laser_6.gravityScale = 0
		camera:add(laser_6, 6)

		laser_7 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_7:rotate(90)
		laser_7.x = 7200
		laser_7.y =  270
		physics.addBody(laser_7)
		laser_7.isSensor = true
		laser_7.gravityScale = 0
		camera:add(laser_7, 6)

		laser_8 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_8:rotate(90)
		laser_8.x = 8100
		laser_8.y =  270
		physics.addBody(laser_8)
		laser_8.isSensor = true
		laser_8.gravityScale = 0
		camera:add(laser_8, 6)

		laser_9 = display.newImageRect(sceneGroup, "img/game_objects/weapons/laser_red.png", 60, 20)
		laser_9:rotate(90)
		laser_9.x = 8100
		laser_9.y =  -270
		physics.addBody(laser_9)
		laser_9.isSensor = true
		laser_9.gravityScale = 0
		camera:add(laser_9, 6)
		--1
		local ramka_1 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_1.x = 2500
		ramka_1.y =  -270
		camera:add(ramka_1, 4)
		--2
		local ramka_2 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_2.x = 4100
		ramka_2.y =  210
		camera:add(ramka_2, 4)
		--3
		local ramka_3 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_3.x = 4575
		ramka_3.y =  -270
		camera:add(ramka_3, 4)
		--4
		local ramka_4 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_4.x = 5500
		ramka_4.y =  -270
		camera:add(ramka_4, 4)
		--5
		local ramka_5 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_5.x = 6400
		ramka_5.y =  -270
		camera:add(ramka_5, 4)

		--6
		local ramka_6 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_6.x = 6400
		ramka_6.y =  210
		camera:add(ramka_6, 4)

		--7
		local ramka_7 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_7.x = 7200
		ramka_7.y = 210
		camera:add(ramka_7, 4)

		--8
		local ramka_8 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_8.x = 8100
		ramka_8.y =  210
		camera:add(ramka_8, 4)

		--9
		local ramka_9 = display.newImageRect(sceneGroup, "img/decoretions/ramka_laser_red.png", 50, 50)
		ramka_9.x = 8100
		ramka_9.y =  -270
		camera:add(ramka_9, 4)



		--1
		pipe("img/Pipes/PipeDown_red.png", 700, 440, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 700, -604, 147, 864)
		--2
		pipe("img/Pipes/PipeDown_red.png", 1800, 704, 147, 864)
		pipe("img/Pipes/PipeUp_red.png", 1800, -460, 147, 864)
		case("img/decoretions/Main_decorations/Case_1.png", 1800, 0, 100, 100)
		case("img/decoretions/Main_decorations/Case_1.png", 1800, 0, 100, 100)


		--3

		--4

		--5

		--6

		--7

		--8

		--9

		--10

		--11

		--12

		--13

		--14

		--15

		--16

		--17


		local money = display.newImageRect(sceneGroup, "img/game_objects/moneys/money.png", 61, 60)
		money.x = X
		money.y = 100
		money.alpha = 0

		money_text = display.newText(sceneGroup, moneys, money.x + 100, money.y, system.nativeFont, 36)
		money_text.alpha = 0

		local money1 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_1.png", 61, 60)
		camera:add(money1, 3)
		money1.x = 2000
		money1.y = -182
		physics.addBody(money1)
		money1.gravityScale = 0

		local money2 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_5.png", 61, 60)
		camera:add(money2, 3)
		money2.x = 3000
		money2.y = 22
		physics.addBody(money2)
		money2.gravityScale = 0

		local money3 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_10.png", 61, 60)
		camera:add(money3, 3)
		money3.x = 4100
		money3.y = 202
		physics.addBody(money3)
		money3.gravityScale = 0

		local money4 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_5.png", 61, 60)
		camera:add(money4, 3)
		money4.x = 5900
		money4.y = 202
		physics.addBody(money4)
		money4.gravityScale = 0

		local money5 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_10.png", 61, 60)
		camera:add(money5, 3)
		money5.x = 6800
		money5.y = -182
		physics.addBody(money5)
		money5.gravityScale = 0

		local money6 = display.newImageRect(sceneGroup, "img/game_objects/moneys/money_10.png", 61, 60)
		camera:add(money6, 3)
		money6.x = 7700
		money6.y = 202
		physics.addBody(money6)
		money6.gravityScale = 0

		local finish = display.newImageRect(sceneGroup, "img/finishes/png/finishis.png", 100, 199)
		finish.x = 8600
		finish.y = 0
		finish.alpha = 1.0
		physics.addBody(finish)
		finish.gravityScale = 0
		camera:add(finish, 2)

		life1 = display.newImageRect(sceneGroup, lifename, 50, 43)
		life1.x = 70
		life1.y = -700
		life2 = display.newImageRect(sceneGroup, lifename, 50, 43)
		life2.x = 150
		life2.y = -700
		life3 = display.newImageRect(sceneGroup, lifename, 50, 43)
		life3.x = 230
		life3.y = -700
		life4 = display.newImageRect(sceneGroup, lifename, 50, 43)
		life4.x = 310
		life4.y = -700
		life5 = display.newImageRect(sceneGroup, lifename, 50, 43)
		life5.x = 390
		life5.y = -700

		fulllife1 = display.newImageRect(sceneGroup, fulllifename, 50, 43)
		fulllife1.x = 70
		fulllife1.y = -700
		fulllife2 = display.newImageRect(sceneGroup, fulllifename, 50, 43)
		fulllife2.x = 150
		fulllife2.y = -700
		fulllife3 = display.newImageRect(sceneGroup, fulllifename, 50, 43)
		fulllife3.x = 230
		fulllife3.y = -700
		fulllife4 = display.newImageRect(sceneGroup, fulllifename, 50, 43)
		fulllife4.x = 310
		fulllife4.y = -700
		fulllife5 = display.newImageRect(sceneGroup, fulllifename, 50, 43)
		fulllife5.x = 390
		fulllife5.y = -700

		--l_w_f is laser_weapon_finish is laser_weapon on finish--

		l_w_f = display.newImageRect(sceneGroup, weaponfile, 100, 100)
		l_w_f.x = 8600
		l_w_f.y = 0
		camera:add(l_w_f, 2)


		if MAX_HP == 3 then
			life1.y = 70
			life2.y = 70
			life3.y = 70

			fulllife1.y = 70
			fulllife2.y = 70
			fulllife3.y = 70
		elseif MAX_HP == 4 then
			life1.y = 70
			life2.y = 70
			life3.y = 70
			life4.y = 70

			fulllife1.y = 70
			fulllife2.y = 70
			fulllife3.y = 70
			fulllife4.y = 70
		elseif MAX_HP == 5 then
			life1.y = 70
			life2.y = 70
			life3.y = 70
			life4.y = 70
			life5.y = 70

			fulllife1.y = 70
			fulllife2.y = 70
			fulllife3.y = 70
			fulllife4.y = 70
			fulllife5.y = 70
		end

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
		function remover4(event)
			display.remove(money4)
		end
		function remover5(event)
			display.remove(money5)
		end
		function remover6(event)
			display.remove(money6)
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
					local function money5plus_2( self, event )
							local collideObject = event.other
							if ( collideObject.surfaceType == "bird" ) then
								money4:removeEventListener("collision")
								moneys = moneys + 5
								money_text.text = moneys
								moneys_visibles()
								timer.performWithDelay(1,function() return remover4(event) end )
							end
						end
					local function money10plus_2( self, event )
							local collideObject = event.other
							if ( collideObject.surfaceType == "bird" ) then
								money5:removeEventListener("collision")
								moneys = moneys + 10
								money_text.text = moneys
								moneys_visibles()
								timer.performWithDelay(1,function() return remover5(event) end )
							end
						end
						local function money10plus_3( self, event )
								local collideObject = event.other
								if ( collideObject.surfaceType == "bird" ) then
									money6:removeEventListener("collision")
									moneys = moneys + 10
									money_text.text = moneys
									moneys_visibles()
									timer.performWithDelay(1,function() return remover6(event) end )
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
					function laser_5_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_5.y = 270
						HP = HP - 1
						print(HP)
					end
					function laser_6_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_6.y = -270
						HP = HP - 1
						print(HP)
					end
					function laser_7_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_7.y = -270
						HP = HP - 1
						print(HP)
					end
					function laser_8_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_8.y = -270
						HP = HP - 1
						print(HP)
					end
					function laser_9_damage(event)
						damage = false
						timer.performWithDelay(nockout,	isdamage,	1)
						laser_9.y = -270
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
					local function lasercollision5( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_5_damage(event) end )
								end
							end
					end
					local function lasercollision6( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_6_damage(event) end )
								end
							end
					end
					local function lasercollision7( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_7_damage(event) end )
								end
							end
					end
					local function lasercollision8( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_8_damage(event) end )
								end
							end
					end
					local function lasercollision9( self, event )
						local collideObject = event.other
							if damage == true then
								if ( collideObject.surfaceType == "bird" ) then
									timer.performWithDelay(1,function() return laser_9_damage(event) end )
								end
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
		money4.collision =  money5plus_2
		money4:addEventListener("collision")
		money5.collision =  money10plus_2
		money5:addEventListener("collision")
		money6.collision =  money10plus_3
		money6:addEventListener("collision")
		laser_1.collision = lasercollision1
		laser_1:addEventListener("collision")
		laser_2.collision = lasercollision2
		laser_2:addEventListener("collision")
		laser_3.collision = lasercollision3
		laser_3:addEventListener("collision")
		laser_4.collision = lasercollision4
		laser_4:addEventListener("collision")
		laser_5.collision = lasercollision3
		laser_5:addEventListener("collision")
		laser_6.collision = lasercollision4
		laser_6:addEventListener("collision")
		laser_7.collision = lasercollision7
		laser_7:addEventListener("collision")
		laser_8.collision = lasercollision8
		laser_8:addEventListener("collision")
		laser_9.collision = lasercollision9
		laser_9:addEventListener("collision")

		function gotorestart()
			camera:destroy()
			composer.removeScene("scn.level3", false)
			composer.gotoScene("scn.restart3", { effect="crossFade", time=333 })
		end

		function gotowin()
			islevel2 = true
			camera:destroy()
			composer.removeScene("scn.level3", false)
			composer.gotoScene("scn.levels", { effect="crossFade", time=333 })
		end

		function GameOver()
			player.x = player.x + 20
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
