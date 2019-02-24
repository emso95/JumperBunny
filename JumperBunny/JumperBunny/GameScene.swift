//
//  GameScene.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 23.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "player.atlas")
    let leftButton = SKSpriteNode()
    let rightButton = SKSpriteNode()
    let jumpButton = SKSpriteNode()
    let world = SKNode()
    let bunny = Bunny()
    let ground = Ground()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1)
        self.addChild(world)
        bunny.spawn(parentNode: world, position: CGPoint(x: 250, y: 250))
        
        rightButton.texture = textureAtlas.textureNamed("arrow.png")
        rightButton.size = CGSize(width: 100, height: 100)
        rightButton.name = "RightBtn"
        rightButton.position = CGPoint(x: self.size.width-50, y: 50)
        rightButton.alpha = 0.2
        rightButton.zPosition = 10
        
        leftButton.texture = textureAtlas.textureNamed("arrow.png")
        leftButton.size = CGSize(width: 100, height: 100)
        leftButton.name = "LeftBtn"
        leftButton.position = CGPoint(x: self.size.width-120, y: 50)
        leftButton.alpha = 0.2
        leftButton.xScale = -1
        leftButton.zPosition = 10
        
        jumpButton.texture = textureAtlas.textureNamed("jump.png")
        jumpButton.size = CGSize(width: 100, height: 100)
        jumpButton.name = "JumpBtn"
        jumpButton.position = CGPoint(x: 20, y:50)
        jumpButton.alpha = 0.2
        jumpButton.zPosition = 10
        let jumpText = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
        jumpText.text = "JUMP"
        jumpText.verticalAlignmentMode = .center
        jumpText.position = CGPoint(x: 0, y: 2)
        jumpText.fontSize = 27
        jumpText.name = "JumpBtn"
        jumpButton.addChild(jumpText)
        
        self.addChild(jumpButton)
        self.addChild(rightButton)
        self.addChild(leftButton)
        
        let groundPosition = CGPoint(x: -self.size.width, y: 30)
        
        let groundSize = CGSize(width: self.size.width * 3, height:0)
        
        ground.spawn(parentNode: world, position: groundPosition, size:
            groundSize)
    }
    
    override func didSimulatePhysics() {
        let worldXPos = -(bunny.position.x * world.xScale -
            (self.size.width / 2))
        let worldYPos = -(bunny.position.y * world.yScale -
            (self.size.height / 2))
        // Move the world so that the bee is centered in the scene
        world.position = CGPoint(x: worldXPos, y: worldYPos)
    }
    
    override func update(_ currentTime: TimeInterval) {
        bunny.update()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "LeftBtn"{
                print("Clicked Left Button")
                nodeTouched.alpha = 1
                bunny.moveToLeft()
            }
            else if nodeTouched.name == "RightBtn"{
                print("Clicked right Button")
                nodeTouched.alpha = 1
                bunny.moveToRight()
            }
            else if nodeTouched.name == "JumpBtn"{
                print("Jumped!")
                nodeTouched.alpha = 1
                bunny.jump()
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftButton.alpha = 0.2
        rightButton.alpha = 0.2
        jumpButton.alpha = 0.2
        bunny.stopWalking()
    }
    
    
}
