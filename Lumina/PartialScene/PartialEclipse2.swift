//
//  PartialEclipse2.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation
import SpriteKit

class PartialEclipse2: SKScene{
    private var backgroundImg = SKSpriteNode(imageNamed: "FHS1_background")
    private var nextButton = SKShapeNode()
    private var learnButton = SKShapeNode()
    var moon = SKSpriteNode(imageNamed: "moon_sad")
    let city = SKSpriteNode(imageNamed: "City")
    var text = SKLabelNode(fontNamed: "PatrickHand-Regular")
    var spaceCreatures = SKSpriteNode(imageNamed: "space_creatures")
    
    var starFormation = SKSpriteNode(imageNamed: "star_partial")
    var highFuel = SKSpriteNode(imageNamed: "low_fuel")
    
    var storyIdx: Int = 0
    
    
    override func didMove(to view: SKView) {
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        backgroundImg.zPosition = -1
        addChild(backgroundImg)
        
        starFormation.position = CGPoint(x: self.frame.width *  0.329 + starFormation.frame.width/2, y: self.frame.height * 0.4 + starFormation.frame.height/2)
        starFormation.alpha = 0
        addChild(starFormation)
        
        highFuel.position = CGPoint(x: self.frame.width *  0.668 + highFuel.frame.width/2, y: self.frame.height * 0.727 + highFuel.frame.height/2)
        highFuel.alpha = 0
        addChild(highFuel)
        
        city.alpha = 0
        city.position = CGPoint(x: self.frame.width/2, y: city.frame.height/2)
        moon.setScale(1)
        moon.position = CGPoint(x: self.frame.width * 0.387 + moon.frame.width/2, y: self.frame.height * 0.505 + moon.frame.height/2)
        moon.alpha = 0
        addChild(moon)
        addChild(city)
        
        
        spaceCreatures.position = CGPoint(x: self.frame.width * 0.107 + spaceCreatures.frame.width/2, y: self.frame.height * 0.4 + spaceCreatures.frame.height/2)
        spaceCreatures.alpha = 0
        addChild(spaceCreatures)
        
        
        text.text = "Finally, upon his return from his hunt, Mr. Moon was a bit sad because he couldn't satisfy the food needs of his galaxy animals."
        text.numberOfLines = 5
        text.fontSize = 24
        text.preferredMaxLayoutWidth = 432
        text.color = .white
        text.alpha = 0
        text.position = CGPoint(x: self.frame.width * 0.0368 + text.frame.width/2, y: self.frame.height * 0.7 + text.frame.height/2)
        
        addChild(text)
        
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
        
        learnButton = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 790, height: 86), cornerRadius: 19)
        learnButton.position = CGPoint(x: self.frame.width * 0.173 , y: self.frame.height * 0.0995 )
        learnButton.fillColor = AppColor.blueColor!
        learnButton.strokeColor = .clear
        
        let learnText = SKLabelNode(fontNamed: "PatrickHand-Regular")
        learnText.text = "Learn About Partial Lunar Eclipse"
        learnText.fontColor = .white
        learnText.fontSize = 48
        learnText.position = CGPoint(x: learnButton.frame.width/2, y: learnButton.frame.height/2 - learnText.frame.height/2)
        learnButton.addChild(learnText)
        addChild(learnButton)
        //        nextButton.isUserInteractionEnabled = false
        learnButton.alpha = 0
        
        self.run(SKAction.sequence([
            SKAction.run { [self] in
                text.run(SKAction.fadeIn(withDuration: 1))
            },
            SKAction.wait(forDuration: 1),
            SKAction.run { [self] in
                city.run(SKAction.fadeIn(withDuration: 1))
            },
            SKAction.wait(forDuration: 1),
            SKAction.run { [self] in
                moon.run(SKAction.fadeIn(withDuration: 1))
            },
            SKAction.wait(forDuration: 1),
            SKAction.run {
                self.spaceCreatures.run(SKAction.fadeIn(withDuration: 2))
            },
            SKAction.wait(forDuration: 1),
            SKAction.run {
                self.starFormation.run(SKAction.fadeIn(withDuration: 1))
                var rotateAction = SKAction.rotate(byAngle: CGFloat.pi, duration: 5.0)
                let repeatForeverAction = SKAction.repeatForever(rotateAction)
                
                self.starFormation.run(repeatForeverAction)
                
            },
            SKAction.wait(forDuration: 1),
            SKAction.run {
                self.highFuel.run(SKAction.fadeIn(withDuration: 1))
            },
            SKAction.wait(forDuration: 1),
            SKAction.run {
                self.nextButton.run(SKAction.fadeIn(withDuration: 1))
                //                self.nextButton.isUserInteractionEnabled = true
            }
            
        ]))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if nextButton.contains(touchLocation) && nextButton.alpha != 0{
            AudioManager.shared.playSoundEffect(fileName: "button_clicked")
            if storyIdx == 0 {
                self.run(SKAction.sequence([
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeOut(withDuration: 1))
                        //                self.nextButton.isUserInteractionEnabled = true
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.highFuel.run(SKAction.fadeOut(withDuration: 1))
                        self.text.run(SKAction.fadeOut(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.text.text = "Since the needs of his galaxy creatures went unmet, Mr. Moon had to share his precious \"Moonbeams\" with them. "
                        self.text.run(SKAction.fadeIn(withDuration: 1))
                        self.starFormation.run(SKAction.fadeOut(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeIn(withDuration: 1))
                    }
                    
                ]))
                storyIdx += 1

            }else if storyIdx == 1 {
                self.run(SKAction.sequence([
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeOut(withDuration: 1))
                        //                self.nextButton.isUserInteractionEnabled = true
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.highFuel.run(SKAction.fadeOut(withDuration: 1))
                        self.text.run(SKAction.fadeOut(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.moon.removeFromParent()
                        self.moon = SKSpriteNode(imageNamed: "moon_partial")
                        self.moon.alpha = 0
                        self.moon.position = CGPoint(x: self.frame.width * 0.387 + self.moon.frame.width/2, y: self.frame.height * 0.505 + self.moon.frame.height/2)
                        self.addChild(self.moon)
                        self.moon.run(SKAction.fadeIn(withDuration: 1))
                        self.text.text = "As a result, his body became somewhat hollow, even if only a little. This would later become the origin of the \"Partial Lunar Eclipse\""
                        self.text.run(SKAction.fadeIn(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.learnButton.run(SKAction.fadeIn(withDuration: 1))
                    }
                    
                ]))
                storyIdx += 1
            }
            
        }
        
        if storyIdx >= 3 {
            if learnButton.contains(touchLocation) && learnButton.alpha != 0  {
                AudioManager.shared.playSoundEffect(fileName: "button_clicked")
                self.view?.presentScene(FinalPartial(size: self.size), transition: .crossFade(withDuration: 1))
            }
        }
    }
}
