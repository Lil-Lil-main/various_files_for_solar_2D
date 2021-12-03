
local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json");
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

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		local function handleButtonEvent( event )
				if ("began" == event.phase) then
					print("Button:phase is started!")
		    elseif ( "ended" == event.phase ) then
					composer.gotoScene("scn.levels", { effect="crossFade", time=333 } )

		    end
		end

		local function handleButtonEvent2( event )
				if ("began" == event.phase) then
					print("Button:phase is started!")
				elseif ( "ended" == event.phase ) then
					os.exit(  )
				end
		end

		local function handleButtonEvent3( event )
				if ("began" == event.phase) then
					print("Button:phase is started!")
				elseif ( "ended" == event.phase ) then
					composer.gotoScene("scn.shop", { effect="crossFade", time=333 } )

				end
		end

		local function handleButtonEvent4( event )
				if ("began" == event.phase) then
					print("Button:phase is started!")
				elseif ( "ended" == event.phase ) then
					composer.gotoScene("scn.options", { effect="crossFade", time=333 } )

				end
		end

		button_Start = widget.newButton(
																		{

																			width = 200,
																			height = 200,
																			defaultFile = "img/widgets/b.png",
																			overFile = "img/widgets/b2.png",
																			label = "Start",
																			fontSize = 40
																		}
																	)
		sceneGroup:insert(button_Start)
    button_Start.x = display.contentCenterX - 410
		button_Start.y = display.contentCenterY
		button_Start:addEventListener("touch", handleButtonEvent)

		button_Exit = widget.newButton(
																		{

																			width = 200,
																			height = 200,
																			defaultFile = "img/widgets/b.png",
																			overFile = "img/widgets/b2.png",
																			label = "Exit",
																			fontSize = 40
																		}
																	)
		sceneGroup:insert(button_Exit)
    button_Exit.x = display.contentCenterX + 410
		button_Exit.y = display.contentCenterY
		button_Exit:addEventListener("touch", handleButtonEvent2)

		button_Shop = widget.newButton(
																		{

																			width = 200,
																			height = 200,
																			defaultFile = "img/widgets/b.png",
																			overFile = "img/widgets/b2.png",
																			label = "Shop",
																			fontSize = 40
																		}
																	)
		sceneGroup:insert(button_Shop)
		button_Shop.x = display.contentCenterX -140
		button_Shop.y = display.contentCenterY
		button_Shop:addEventListener("touch", handleButtonEvent3)

		button_Options = widget.newButton(
																		{

																			width = 200,
																			height = 200,
																			defaultFile = "img/widgets/b.png",
																			overFile = "img/widgets/b2.png",
																			label = "Options",
																			fontSize = 40
																		}
																	)
		sceneGroup:insert(button_Options)
		button_Options.x = display.contentCenterX +140
		button_Options.y = display.contentCenterY
		button_Options:addEventListener("touch", handleButtonEvent4)
		--button_Start.label.fontSize = 72
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
		composer.removeScene("scn.menu")
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
