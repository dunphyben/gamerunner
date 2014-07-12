//
//  GameScene.swift
//  gamerunner
//
//  Created by Benjamin Dunphy on 7/12/14.
//  Copyright (c) 2014 HackRunner Inc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let _runnerWidth = 75
    let _runnerHeight = 50
    let gravity = CGFloat(0.6)
    
    var groundSpeed = 5
    var onGround = true
    var velocY = CGFloat(0)
    
    let ground:SKSpriteNode = SKSpriteNode(imageNamed:"ground.png")
    let runner:SKSpriteNode = SKSpriteNode(imageNamed: "runner.png")
    
    override func didMoveToView(view: SKView) {
//        physicsWorld.contactDelegate = self
        
        runner.size = CGSize(width: _runnerWidth, height: _runnerHeight)
        runner.zPosition = 100
        runner.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        runner.position = CGPoint(x: 100, y: 100)
        self.addChild(runner);  //adds the sprite to the scene for drawing
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch : AnyObject in touches {
            let location = touch.locationInNode(self)
<<<<<<< HEAD
            let skView = self.view as SKView
            skView.ignoresSiblingOrder = true
            var scene = PlayScene(size: self.size)
            scene.scaleMode = .ResizeFill
            scene.size = skView.bounds.size
            skView.presentScene(scene)
=======
            
            //Make the sprite jump a bit.
            
>>>>>>> master
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
<<<<<<< HEAD
=======
        //Spin the Runner.
        runner.runAction(SKAction.rotateByAngle(CGFloat(M_PI/24), duration:1))
>>>>>>> master
    }
}

class BlockStatus {
    var isRunning = false
    var untilNextRun = UInt32(0)
    var currentGap = UInt32(0)
    init(isRunning:Bool, untilNextRun:UInt32, currentGap:UInt32) {
        self.isRunning = isRunning
        self.untilNextRun = untilNextRun
        self.currentGap = currentGap
    }
    
    func shouldRunBlock() -> Bool {
        return self.currentGap > self.untilNextRun
    }
}
