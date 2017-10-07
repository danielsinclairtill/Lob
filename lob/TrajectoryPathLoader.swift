//
//  TrajectoryPathLoader.swift
//  lob
//
//  Created by Daniel Till on 10/6/17.
//  Copyright © 2017 Daniel Till. All rights reserved.
//

import UIKit
import SpriteKit

class TrajectoryPathLoader: NSObject {

    let gravity: CGFloat
    let startPosition: CGPoint
    let startVelocity: CGVector
    let numberOfTrajectoryDots: Int
    
    init(startPosition: CGPoint, startVelocity: CGVector, gravity: CGFloat = -9.8, numberOfDots: Int = 10 ) {
        self.startPosition = startPosition
        self.startVelocity = startVelocity
        self.numberOfTrajectoryDots = numberOfDots
        self.gravity = gravity
    }
    
    private func getTrajectoryXPoint(x: CGFloat) -> CGFloat {
        return startVelocity.dx * x + startPosition.x
    }
    
    private func getTrajectoryYPoint(y: CGFloat) -> CGFloat {
        return 0.5 * gravity * y * y + startVelocity.dy * y + startPosition.y
    }
    
    func getTrajectoryPath() -> [SKShapeNode] {
        var trajectoryDots: [SKShapeNode] = []
        for dot in 1...numberOfTrajectoryDots {
            let whiteBall = SKShapeNode(circleOfRadius: 5.0)
            whiteBall.fillColor = .white
            whiteBall.position = CGPoint(x: getTrajectoryXPoint(x: CGFloat(dot)), y: getTrajectoryYPoint(y: CGFloat(dot)))
            trajectoryDots.append(whiteBall)
        }
        return trajectoryDots
    }
}
