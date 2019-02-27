//
//  Background.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 26.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit
class Background: SKSpriteNode {
    
    var movementMultiplier = CGFloat(0)
    var jumpAdjustment = CGFloat(0)
    
    let backgroundSize = CGSize(width: 500, height: 500)
    
    func spawn(parentNode:SKNode, imageName:String,
               zPosition:CGFloat, movementMultiplier:CGFloat) {
        
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint(x: 0, y: 30)
        self.zPosition = zPosition
        self.movementMultiplier = movementMultiplier
        parentNode.addChild(self)
        
        for i in -1...1 {
            let newBGNode = SKSpriteNode(imageNamed: imageName)
            newBGNode.size = backgroundSize
            newBGNode.anchorPoint = CGPoint.zero
            newBGNode.position = CGPoint(
                x: i * Int(backgroundSize.width), y: 0)
            self.addChild(newBGNode)
        }
    }
    
    
    func updatePosition(playerProgress:CGFloat) {
        let adjustedPosition = jumpAdjustment + playerProgress *
            (1 - movementMultiplier)
        
        if playerProgress - adjustedPosition >
            backgroundSize.width {
            jumpAdjustment += backgroundSize.width
        }
        self.position.x = adjustedPosition
    }
}
