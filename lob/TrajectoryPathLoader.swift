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
    let timeFrame: CGFloat
    let numberOfTrajectoryDots: Int
    
    init(startPosition: CGPoint, startVelocity: CGVector, gravity: CGFloat = -38.0, dotFrequency: CGFloat = 2, numberOfDots: Int = 10 ) {
        self.startPosition = startPosition
        self.startVelocity = CGVector(dx: startVelocity.dy * 17.5, dy: startVelocity.dy * 17.5)
        self.timeFrame = 1.0 / dotFrequency
        self.numberOfTrajectoryDots = numberOfDots
        self.gravity = gravity
    }
    
    private func getTrajectoryXPoint(t: CGFloat) -> CGFloat {
        return startVelocity.dx * t + startPosition.x
    }
    
    private func getTrajectoryYPoint(t: CGFloat) -> CGFloat {
        return 0.5 * gravity * t * t + startVelocity.dy * t + startPosition.y
    }
    
    func getTrajectoryPath() -> [SKShapeNode] {
        var trajectoryDots: [SKShapeNode] = []
        var dotTimeFrame: CGFloat = timeFrame
        for dot in 1...numberOfTrajectoryDots {
            let whiteBall = SKShapeNode(circleOfRadius: 4.0)
            whiteBall.fillColor = .white
            whiteBall.position = CGPoint(x: getTrajectoryXPoint(t: dotTimeFrame), y: getTrajectoryYPoint(t: dotTimeFrame))
            trajectoryDots.append(whiteBall)
            dotTimeFrame += timeFrame
        }
        return trajectoryDots
    }
}
