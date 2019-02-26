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
    var coinAnimation = SKAction()
    var value = 1
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 35, height: 35)) {
        parentNode.addChild(self)
        createAnimation()
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.run(coinAnimation)
    }
    func createAnimation(){
        let coinFrames:[SKTexture] = [textureAtlas.textureNamed("bronze_1.png"),
                                      textureAtlas.textureNamed("bronze_2.png"),
                                      textureAtlas.textureNamed("bronze_3.png"),
                                      //textureAtlas.textureNamed("bronze_4.png"),
                                      textureAtlas.textureNamed("bronze_3.png"),
                                      textureAtlas.textureNamed("bronze_2.png")]
        let coinAction = SKAction.animate(with: coinFrames, timePerFrame: 0.5)
        coinAnimation = SKAction.repeatForever(coinAction)
    }
    func turnToGold(){
        self.removeAllActions()
        let coinFrames:[SKTexture] = [textureAtlas.textureNamed("gold_1.png"),
                                      textureAtlas.textureNamed("gold_2.png"),
                                      textureAtlas.textureNamed("gold_3.png"),
                                      //textureAtlas.textureNamed("gold_4.png"),
                                      textureAtlas.textureNamed("gold_3.png"),
                                      textureAtlas.textureNamed("gold_2.png")]
        let coinAction = SKAction.animate(with: coinFrames, timePerFrame: 0.5)
        coinAnimation = SKAction.repeatForever(coinAction)
        self.run(coinAnimation)
        self.value = 5
        
    }
}
