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
        
//        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch : AnyObject in touches {
            let location = touch.locationInNode(self)
            
            //Make the sprite jump a bit.
            
        }
        
        /* Called when a touch begins */
        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //Spin the Runner.
        runner.runAction(SKAction.rotateByAngle(CGFloat(M_PI/24), duration:1))
    }
}
