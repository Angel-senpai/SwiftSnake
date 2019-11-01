//
//  GameScene.swift
//  GBSnake
//
//  Created by Даниил Мурыгин on 30.10.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var snake:Snake!
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        view.showsPhysics = true
        
        physicsBody?.categoryBitMask = ColliderCategories.edgeBody
        physicsBody?.contactTestBitMask = ColliderCategories.snake | ColliderCategories.snakeHead
        
        let counterClockwise = SKShapeNode()
        counterClockwise.path = UIBezierPath(ovalIn: CGRect(x: 0,
                                                            y: 0,
                                                            width: 45,
                                                            height: 45)).cgPath
        counterClockwise.position = CGPoint(x: view.bounds.minX + view.frame.width * 0.04,
                                            y: view.bounds.minY + view.frame.height * 0.02)
        counterClockwise.fillColor = .gray
        counterClockwise.name = "leftButton"
        
        let clockwise = SKShapeNode()
        clockwise.path = UIBezierPath(ovalIn: CGRect(x: 0,
                                                            y: 0,
                                                            width: 45,
                                                            height: 45)).cgPath
        clockwise.position = CGPoint(x: view.bounds.maxX - view.frame.width * 0.145,
                                     y: view.bounds.minY + view.frame.height * 0.02)
        clockwise.fillColor = .gray
        clockwise.name = "RightButton"
        
        addChild(counterClockwise)
        addChild(clockwise)
        createApple()
        
        snake = Snake(position: CGPoint(x: frame.midX, y: frame.midY))
        addChild(snake)
        }
    
    func createApple() {
        let randPoint = CGPoint(x: CGFloat(arc4random_uniform(UInt32(frame.maxX - frame.width * 0.02))),
                                y: CGFloat(arc4random_uniform(UInt32(frame.maxY - frame.height * 0.02))))
        
        let apple = Apple(position: randPoint)
        addChild(apple)
    }
    
    func moveLeft(){
        snake?.angle -= CGFloat(Double.pi / 2)
    }
    
    func moveRight(){
        snake?.angle += CGFloat(Double.pi / 2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            
            guard let node = atPoint(touchLocation) as? SKShapeNode,
                node.name == "leftButton" || node.name == "RightButton"  else {
                return
            }
            node.fillColor = .yellow
            
            node.name == "leftButton" ? moveLeft() : moveRight()
    }
}

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       for touch in touches{
           let touchLocation = touch.location(in: self)
           
           guard let node = atPoint(touchLocation) as? SKShapeNode,
               node.name == "leftButton" || node.name == "RightButton"  else {
               return
           }
           node.fillColor = .gray
       }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake?.move()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let unownedObj = bodies ^ ColliderCategories.snakeHead
        
        switch unownedObj {
            case ColliderCategories.apple:
                let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
                snake?.addBody()
                apple?.removeFromParent()
                createApple()
            case ColliderCategories.snake: break
            case ColliderCategories.edgeBody: updateScene()
                
        default:break
        }
    }
    
    func updateScene() {
        
        for obj in children{
            if obj is Apple || obj is Snake{
                obj.removeFromParent()
            }
        }
        
        snake = Snake(position: CGPoint(x: frame.midX, y: frame.midY))
        addChild(snake)
        createApple()
    }

}
