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
        
        
        /*let pathLeft = SKAction.move(by: CGVector(dx: -200, dy: -10), duration: 2)
        let pathRight = SKAction.move(by: CGVector(dx: 200, dy: 10), duration: 2)
        let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
        let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
        let walkingBunny = SKAction.sequence([pathRight,flipTextureNegative,pathLeft,flipTexturePositive])
        wandering = SKAction.repeatForever(walkingBunny)*/
        
    }
    func onTap() {
        
    }
    func update(){
        if self.isWalking && !self.isJumping{
            if self.isLeft{
                self.physicsBody?.velocity.dx = -200
            }
            else{
                self.physicsBody?.velocity.dx = 200
            }
        }
        else if self.isWalking && self.isJumping{
            
        }
        else{
            self.physicsBody?.velocity.dx = 0
        }
    }
    func moveToLeft(){
        self.removeAction(forKey: "readyAnimation")
        self.xScale = -1
        self.run(walkAnimation, withKey: "walkingAnimation")
        self.isWalking = true
        self.isLeft = true
    }
    func moveToRight(){
        self.removeAction(forKey: "readyAnimation")
        self.xScale = 1
        self.run(walkAnimation, withKey: "walkingAnimation")
        self.isWalking = true
        self.isLeft = false
    }
    func stopWalking(){
        self.removeAction(forKey: "walkingAnimation")
        self.xScale = -1
        self.run(readyAnimation, withKey: "readyAnimation")
        self.isWalking = false
    }
    func jump(){
        self.removeAllActions()
    }
}
