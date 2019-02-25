//
//  EncounterManager.swift
//  JumperBunny
//
//  Created by Emir Can Marangoz on 24.02.2019.
//  Copyright © 2019 Emir Can Marangoz. All rights reserved.
//

import Foundation
import SpriteKit

class EncounterManager{
    
    let encounterNames:[String] = ["EncounterCake"]
    var encounters:[SKNode] = []
    
    init(){
        
        for encounterFileName in encounterNames{
            
            let encounter = SKNode()
            if let encounterScene = SKScene(fileNamed: encounterFileName){
                for placeholder in encounterScene.children{
                    if let node = placeholder as? SKNode{
                        switch node.name! {
                        case "GroundCake":
                            let ground = Ground()
                            ground.spawn(parentNode: encounter, position: node.position)
                        case "GroundCakeSmall":
                            let ground = Ground()
                            ground.spawn(parentNode: encounter, position: node.position)
                            ground.turnToSmall()
                        case "GroundCakeBroken":
                            let ground = Ground()
                            ground.spawn(parentNode: encounter, position: node.position)
                            ground.turnToBroken()
                        case "GroundCakeSmallBroken":
                            let ground = Ground()
                            ground.spawn(parentNode: encounter, position: node.position)
                            ground.turnToSmallBroken()
                        case "Cloud":
                            let cloud = Cloud()
                            cloud.spawn(parentNode: encounter, position: node.position)
                        case "FlyMan":
                            let flyMan = FlyMan()
                            flyMan.spawn(parentNode: encounter, position: node.position)
                        default:
                            print("Error")
                        }
                    }
                }
            }
            encounters.append(encounter)
        }
    }
    func addEncountersToWorld(world:SKNode){
        for index in 0 ... encounters.count - 1{
            encounters[index].position = CGPoint(x: -2000, y: index * 1000)
            world.addChild(encounters[index])
        }
    }
}
