//
//  FirstHalfStory2a.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation
import SpriteKit
class FirstHalfStory2: SKScene {
    private var backgroundImg = SKSpriteNode(imageNamed: "FHS3_background")
    private var nextButton = SKShapeNode()
    private var storyIdx: Int = 0
    var moon = SKSpriteNode(imageNamed: "Moon")
    var stars = SKSpriteNode(imageNamed: "Stars")
    
    var narrativeText = SKLabelNode(fontNamed: "PatrickHand-Regular")
    
    override func didMove(to view: SKView) {
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
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
        
        moon.position = CGPoint(x: self.frame.width * 0.38 + moon.frame.width/2, y: self.frame.height * 0.546 + moon.frame.height/2)
        addChild(moon)
        moon.alpha = 0
        
        stars.position = CGPoint(x: self.frame.width * 0.155 + stars.frame.width/2, y: self.frame.height * 0.57 + stars.frame.height/2)
        addChild(stars)
        stars.alpha = 0
        
        let attrString = NSMutableAttributedString(string: self.texts[0])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: self.texts[0].count)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        
        if let customFont = UIFont(name: "PatrickHand-Regular", size: 24) {
            attrString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : customFont], range: range)
        }
        narrativeText.attributedText = attrString
        
//        narrativeText.text =
        narrativeText.preferredMaxLayoutWidth = 747
        narrativeText.numberOfLines = 5
        narrativeText.lineBreakMode = .byWordWrapping
        narrativeText.alpha = 0
        narrativeText.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.2 + narrativeText.frame.height/2)
        addChild(narrativeText)
        self.run(SKAction.sequence([
            SKAction.run {
                self.moon.run(SKAction.fadeIn(withDuration: 1))
            }, SKAction.wait(forDuration: 1),
            SKAction.run {
                self.stars.run(SKAction.fadeIn(withDuration: 1))
            }, SKAction.wait(forDuration: 1),
            SKAction.run {
                self.nextButton.run(SKAction.fadeIn(withDuration: 1))
            }
        ]))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if nextButton.contains(touchLocation) && nextButton.alpha == 1{
            AudioManager.shared.playSoundEffect(fileName: "button_clicked")
            
            if storyIdx == 0 {
                self.run(SKAction.sequence([
                   
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeOut(withDuration: 0.3))
                        self.narrativeText.run(SKAction.fadeIn(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeIn(withDuration: 1))
                    }
                ]))
            }
            else if storyIdx == 1 {
                
                let attrString = NSMutableAttributedString(string: self.texts[1])
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                let range = NSRange(location: 0, length: self.texts[1].count)
                attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
                
                if let customFont = UIFont(name: "PatrickHand-Regular", size: 24) {
                    attrString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : customFont], range: range)
                }
                self.run(SKAction.sequence([
                    SKAction.run { [self] in
                        
                        narrativeText.run(SKAction.fadeOut(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run { [self] in
                        narrativeText.attributedText = attrString
                        narrativeText.run(SKAction.fadeIn(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeIn(withDuration: 1))
                    }
                ]))
            } else {
                self.view?.presentScene(BranchingPage(size: self.size), transition: .crossFade(withDuration: 2))
            }
            storyIdx += 1
//            self.view?.presentScene(FirstHalfStory1(size: self.size),transition: SKTransition.crossFade(withDuration: 0.5))
        }
    }
    
    var texts: [String] = ["You see, Mr. Moon had an extraordinary job.\nHe would go on thrilling journeys into outer space\nto find something called \"Moonbeams\"\n\nWhy? Well, it was all to take care of his special space pets.", "But today was no regular day. What Mr. Moon found on his adventure could actually change the way the moon looked in the sky all over the world. Sounds intriguing, doesn't it?"]
}
