//
//  GameViewController.swift
//  GBSnake
//
//  Created by Даниил Мурыгин on 30.10.2019.
//  Copyright © 2019 Даниил Мурыгин. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameScene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
        gameScene.scaleMode = .resizeFill
        skView.presentScene(gameScene)
        
        }

}
