//
//  Coin.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 25.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: SKSpriteNode, GameSprite{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "goods.atlas")
    var value = 1
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 25, height: 25)) {
        parentNode.addChild(self)
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.texture = textureAtlas.textureNamed("bronze_1.png")
        self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
   
    func turnToGold(){
        
        self.texture = textureAtlas.textureNamed("gold_1.png")
        self.value = 5
        
    }
    func collect(){
        self.physicsBody?.categoryBitMask = 0
        let collectAnimation = SKAction.group([SKAction.fadeAlpha(to: 0, duration: 0.2),
                                               SKAction.scale(to: 1.5, duration: 0.2),
                                               SKAction.move(by: CGVector(dx: 0, dy: 25), duration: 0.2)])
        let resetAfterCollected = SKAction.run {
            self.position.y = 5000
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
            self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        }
        let collectSequence = SKAction.sequence([collectAnimation,resetAfterCollected])
        self.run(collectSequence)
    }
}
