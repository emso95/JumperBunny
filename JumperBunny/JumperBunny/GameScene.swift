//
//  GameScene.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 23.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "player.atlas")
    let leftButton = SKSpriteNode()
    let rightButton = SKSpriteNode()
    let jumpButton = SKSpriteNode()
    let world = SKNode()
    let bunny = Bunny()
    let ground1 = Ground()
    let ground2 = Ground()
    let ground3 = Ground()
    let ground4 = Ground()
    let initialPlayerPosition = CGPoint(x: 100, y: 250)
    var playerProgress = CGFloat()
    var coinsCollected = 0
    let encounterManager = EncounterManager()
    let hud = HUD()
    var backgrounds:[Background] = []
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1)
        self.addChild(world)
        bunny.spawn(parentNode: world, position: initialPlayerPosition)
        ground1.spawn(parentNode: world, position: CGPoint(x: 50, y: 100))
        ground2.spawn(parentNode: world, position: CGPoint(x: 200, y: 100))
        ground3.spawn(parentNode: world, position: CGPoint(x: 350, y: 100))
        ground4.spawn(parentNode: world, position: CGPoint(x: 500, y: 100))
        
        
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
        jumpButton.position = CGPoint(x: 70, y:70)
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
        
        encounterManager.addEncountersToWorld(world: self.world)
        encounterManager.encounters[0].position = CGPoint(x: 500, y: 0)
        self.physicsWorld.contactDelegate = self
        
        hud.createHudNodes(screenSize: self.size)
        self.addChild(hud)
        hud.zPosition = 50
        for i in 0...3{
            backgrounds.append(Background())
        }
        backgrounds[0].spawn(parentNode: world, imageName: "bg_layer4", zPosition: -5, movementMultiplier: 0.75)
        backgrounds[1].spawn(parentNode: world, imageName: "bg_layer3", zPosition: -10, movementMultiplier: 0.5)
        backgrounds[2].spawn(parentNode: world, imageName: "bg_layer2", zPosition: -15, movementMultiplier: 0.2)
        backgrounds[3].spawn(parentNode: world, imageName: "bg_layer1", zPosition: -20, movementMultiplier: 0.1)
    }
    
    override func didSimulatePhysics() {
        let worldXPos = -(bunny.position.x * world.xScale - (self.size.width / 2))
        world.position = CGPoint(x: worldXPos, y: world.position.y)
        playerProgress = bunny.position.x - initialPlayerPosition.x
        bunny.checkYPosition()
        hud.setDistanceCountDisplay(newDistCount: Int(floor(self.playerProgress)))
        for background in self.backgrounds {
            background.updatePosition(playerProgress: playerProgress)
        }
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
            if nodeTouched.name == "restartGame" {
                self.view?.presentScene(
                    GameScene(size: self.size),
                    transition: .crossFade(withDuration: 0.6))
            }
            else if nodeTouched.name == "returnToMenu" {
                self.view?.presentScene(
                    MenuScene(size: self.size),
                    transition: .crossFade(withDuration: 0.6))
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !bunny.isJumping{
            leftButton.alpha = 0.2
            rightButton.alpha = 0.2
            bunny.stopWalking()        }
        else{
            jumpButton.alpha = 0.2
            bunny.isJumping = false
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let otherBody: SKPhysicsBody
        let bunnyMask = PhysicsCategory.bunny.rawValue
        
        if(contact.bodyA.categoryBitMask & bunnyMask) > 0{
            otherBody = contact.bodyB
        }
        else{
            otherBody = contact.bodyA
        }
        
        switch otherBody.categoryBitMask {
        case PhysicsCategory.ground.rawValue:
            print("On ground")
            bunny.resetJumpCount()
        case PhysicsCategory.enemy.rawValue:
            print("Hit enemy")
            bunny.die()
        case PhysicsCategory.coin.rawValue:
            if let coin = otherBody.node as? Coin {
                
                coin.collect()
                self.coinsCollected += coin.value
                print(self.coinsCollected)
                hud.setCoinCountDisplay(newCoinCount: self.coinsCollected)
                
            }
        default:
            print("Weird Contact")
        }
        
    }
    
    func gameOver() {
        hud.showButtons()
    }
    
}
enum PhysicsCategory:UInt32{
    case bunny = 1
    case coin = 2
    case ground = 4
    case enemy = 8
}
