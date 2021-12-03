
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoTimerBasedExample()
	composer.gotoScene("game")
end

local function gotoEventHandlerExample()
	os.exit()
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view

	local title = display.newText(sceneGroup, "Virtual Controller Example", display.contentCenterX, 200, native.systemFont, 44)

	local timerExampleButton = display.newText(sceneGroup, "Play", display.contentCenterX, 400, native.systemFont, 64)
	timerExampleButton:setFillColor(1, 0.2, 0, 1)

	local eventHandlerButton = display.newText(sceneGroup, "Exit", display.contentCenterX, 600, native.systemFont, 64)
	eventHandlerButton:setFillColor(1, 0.2, 0, 1)

	timerExampleButton:addEventListener("tap", gotoTimerBasedExample)
	eventHandlerButton:addEventListener("tap", gotoEventHandlerExample)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

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
