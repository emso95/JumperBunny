//
//  WingMan.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 25.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class WingMan: SKSpriteNode,GameSprite{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    var flyAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 40, height: 40)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.run(flyAnimation)
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.bunny.rawValue
    }
    func createAnimations(){
        let flyFrames: [SKTexture] = [textureAtlas.textureNamed("wingMan2.png"),
                                      textureAtlas.textureNamed("wingMan3.png"),
                                      textureAtlas.textureNamed("wingMan4.png"),
                                      textureAtlas.textureNamed("wingMan3.png"),]
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.2)
        flyAnimation = SKAction.repeatForever(flyAction)
        let rightVel = SKAction.moveBy(x: 200, y: 0, duration: 2)
        let leftVel = SKAction.moveBy(x: -200, y: 0, duration: 2)
        let seq = SKAction.sequence([rightVel,leftVel])
        let neverEnding = SKAction.repeatForever(seq)
        self.run(neverEnding)
        
    }
}
