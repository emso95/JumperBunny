//
//  HUD.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 26.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class HUD:SKNode{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "HUD.atlas")
    let coinCountText = SKLabelNode(text: "000000")
    let distanceCountText = SKLabelNode(text: "000000")
    let restartButton = SKSpriteNode()
    let menuButton = SKSpriteNode()
    
    func createHudNodes(screenSize: CGSize){
        let coinIcon = SKSpriteNode(texture: textureAtlas.textureNamed("coin_bronze.png"))
        let coinYPos = screenSize.height - 23
        coinIcon.size = CGSize(width: 26, height: 26)
        coinIcon.position = CGPoint(x: 23, y: coinYPos)
        coinCountText.fontName = "AvenirNext-HeavyItalic"
        coinCountText.position = CGPoint(x: 41, y: coinYPos)
        coinCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.addChild(coinCountText)
        self.addChild(coinIcon)
        restartButton.alpha = 0
        menuButton.alpha = 0
        self.addChild(restartButton)
        self.addChild(menuButton)
        let distIcon = SKSpriteNode(texture: textureAtlas.textureNamed("lifes.png"))
        let distYPos = screenSize.height - 66
        distIcon.size = CGSize(width: 26, height: 26)
        distIcon.position = CGPoint(x: 23, y: distYPos)
        distanceCountText.fontName = "AvenirNext-HeavyItalic"
        distanceCountText.position = CGPoint(x: 41, y: distYPos)
        distanceCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        distanceCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.addChild(distanceCountText)
        self.addChild(distIcon)
        
        restartButton.texture =
            textureAtlas.textureNamed("button-restart.png")
        menuButton.texture =
            textureAtlas.textureNamed("button-menu.png")
        
        restartButton.name = "restartGame"
        menuButton.name = "returnToMenu"
        
        let centerOfHud = CGPoint(x: screenSize.width / 2,
                                  y: screenSize.height / 2)
        restartButton.position = centerOfHud
        menuButton.position =
            CGPoint(x: centerOfHud.x - 140, y: centerOfHud.y)
        
        restartButton.size = CGSize(width: 70, height: 70)
        menuButton.size = CGSize(width: 50, height: 50)
    }
    func setCoinCountDisplay(newCoinCount:Int) {
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 6
        if let coinStr =
            formatter.string(for: newCoinCount){
            coinCountText.text = coinStr
        }
    }
    func setDistanceCountDisplay(newDistCount:Int) {
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 6
        if let coinStr =
            formatter.string(for: newDistCount){
            distanceCountText.text = coinStr
        }
    }
    func showButtons() {
        
        restartButton.alpha = 1
        menuButton.alpha = 1
        
        
    }
}
