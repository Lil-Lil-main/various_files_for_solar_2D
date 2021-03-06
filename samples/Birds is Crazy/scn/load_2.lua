--
-- local composer = require( "composer" )
--
-- local scene = composer.newScene()
--
-- -- -----------------------------------------------------------------------------------
-- -- Code outside of the scene event functions below will only be executed ONCE unless
-- -- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -- -----------------------------------------------------------------------------------
--
--
--
--
-- -- -----------------------------------------------------------------------------------
-- -- Scene event functions
-- -- -----------------------------------------------------------------------------------
--
-- -- create()
-- function scene:create( event )
--
-- 	local sceneGroup = self.view
-- 	-- Code here runs when the scene is first created but has not yet appeared on screen
--
-- end
--
--
-- -- show()
-- function scene:show( event )
--
-- 	local sceneGroup = self.view
-- 	local phase = event.phase
--
-- 	if ( phase == "will" ) then
-- 		-- Code here runs when the scene is still off screen (but is about to come on screen)
-- 		local background = display.newImageRect(sceneGroup, "img/backgrounds/background1.png", 720*2.5, 1080*2.5)
-- 		background.x = X
-- 		background.y = Y
--
-- 		camera = perspective.createView()
-- 		camera:setBounds(0, 4000 ,0,	0)
-- 		sceneGroup:insert(camera)
--
-- 		local player = display.newImageRect(sceneGroup, filename, 98, 72)
--
-- 		camera:add(player)
-- 		camera:setFocus(player)
-- 		camera:track()
--
-- 		local pouchitel = display.newRect(sceneGroup, X*1.674, 360, 670, Y*2)
-- 		pouchitel:setFillColor(1, 1, 1, 0.7)
--
-- 		nums = 3
-- 		local text = display.newText(sceneGroup, nums, )
--
-- 	elseif ( phase == "did" ) then
-- 		-- Code here runs when the scene is entirely on
-- 	end
-- end
--
--
-- -- hide()
-- function scene:hide( event )
--
-- 	local sceneGroup = self.view
-- 	local phase = event.phase
--
-- 	if ( phase == "will" ) then
-- 		-- Code here runs when the scene is on screen (but is about to go off screen)
--
-- 	elseif ( phase == "did" ) then
-- 		-- Code here runs immediately after the scene goes entirely off screen
--
-- 	end
-- end
--
--
-- -- destroy()
-- function scene:destroy( event )
--
-- 	local sceneGroup = self.view
-- 	-- Code here runs prior to the removal of scene's view
--
-- end
--
--
-- -- -----------------------------------------------------------------------------------
-- -- Scene event function listeners
-- -- -----------------------------------------------------------------------------------
-- scene:addEventListener( "create", scene )
-- scene:addEventListener( "show", scene )
-- scene:addEventListener( "hide", scene )
-- scene:addEventListener( "destroy", scene )
-- -- -----------------------------------------------------------------------------------
--
-- return scene
