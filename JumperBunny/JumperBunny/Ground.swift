//
//  Ground.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 23.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode, GameSprite {
    
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"envir.atlas")
    
    func spawn(parentNode:SKNode, position:CGPoint, size:CGSize = CGSize(width: 190, height: 50)) {
        parentNode.addChild(self)
        self.size = size
        self.position = position
        self.texture = textureAtlas.textureNamed("ground_cake.png")
        let bodyTexture = textureAtlas.textureNamed("ground_cake.png")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
    }
    func turnToBroken(){
        self.texture = textureAtlas.textureNamed("ground_cake_broken.png")
    }
    func turnToSmall(){
        let bodyTexture = textureAtlas.textureNamed("ground_cake_small.png")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: CGSize(width: 90, height: 50))
        self.size = CGSize(width: 90, height: 50)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
    }
    func turnToSmallBroken(){
        let bodyTexture = textureAtlas.textureNamed("ground_grass_small_broken.png")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: CGSize(width: 90, height: 50))
        self.size = CGSize(width: 90, height: 50)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
    }
    func turnToGrass(){
        self.texture = textureAtlas.textureNamed("ground_grass.png")
    }
    func turnToGrassSmall(){
        let bodyTexture = textureAtlas.textureNamed("ground_grass_small.png")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToGrassBroken(){
        self.texture = textureAtlas.textureNamed("ground_grass_broken.png")
    }
    func turnToGrassSmallBroken(){
        self.texture = textureAtlas.textureNamed("ground_grass_small_broken.png")
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToSand(){
        self.texture = textureAtlas.textureNamed("ground_sand.png")
    }
    func turnToSandSmall(){
        self.texture = textureAtlas.textureNamed("ground_sand_small.png")
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToSandBroken(){
        self.texture = textureAtlas.textureNamed("ground_sand_broken.png")
    }
    func turnToSandSmallBroken(){
        self.texture = textureAtlas.textureNamed("ground_sand_small_broken.png")
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToSnow(){
        self.texture = textureAtlas.textureNamed("ground_snow.png")
    }
    func turnToSnowSmall(){
        self.texture = textureAtlas.textureNamed("ground_snow_small.png")
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToSnowBroken(){
        self.texture = textureAtlas.textureNamed("ground_snow_broken.png")
    }
    func turnToSnowSmallBroken(){
        self.texture = textureAtlas.textureNamed("ground_snow_small_broken.png")
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToStone(){
        self.texture = textureAtlas.textureNamed("ground_stone.png")
    }
    func turnToStonrSmall(){
        self.texture = textureAtlas.textureNamed("ground_stone_small.png")
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToStoneBroken(){
        self.texture = textureAtlas.textureNamed("ground_stone_broken.png")
    }
    func turnToStoneSmallBroken(){
        self.texture = textureAtlas.textureNamed("ground_stone_small_broken.png")
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToWood(){
        self.texture = textureAtlas.textureNamed("ground_wood.png")
    }
    func turnToWoodSmall(){
        self.texture = textureAtlas.textureNamed("ground_wood_small.png")
        self.size = CGSize(width: 90, height: 50)
    }
    func turnToWoodBroken(){
        self.texture = textureAtlas.textureNamed("ground_wood_broken.png")
    }
    func turnToWoodSmallBroken(){
        self.texture = textureAtlas.textureNamed("ground_wood_small_broken.png")
        self.size = CGSize(width: 90, height: 50)
    }
    
}
