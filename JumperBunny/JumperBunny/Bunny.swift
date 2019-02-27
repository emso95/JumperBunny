//
//  Bunny.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 23.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class Bunny: SKSpriteNode,GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "player.atlas")
    var walkAnimation = SKAction()
    var readyAnimation = SKAction()
    var isWalking = false
    var isLeft = false
    var isJumping = false
    var isDead = false
    var dieAnimation = SKAction()
    var jumpCount:Int = 0
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 40, height: 64)) {
        createAnimations()
        parentNode.addChild(self)
        self.size = size
        self.position = position
        let bodyTexture = textureAtlas.textureNamed("bunny1_ready.png")
        self.run(readyAnimation, withKey: "readyAnimation")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: size)
        self.physicsBody?.linearDamping = 0.9
        self.physicsBody?.mass = 30
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.bunny.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy.rawValue |
                                                PhysicsCategory.ground.rawValue |
                                                PhysicsCategory.coin.rawValue
    }
    func createAnimations(){
        let walkFrames: [SKTexture] = [
        textureAtlas.textureNamed("bunny1_walk1.png"),
        textureAtlas.textureNamed("bunny1_walk2.png")]
        let walkAction = SKAction.animate(with: walkFrames, timePerFrame: 0.3)
        walkAnimation = SKAction.repeatForever(walkAction)
        let readyFrames: [SKTexture] = [textureAtlas.textureNamed("bunny1_ready.png")]
        let readyAction = SKAction.animate(with: readyFrames, timePerFrame: 1)
        readyAnimation = SKAction.repeatForever(readyAction)
        
    }
    
    func update(){
        if self.isWalking{
            if self.isLeft{
                self.physicsBody?.velocity.dx = -200
            }
            else{
                self.physicsBody?.velocity.dx = 200
            }
        }
        else{
            self.physicsBody?.velocity.dx = 0
        }
    }
    func moveToLeft(){
        if !isDead{
            self.removeAction(forKey: "readyAnimation")
            self.xScale = -1
            self.run(walkAnimation, withKey: "walkingAnimation")
            self.isWalking = true
            self.isLeft = true
        }
    }
    func moveToRight(){
        if !isDead{
            self.removeAction(forKey: "readyAnimation")
            self.xScale = 1
            self.run(walkAnimation, withKey: "walkingAnimation")
            self.isWalking = true
            self.isLeft = false
        }
    }
    func stopWalking(){
        if !isDead{
            self.removeAction(forKey: "walkingAnimation")
            self.xScale = -1
            self.run(readyAnimation, withKey: "readyAnimation")
            self.isWalking = false
        }
    }
    func jump(){
        if !isDead && (jumpCount<=1){
            self.isJumping = true
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20000))
            jumpCount+=1
        }
    }
    func die(){
        self.removeAllActions()
        let dieAction = SKAction.animate(with: [textureAtlas.textureNamed("bunny1_hurt.png")], timePerFrame: 1)
        dieAnimation = SKAction.repeatForever(dieAction)
        self.run(dieAction)
        self.isDead = true
        self.physicsBody?.isDynamic = false
        if let gameScene = self.parent?.parent as? GameScene {
            gameScene.gameOver()
        }
    }
    func checkYPosition(){
        if self.position.y < -30{
            self.die()
        }
    }
    func resetJumpCount(){
        jumpCount = 0
    }
}
