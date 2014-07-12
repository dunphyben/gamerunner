//
//  PlayScene.swift
//  gamerunner
//
//  Created by Nancy Wong on 7/12/14.
//  Copyright (c) 2014 HackRunner Inc. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene, SKPhysicsContactDelegate {
    let runner = SKSpriteNode(imageNamed:"runner")
    let bar = SKSpriteNode(imageNamed:"bottomBar")
    let blockSmall = SKSpriteNode(imageNamed:"block1")
    let blockBig = SKSpriteNode(imageNamed:"block2")
    
    var barStartX = CGFloat(0)
    var maxBarX = CGFloat(0)
    var groundSpeed = 5
    var runnerBaseline = CGFloat(0)
    var onGround = true
    var yVelocity = CGFloat(0)
    let gravity = CGFloat(0.6)
    
    var blockMaxX = CGFloat(0)
    var blockStartX = CGFloat(0)
    
    enum ColliderType:UInt32 {
        case Runner = 1
        case Block = 2
    }
    
    override func didMoveToView(view: SKView!) {
        self.physicsWorld.contactDelegate = self
        
        // bottomBar positioning
        self.bar.anchorPoint = CGPointMake(0, 0.5)
        self.bar.position = CGPointMake(
            CGRectGetMinX(self.frame),
            CGRectGetMinY(self.frame) + (self.bar.size.height / 2))
        self.barStartX = self.bar.position.x
        self.maxBarX = self.bar.size.width - self.frame.size.width
        self.maxBarX *= -1
        
        // runner positioning
        self.runnerBaseline = self.bar.position.y + (self.bar.size.height / 2) +
            (self.runner.size.height / 2)
        
    }
}