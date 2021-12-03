local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )

local perspective = require("scn.perspective")
local myData = require( "mydata" )

local camera = perspective.createView()
camera:setBounds(0, 720, 0, 1080)

if islevel1 == true then
  l2 = "2"
end

if islevel2 == true then
  l3 = "3"
end

local function gotolevel1()
    composer.removeScene("scn.levels", false)
    composer.gotoScene( "scn.level1", { effect="crossFade", time=333 } )
end

local function gotolevel2()
  if islevel1 == true then
    composer.removeScene("scn.levels", false)
    composer.gotoScene( "scn.level2", { effect="crossFade", time=333 } )
  else
    print("Noo")
  end
end

local function gotolevel3()
  if islevel2 == true then
    composer.removeScene("scn.levels", false)
    composer.gotoScene( "scn.level3", { effect="crossFade", time=333 } )
  else
    print("Noo")
  end
end

local function canclefunc()
    composer.removeScene("scn.levels", false)
    composer.gotoScene( "scn.menu", { effect="crossFade", time=333 } )
end

function scene:create( event )
    local sceneGroup = self.view

    -- Create background

    local background = display.newRect( 0, 0, display.contentWidth + 300, display.contentHeight )
    background:setFillColor( 1 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert( background )
        buttons1 = widget.newButton({
            label = tostring( 1 ),
            id = tostring( 1),
						fontSize = 72,
            onEvent = handleLevelSelect,
            emboss = false,
            shape="roundedRect",
            width = 150,
            height = 150,
            font = native.systemFontBold,
            fontSize = 18,
            labelColor = { default = { 1, 1, 1 }, over = { 0.5, 0.5, 0.5 } },
            cornerRadius = 8,
            labelYOffset = -6,
            fillColor = { default={ 0, 0.5, 1, 1 }, over={ 0.5, 0.75, 1, 1 } },
            strokeColor = { default={ 0, 0, 1, 1 }, over={ 0.333, 0.667, 1, 1 } },
            strokeWidth = 2
        })
				buttons1.x = display.contentCenterX - 400
				buttons1.y = display.contentCenterY - 150

        buttons3 = widget.newButton({
          label = l3,
        	fontSize = 72,
          onEvent = handleLevelSelect,
          emboss = false,
          shape="roundedRect",
          width = 150,
          height = 150,
          font = native.systemFontBold,
          fontSize = 18,
          labelColor = { default = { 1, 1, 1 }, over = { 0.5, 0.5, 0.5 } },
          cornerRadius = 8,
          labelYOffset = -6,
          fillColor = { default={ 0, 0.5, 1, 1 }, over={ 0.5, 0.75, 1, 1 } },
          strokeColor = { default={ 0, 0, 1, 1 }, over={ 0.333, 0.667, 1, 1 } },
          strokeWidth = 2
                })
        				buttons3.x = display.contentCenterX - 60
        				buttons3.y = display.contentCenterY - 150


buttons2 = widget.newButton({
  label = l2,
	fontSize = 72,
  onEvent = handleLevelSelect,
  emboss = false,
  shape="roundedRect",
  width = 150,
  height = 150,
  font = native.systemFontBold,
  fontSize = 18,
  labelColor = { default = { 1, 1, 1 }, over = { 0.5, 0.5, 0.5 } },
  cornerRadius = 8,
  labelYOffset = -6,
  fillColor = { default={ 0, 0.5, 1, 1 }, over={ 0.5, 0.75, 1, 1 } },
  strokeColor = { default={ 0, 0, 1, 1 }, over={ 0.333, 0.667, 1, 1 } },
  strokeWidth = 2
        })
				buttons2.x = display.contentCenterX - 230
				buttons2.y = display.contentCenterY - 150

    local doneButton = widget.newButton({
        id = "button1",
        label = "Cancel",
    })
    doneButton.x = display.contentCenterX
    doneButton.y = display.contentHeight - 20
    sceneGroup:insert( doneButton )
		sceneGroup:insert( buttons1 )
    sceneGroup:insert( buttons2 )
    sceneGroup:insert( buttons3 )

    buttons1:addEventListener("tap", gotolevel1)
    buttons2:addEventListener("tap", gotolevel2)
    buttons3:addEventListener("tap", gotolevel3)
    doneButton:addEventListener("tap", canclefunc)


end

-- On scene show...
function scene:show( event )
    local sceneGroup = self.view

    if ( event.phase == "did" ) then
    end
end

-- On scene hide...
function scene:hide( event )
    local sceneGroup = self.view

    if ( event.phase == "will" ) then
    end
end

-- On scene destroy...
function scene:destroy( event )
    local sceneGroup = self.view
end

-- Composer scene listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
