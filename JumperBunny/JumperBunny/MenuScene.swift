//
//  MenuScene.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 26.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene{
    
    let textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "HUD.atlas")
    let startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let backgroundImage = SKSpriteNode(imageNamed: "Sample")
        backgroundImage.size = CGSize(width: 700, height: 375)
        self.addChild(backgroundImage)
        
        let logoText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoText.text = "Jumper Bunny"
        logoText.position = CGPoint(x: 75, y: 100)
        logoText.fontSize = 20
        self.addChild(logoText)
        
        startButton.texture = textureAtlas.textureNamed("jump.png")
        startButton.size = CGSize(width: 295, height: 76)
        
        startButton.name = "StartBtn"
        startButton.position = CGPoint(x: 0, y: -20)
        self.addChild(startButton)
        
        let startText = SKLabelNode(fontNamed:
            "AvenirNext-HeavyItalic")
        startText.text = "START GAME"
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 40
       
        startText.name = "StartBtn"
        startButton.addChild(startText)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "StartBtn" {
                // Player touched the start text or button node
                // Switch to an instance of the GameScene:
                self.view?.presentScene(GameScene(size: self.size))
            }
        }
    }
}
