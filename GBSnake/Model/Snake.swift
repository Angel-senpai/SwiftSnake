//
//  Snake.swift
//  GBSnake
//
//  Created by Даниил Мурыгин on 30.10.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    let diameter = 10.0
    
    init(position: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0,
                                           y: 0,
                                           width: diameter,
                                           height: diameter)).cgPath
        fillColor = .green
        physicsBody = SKPhysicsBody(circleOfRadius: 10, center: CGPoint(x: 5, y: 5 ))
        physicsBody?.categoryBitMask = ColliderCategories.snake
        physicsBody?.contactTestBitMask = ColliderCategories.apple | ColliderCategories.edgeBody
        self.position = position
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnakeHead: SnakeBodyPart{
    override init(position: CGPoint){
        super.init(position: position)
        
        physicsBody?.categoryBitMask = ColliderCategories.snakeHead
        physicsBody?.contactTestBitMask = ColliderCategories.apple | ColliderCategories.snake | ColliderCategories.edgeBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class Snake: SKShapeNode {
    var body = [SnakeBodyPart]()
    
    let moveSpeed = 125.0
    var angle: CGFloat = 0.0
    
    
    convenience init(position: CGPoint) {
        self.init()
        let head = SnakeHead(position: position)
        body.append(head)
        addChild(head)
    }
    func addBody() {
        let bodyPart = SnakeBodyPart(position: CGPoint(x: body[0].position.x, y: body[0].position.y))
        body.append(bodyPart)
        addChild(bodyPart)
    }
    
    func move() {
        guard !body.isEmpty else {return}
        
        let head = body[0]
        moveHead(head: head)
        
        for pos in (1..<body.count){
            let previous = body[pos - 1]
            let next = body[pos]
            moveBodyPart(previous: previous, next: next)
        }
        
    }
    func moveHead(head: SnakeBodyPart) {
        let dx = CGFloat(moveSpeed) * sin(angle)
        let dy = CGFloat(moveSpeed) * cos(angle)
        
        let newPosition = CGPoint(x: head.position.x + dx,
                                  y: head.position.y + dy)
        let moveAction = SKAction.move(to: newPosition,
                                       duration: 1)
        head.run(moveAction)
        
    }
    

    
    func moveBodyPart(previous: SnakeBodyPart, next: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: previous.position.x,
                                                   y: previous.position.y),
                                       duration: 0.1)
        next.run(moveAction)
    }
}
