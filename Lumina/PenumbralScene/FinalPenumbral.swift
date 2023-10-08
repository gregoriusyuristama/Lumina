//
//  FinalPenumbral.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation

import SpriteKit
class FinalPenumbral: SKScene {
    
    private var backgroundImg = SKSpriteNode(imageNamed: "bg_penumbral_eclipse_final")
    private var finalButton = SKSpriteNode(imageNamed: "final_button")
    private var referenceButton1 = SKSpriteNode(imageNamed: "reference_button")
    private var referenceButton2 = SKSpriteNode(imageNamed: "reference_button")
    private var referenceButton3 = SKSpriteNode(imageNamed: "reference_button")
    
    
    override func didMove(to view: SKView) {
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        backgroundImg.zPosition = -1
        addChild(backgroundImg)
        
        finalButton.position = CGPoint(x: self.frame.width * 0.221 + finalButton.frame.width/2, y: self.frame.height * 0.0995 )
        addChild(finalButton)
        finalButton.alpha = 0
        
        referenceButton1.position = CGPoint(x: self.frame.width * 0.649 + referenceButton1.frame.width/2, y: self.frame.height * 0.586 + referenceButton1.frame.height/2)
        addChild(referenceButton1)
        referenceButton1.alpha = 0
        
        referenceButton2.position = CGPoint(x: self.frame.width * 0.649 + referenceButton2.frame.width/2, y: self.frame.height * 0.407 + referenceButton2.frame.height/2)
        addChild(referenceButton2)
        referenceButton2.alpha = 0
        
        referenceButton3.position = CGPoint(x: self.frame.width * 0.649 + referenceButton3.frame.width/2, y: self.frame.height * 0.228 + referenceButton3.frame.height/2)
        addChild(referenceButton3)
        referenceButton3.alpha = 0
        
        finalButton.run(SKAction.fadeIn(withDuration: 1))
        referenceButton3.run(SKAction.fadeIn(withDuration: 1))
        referenceButton2.run(SKAction.fadeIn(withDuration: 1))
        referenceButton1.run(SKAction.fadeIn(withDuration: 1))
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if finalButton.contains(touchLocation) {
            self.view?.presentScene(BranchingPage(size: self.size), transition: .crossFade(withDuration: 1))
        }
        else if referenceButton3.contains(touchLocation) {
            if let url = URL(string: "https://en.wikipedia.org/wiki/Total_penumbral_lunar_eclipse") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        } else if referenceButton2.contains(touchLocation) {
            if let url = URL(string: "https://earthsky.org/astronomy-essentials/what-is-a-penumbral-eclipse-of-the-moon/#:~:text=Finally%2C%20there's%20a%20penumbral%20lunar,partial%20eclipse%20of%20the%20moon.") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        } else if referenceButton1.contains(touchLocation) {
            if let url = URL(string: "https://www.britannica.com/science/penumbra-eclipse") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
