//
//  FirstHalfStory2a.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation
import SpriteKit
class FirstHalfStory2: SKScene {
    private var backgroundImg = SKSpriteNode(imageNamed: "FHS2a_background")
    private var nextButton = SKShapeNode()
    
    override func didMove(to view: SKView) {
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        addChild(backgroundImg)
        
        nextButton = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 280, height: 80), cornerRadius: 16)
        nextButton.position = CGPoint(x: self.frame.width * 0.74 , y: self.frame.height * 0.078 - nextButton.frame.height/2)
        nextButton.fillColor = .black
        
        let nextText = SKLabelNode(text: "Next")
        nextText.fontColor = .white
        nextText.position = CGPoint(x: nextButton.frame.width/2, y: nextButton.frame.height/2 - nextText.frame.height/2)
        nextButton.addChild(nextText)
        addChild(nextButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if nextButton.contains(touchLocation){
            print("Check")
            self.view?.presentScene(FirstHalfStory1(size: self.size),transition: SKTransition.crossFade(withDuration: 0.5))
        }
    }
}
