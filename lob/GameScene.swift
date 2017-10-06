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
    let background = SKSpriteNode(imageNamed: "Background")
    let player = SKSpriteNode(imageNamed: "PlayerStand")
    let basketball = SKSpriteNode(imageNamed: "Ball")
    let net = SKSpriteNode(imageNamed: "Net")
    
    override func didMove(to view: SKView) {

        // background setup
        let bounds:CGSize = frame.size
        backgroundColor = SKColor.white
        background.zPosition = -10.0
        background.scale(to: frame.size)
        background.position = CGPoint(x: bounds.width / 2 , y: bounds.height / 2)
        
        // player setup
        player.position = CGPoint(x: player.size.width / 2 + 30, y: 160)
        
        // basketball setup
        basketball.zPosition = 1
        basketball.position = CGPoint(x: player.size.width / 2 + 36, y: 158)
        
        // net setup
        net.zPosition = 1
        net.setScale(0.7)
        net.position = CGPoint(x: bounds.width - net.size.width / 2 - 30, y: player.position.y - player.size.height / 2 + net.size.height / 2)

        // add nodes
        addChild(background)
        addChild(player)
        addChild(basketball)
        addChild(net)
    }
}
