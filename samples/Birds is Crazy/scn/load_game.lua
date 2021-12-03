
local composer = require( "composer" )

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
		local background = display.newImageRect(sceneGroup, "img/logotips/test.png", 720*2.3, 1080)
		background.x = X
		background.y = Y
		background.alpha = 0
		local function isalpha()
			background.alpha = background.alpha + 0.1
		end

		local function notalpha()
			background.alpha = background.alpha - 0.1
		end

		timer.performWithDelay(100, isalpha, 12 )
		local function test()
			timer.performWithDelay(100, notalpha, 12 )
		end
		timer.performWithDelay(2400, test, 1)
		local function gogo()
			composer.gotoScene("scn.menu", { effect="crossFade", time=1000 })
		end
		timer.performWithDelay( 3600, gogo, 1 )
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on
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
