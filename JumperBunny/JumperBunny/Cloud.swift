//
//  Cloud.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 24.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class Cloud: SKSpriteNode,GameSprite{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 50, height: 25)) {
        parentNode.addChild(self)
        self.position = position
        self.size = size
        self.texture = textureAtlas.textureNamed("cloud.png")
        self.physicsBody = SKPhysicsBody(texture: textureAtlas.textureNamed("cloud.png"), size: self.size)
        self.physicsBody?.affectedByGravity = false
    }
   
}
