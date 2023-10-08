//
//  FullEclipse1.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation
import SpriteKit
class FullEclipse1: SKScene {
    
    private var backgroundImg = SKSpriteNode(imageNamed: "bg_full_eclipse_1")
    private var nextButton = SKShapeNode()
    
    override func didMove(to view: SKView) {
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        backgroundImg.zPosition = -1
        addChild(backgroundImg)
        
        nextButton = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 269, height: 86), cornerRadius: 19)
        nextButton.position = CGPoint(x: self.frame.width * 0.84 - nextButton.frame.width/2 , y: self.frame.height * 0.0995 )
        nextButton.fillColor = AppColor.blueColor!
        nextButton.strokeColor = .clear
        
        let nextText = SKLabelNode(fontNamed: "PatrickHand-Regular")
        nextText.text = "Next"
        nextText.fontColor = .white
        nextText.fontSize = 48
        nextText.position = CGPoint(x: nextButton.frame.width/2, y: nextButton.frame.height/2 - nextText.frame.height/2)
        nextButton.addChild(nextText)
        addChild(nextButton)
        //        nextButton.isUserInteractionEnabled = false
        nextButton.alpha = 0
        
        nextButton.run(SKAction.fadeIn(withDuration: 1))
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if nextButton.contains(touchLocation) {
            self.view?.presentScene(FullEclipse2(size: self.size), transition: .crossFade(withDuration: 1))
        }
    }
}
