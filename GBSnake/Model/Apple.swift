//
//  Apple.swift
//  GBSnake
//
//  Created by Даниил Мурыгин on 30.10.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    convenience init(position: CGPoint) {
        self.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = .red
        self.position = position
        
        physicsBody = SKPhysicsBody(circleOfRadius: 10, center: CGPoint(x: 5, y: 5 ))
        physicsBody?.categoryBitMask = ColliderCategories.apple
        physicsBody?.contactTestBitMask = ColliderCategories.snakeHead
    }
}
