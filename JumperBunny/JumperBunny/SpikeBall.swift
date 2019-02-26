//
//  SpikeBall.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 25.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class SpikeBall: SKSpriteNode, GameSprite{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "enemies")
    var spinAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 70, height: 70)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        let bodyTexture = textureAtlas.textureNamed("spikeBall1.png")
        self.texture = bodyTexture
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.run(spinAnimation)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.bunny.rawValue
    }
    
    func createAnimations(){
        let spinFrames: [SKTexture] = [textureAtlas.textureNamed("spikeBall1.png"),
                                       textureAtlas.textureNamed("spikeBall_2.png")]
        let spinAction = SKAction.animate(with: spinFrames, timePerFrame: 0.05)
        spinAnimation = SKAction.repeatForever(spinAction)
    }
}
