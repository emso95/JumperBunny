//
//  flyMan.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 24.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class FlyMan: SKSpriteNode,GameSprite{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    var jumpAnimation = SKAction()
    var standingAnimation = SKAction()
    var flyAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 40, height: 40)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.run(jumpAnimation)
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.bunny.rawValue
    }
    func createAnimations(){
        let jumpFrames:[SKTexture] = [textureAtlas.textureNamed("flyMan_jump.png")]
        let standingFrames:[SKTexture] = [textureAtlas.textureNamed("flyMan_stand.png"),
                                          textureAtlas.textureNamed("flyMan_still_stand")]
        let flyFrames:[SKTexture] = [textureAtlas.textureNamed("flyMan_stand.png"),
                                     textureAtlas.textureNamed("flyMan_still_stand")]
        
        let standingAction = SKAction.animate(with: standingFrames, timePerFrame: 0.2)
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.005)

        standingAnimation = SKAction.repeat(standingAction, count: 10)
        flyAnimation = SKAction.repeat(flyAction, count: 100)
        let standingGroup = SKAction.group([standingAnimation,SKAction.run {
            self.physicsBody?.affectedByGravity = true
            }])
        let flyGroup = SKAction.group([flyAnimation,SKAction.run {
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.velocity.dy = 0
            }])
        let jumpAction = SKAction.animate(with: jumpFrames, timePerFrame: 0.4)
        let jumpGroup = SKAction.group([jumpAction,
                                        SKAction.applyImpulse(CGVector(dx: 0, dy: 30), duration: 0.05)])
        
        let jumpingSequence = SKAction.sequence([standingGroup,jumpGroup,flyGroup])
        jumpAnimation = SKAction.repeatForever(jumpingSequence)
        
    }
}
