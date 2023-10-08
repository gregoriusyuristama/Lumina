//
//  HomePage.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation
import SpriteKit
class HomePage: SKScene {
    
    private var backgroundImg = SKSpriteNode(imageNamed: "homepage_background")
//    private var titleText = SKLabelNode()
    private var startButton = SKShapeNode()
    
    
    
    override func didMove(to view: SKView) {
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        addChild(backgroundImg)
        
        startButton = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 269, height: 86), cornerRadius: 16)
        startButton.position = CGPoint(x: self.frame.width/2 - startButton.frame.width/2, y: self.frame.height * 0.1211)
        startButton.fillColor = AppColor.blueColor!
        startButton.strokeColor = .clear
        
        let startText = SKLabelNode(fontNamed: "PatrickHand-Regular")
        startText.text = "Start"
        startText.fontSize = 48
        startText.fontColor = .white
        startText.position = CGPoint(x: startButton.frame.width/2, y: startButton.frame.height/2 - startText.frame.height/2)
        startButton.addChild(startText)
        addChild(startButton)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if startButton.contains(touchLocation){
            print("Check")
            self.view?.presentScene(FirstHalfStory1(size: self.size),transition: SKTransition.crossFade(withDuration: 0.5))
        }
    }
    
}
