//
//  GameScene.swift
//  lob
//
//  Created by Daniel Till on 9/21/17.
//  Copyright © 2017 Daniel Till. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // initialization
    enum ColliderType: UInt32 {
        case player = 1
        case wall = 2
        case floor = 4
        case basketball = 16
        case net = 32
    }
    
    let background = SKSpriteNode(imageNamed: "Background")
    let floor = SKSpriteNode()
    let player = SKSpriteNode(imageNamed: "PlayerStand")
    let basketball = SKSpriteNode(imageNamed: "Ball")
    let net = SKSpriteNode(imageNamed: "Net")

    var trajectoryTimer: Timer?
    var trajectoryPath: [SKShapeNode] = []
    var shootVector: CGVector = CGVector(dx: 5, dy: 0)
    
    override func didMove(to view: SKView) {

        // background setup
        let bounds:CGSize = frame.size
        backgroundColor = SKColor.white
        background.zPosition = -10.0
        background.scale(to: frame.size)
        background.position = CGPoint(x: bounds.width / 2 , y: bounds.height / 2)
        
        // player setup
        player.position = CGPoint(x: player.size.width / 2 + 30, y: 160)
        
        // floor setup
        floor.zPosition = 1
        let floorPosition: CGPoint = CGPoint(x: bounds.width / 2, y: player.position.y - player.size.height / 2)
        let floorSize: CGSize = CGSize(width: bounds.width, height: 1)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floorSize, center: floorPosition)
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.categoryBitMask = ColliderType.floor.rawValue
        
        // basketball setup
        basketball.zPosition = 1
        basketball.position = CGPoint(x: player.size.width / 2 + 36, y: 158)
        basketball.physicsBody = SKPhysicsBody(circleOfRadius: basketball.size.height / 2)
        basketball.physicsBody?.collisionBitMask = ColliderType.floor.rawValue
        basketball.physicsBody?.affectedByGravity = true
        //basketball.physicsBody?.mass = 0.01
        
        // net setup
        net.zPosition = 1
        net.setScale(0.7)
        net.position = CGPoint(x: bounds.width - net.size.width / 2 - 30, y: player.position.y - player.size.height / 2 + net.size.height / 2)
        let texturedNet = SKTexture(imageNamed: "Net")
        net.physicsBody = SKPhysicsBody(texture: texturedNet, size: net.size)
        net.physicsBody?.categoryBitMask = ColliderType.floor.rawValue
        net.physicsBody?.isDynamic = false

        // add nodes
        addChild(background)
        addChild(floor)
        addChild(player)
        addChild(basketball)
        addChild(net)
    }
}

// MARK: Touches

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        /* Called when a touch begins */
        // Retrieve location of touch
        if let touch = touches.first {
            basketball.position = CGPoint(x: player.size.width / 2 + 36, y: 158)
            let touchPosition = touch.location(in: view)
            prepareShoot()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /* Called when a touch ends */
        trajectoryTimer?.invalidate()
        basketball.physicsBody?.applyImpulse(shootVector)
    }

    private func prepareShoot() {
        trajectoryTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(changeTrajectory), userInfo: nil, repeats: true)
    }

    @objc private func changeTrajectory(){
        
        // remove current trajectory
        for dot in trajectoryPath {
            dot.removeFromParent()
        }
        trajectoryPath = []
        
        // update to new trajectory
        shootVector.dy += 1
        let trajectoryPathLoader = TrajectoryPathLoader(startPosition: basketball.position, startVelocity: CGVector(dx: shootVector.dx, dy: shootVector.dy))
        trajectoryPath = trajectoryPathLoader.getTrajectoryPath()
        
        for dot in trajectoryPath {
            addChild(dot)
        }
    }
}
