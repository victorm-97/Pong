push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_LENGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_LENGHT = 720

function love.load()

    wf = require "windfield-master/windfield"
    world = wf.newWorld(0, 0)
    push:setupScreen(WINDOW_WIDTH, WINDOW_LENGHT, VIRTUAL_WIDTH, VIRTUAL_LENGHT, {
        fullscreen = false

    })
    player = {}
    player.collider = world:newBSGRectangleCollider(50, 200, 40, 210, 10)
    player.collider:setFixedRotation(true)
    player.collider:setType('kinematic')

    player2 = {}
    player2.collider = world:newBSGRectangleCollider(1200, 200, 40, 210, 10)
    player2.collider:setFixedRotation(true)
    player2.collider:setType('kinematic')

    player.speed = 500
    width = 30
    length = 200
    timer = 99

    ball = {}
    ball.collider = world:newCircleCollider(650, 150, 30)
    ball.collider:setRestitution(1.0)

    ground = world:newRectangleCollider(0, 700, 1500, 20)
    ground:setType('static')
    roof = world:newRectangleCollider(0, 0, 1500, 20)
    roof:setType('static')

end

function love.update(dt)

    local vx = 0
    local vy = 0

    local vx2 = 0
    local vy2 = 0

    -- if love.keyboard.isDown("d") then
    --  vx = player.speed
    -- end

    -- if love.keyboard.isDown("a") then
    --    vx = player.speed * -1
    -- end

    if love.keyboard.isDown("w") then
        vy = player.speed * -1
    end
    if love.keyboard.isDown("s") then
        vy = player.speed
    end

    -- if love.keyboard.isDown("right") then
    --     vx2 = player.speed
    -- end

    -- if love.keyboard.isDown("left") then
    --      vx2 = player.speed * -1
    --  end

    if love.keyboard.isDown("up") then
        vy2 = player.speed * -1
    end
    if love.keyboard.isDown("down") then
        vy2 = player.speed
    end

    if love.keyboard.isDown("space") then
        ball.collider:applyForce(10000, 1000)
    end

    world:update(dt)
    player.x = player.collider:getX()
    player.y = player.collider:getY()

    player.collider:setLinearVelocity(vx, vy)

    player2.x = player2.collider:getX()
    player2.y = player2.collider:getY()

    player2.collider:setLinearVelocity(vx2, vy2)

    ball.x = ball.collider:getX()
    ball.y = ball.collider:getY()
    ball.collider:setAngularVelocity(1000)

    if timer >= 0 then
        timer = timer - dt
        printMsg = true
    end

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')
    love.graphics.setColor(1, 0, 1)
    love.graphics.rectangle("fill", (player.x - width / 2), (player.y - length / 2), width, length)

    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("fill", (player2.x - width / 2), (player2.y - length / 2), width, length)

    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", ball.x, ball.y, 30)

    if printMsg == true then
        love.graphics.print({{1, 0, 1}, timer}, 560, 50, 0, 2.5, 2.5)
    end

    if ball.x <= 0 then
        love.graphics.print({{1, 0, 1}, "Player 2 Wins!"}, 560, 100, 0, 2.5, 2.5)

    end
    if ball.x >= 1280 then
        love.graphics.print({{1, 0, 1}, "Player 1 Wins!"}, 560, 100, 0, 2.5, 2.5)
    end
    world:draw()
    push:apply('end')

end
