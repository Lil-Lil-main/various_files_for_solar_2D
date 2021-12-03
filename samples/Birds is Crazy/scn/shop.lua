
local composer = require( "composer" )
local widget = require("widget")

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
		local rect1 = display.newRect(sceneGroup, X-400, Y-150, 120, 120)
		local b1 = display.newImageRect(sceneGroup, "img/birds/Bird1.png", 98, 72)
		b1.x = X-400
		b1.y = Y-150



		local function ploskiy()
			filename = bird1ploskiy
		end

		local rect2 = display.newRect(sceneGroup, X-250, Y-150, 120, 120)
		if birdislock2 == false then
			local b2 = display.newImageRect(sceneGroup, "img/birds/Bird2.png", 98, 72)
			b2.x = X-250
			b2.y = Y-150
			local function ploskiy2()
					filename = bird2_anim
			end
			rect2:addEventListener("tap", ploskiy2)
		else
			local b2 = display.newImageRect(sceneGroup, "img/UI/Lock_1.png", 98, 82)
			b2.x = X-250
			b2.y = Y-150
		end

		local rect3 = display.newRect(sceneGroup, X-100, Y-150, 120, 120)
		if birdislock3 == false then
			local b3 = display.newImageRect(sceneGroup, "img/birds/Bird3.png", 98, 72)
			b3.x = X-100
			b3.y = Y-150
			local function ploskiy3()
				filename = bird3_anim
			end
			rect3:addEventListener("tap", ploskiy3)
	  else
			local b3 = display.newImageRect(sceneGroup, "img/UI/Lock_1.png", 98, 82)
			b3.x = X-100
			b3.y = Y-150
		end

		local function canclefunc()
		    composer.removeScene("levels", false)
		    composer.gotoScene( "scn.menu", { effect="crossFade", time=333 } )
		end
		local doneButton = widget.newButton({
		        id = "button1",
		        label = "Cancel",
		    })
	  doneButton.x = display.contentCenterX
		doneButton.y = display.contentHeight
		sceneGroup:insert( doneButton )

	 doneButton:addEventListener("tap", canclefunc)
		rect1:addEventListener("tap", ploskiy)

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
