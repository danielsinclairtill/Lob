//
//  TrajectoryPath.swift
//  lob
//
//  Created by Daniel Till on 10/6/17.
//  Copyright © 2017 Daniel Till. All rights reserved.
//

import UIKit

class TrajectoryPath: NSObject {

    let gravity: CGFloat = -9.8
    let timeInterval: TimeInterval = 0.1
    let startPoint: CGPoint = CGPoint(x: 10, y: 10)
    let startVelocity: CGVector = CGVector(dx: 1, dy: 1)
    let yIncrement: CGFloat = 1.0
    
    private func getTrajectoryXPoint(x:CGFloat) -> CGFloat {
        return startVelocity.dx * x + startPoint.x
    }
    
    private func getTrajectoryYPoint(x:CGFloat) -> CGFloat {
        return 0.5 * gravity * x * x + startVelocity.dy * x + startPoint.y
    }
}
