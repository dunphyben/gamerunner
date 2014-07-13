//
//  GameScene.swift
//  gamerunner
//
//  Created by Benjamin Dunphy on 7/12/14.
//  Copyright (c) 2014 HackRunner Inc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let runner = SKSpriteNode(imageNamed:"runner")
    let bar = SKSpriteNode(imageNamed:"bottomBar")
    let blockSmall = SKSpriteNode(imageNamed:"blockSmall")
    let blockBig = SKSpriteNode(imageNamed:"blockBig")
    
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
        self.bar.anchorPoint = CGPointMake(0,0)
        self.bar.position = CGPointMake(
            CGRectGetMinX(self.frame),
            CGRectGetMinY(self.frame) + (self.bar.size.height / 2))
        self.barStartX = self.bar.position.x
        self.maxBarX = self.bar.size.width - self.frame.size.width
        self.maxBarX *= -1
        
        // runner positioning
        self.runner.xScale *= 0.3
        self.runner.yScale *= 0.3
        self.runnerBaseline = self.bar.position.y + (self.bar.size.height / 2) +
            (self.runner.size.height / 2)
        self.runner.position = CGPointMake(CGRectGetMinX(self.frame)
            + self.runner.size.width
            + (self.runner.size.width/4), self.runnerBaseline)
        self.runner.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.runner.size.width / 2))
        self.runner.physicsBody.affectedByGravity = false
        self.runner.physicsBody.categoryBitMask = ColliderType.Runner.toRaw()
        self.runner.physicsBody.contactTestBitMask = ColliderType.Block.toRaw()
        self.runner.physicsBody.collisionBitMask = ColliderType.Block.toRaw()
        
        // block 1 
        self.blockSmall.xScale *= 0.5
        self.blockSmall.yScale *= 0.5
        self.blockSmall.anchorPoint = CGPointMake(0,0)
        self.blockSmall.position = CGPointMake(CGRectGetMaxX(self.frame)
            + self.blockSmall.size.width, self.runnerBaseline)
        self.blockSmall.physicsBody = SKPhysicsBody(rectangleOfSize: self.blockSmall.size)
        self.blockSmall.physicsBody.dynamic = false
        self.blockSmall.physicsBody.categoryBitMask = ColliderType.Block.toRaw()
        self.blockSmall.physicsBody.contactTestBitMask = ColliderType.Runner.toRaw()
        self.blockSmall.physicsBody.collisionBitMask = ColliderType.Runner.toRaw()
        
        // block 2 positioning
        self.blockBig.xScale *= 0.5
        self.blockBig.yScale *= 0.5
        self.blockBig.anchorPoint = CGPointMake(0,0)
        self.blockBig.position = CGPointMake(CGRectGetMaxX(self.frame)
            + self.blockBig.size.width, self.runnerBaseline
                + (self.blockSmall.size.height / 2))
        self.blockBig.physicsBody = SKPhysicsBody(rectangleOfSize: self.blockSmall.size)
        self.blockBig.physicsBody.dynamic = false
        self.blockBig.physicsBody.categoryBitMask = ColliderType.Block.toRaw()
        self.blockBig.physicsBody.contactTestBitMask = ColliderType.Runner.toRaw()
        self.blockBig.physicsBody.collisionBitMask = ColliderType.Runner.toRaw()
        
        self.blockStartX = self.blockSmall.position.x
        
        self.blockSmall.name = "blockSmall"
        self.blockBig.name = "blockBig"
        
        blockStatuses["blockSmall"] = BlockStatus(isRunning: false, untilNextRun: random(), currentGap: UInt32(0))
        blockStatuses["blockBig"] = BlockStatus(isRunning: false, untilNextRun: random(), currentGap: UInt32(0))
        
        self.blockMaxX = 0 - self.blockSmall.size.width / 2
        
        self.addChild(self.bar)
        self.addChild(self.runner)
        self.addChild(self.blockSmall)
        self.addChild(self.blockBig)
    }
    
    func random() -> UInt32 {
        var range = UInt32(50)..<UInt32(200)
        return range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1)
    }
    
    var blockStatuses:Dictionary<String,BlockStatus> = [:]
    
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        if self.onGround {
            self.yVelocity = -18.0
            self.onGround = false
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        if self.yVelocity < -9.0 {
            self.yVelocity = -9.0
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        if self.bar.position.x <= maxBarX {
            self.bar.position.x = self.barStartX
        }
        
        // jump code
        self.yVelocity += self.gravity
        self.runner.position.y -= yVelocity
        
        if self.runner.position.y < self.runnerBaseline {
            self.runner.position.y = self.runnerBaseline
            yVelocity = 0.0
            self.onGround = true
        }
        
        // TO-DO: animate the hero
        
        // ground scrolling
        bar.position.x -= CGFloat(self.groundSpeed)
        
        blockRunner()
    }
    
    func blockRunner() {
        for(block, blockStatus) in self.blockStatuses {
            var myBlock = self.childNodeWithName(block)
            if blockStatus.shouldRunBlock() {
                blockStatus.untilNextRun = random()
                blockStatus.currentGap = 0
                blockStatus.isRunning = true
            }
            
            if blockStatus.isRunning {
                if myBlock.position.x > blockMaxX {
                    myBlock.position.x -= CGFloat(self.groundSpeed)
                } else {
                    myBlock.position.x = self.blockStartX
                    blockStatus.isRunning = false
                }
            } else {
                blockStatus.currentGap++
            }
        }
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