//
//  FullEclipse2.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation
import SpriteKit

class FullEclipse2: SKScene{
    private var backgroundImg = SKSpriteNode(imageNamed: "FHS1_background")
    private var nextButton = SKShapeNode()
    private var learnButton = SKShapeNode()
    var moon = SKSpriteNode(imageNamed: "moon_sad")
    let city = SKSpriteNode(imageNamed: "City")
    var text = SKLabelNode(fontNamed: "PatrickHand-Regular")
    var spaceCreaturesLeft = SKSpriteNode(imageNamed: "animal_left")
    var spaceCreaturesRight = SKSpriteNode(imageNamed: "animal_right")
    var bleedEffect = SKSpriteNode(imageNamed: "bleed_effect")
    var sparklingEffect = SKSpriteNode(imageNamed: "sparkling_effect")
    
//    var starFormation = SKSpriteNode(imageNamed: "star_partial")
    var highFuel = SKSpriteNode(imageNamed: "no_fuel")
    
    var storyIdx: Int = 0
    
    
    override func didMove(to view: SKView) {
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        backgroundImg.zPosition = -1
        addChild(backgroundImg)
        bleedEffect.scale(to: self.size)
        bleedEffect.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        bleedEffect.zPosition = -1
        bleedEffect.alpha = 0
        addChild(bleedEffect)
        
        sparklingEffect.position = CGPoint(x: self.frame.width * 0.312 + sparklingEffect.frame.width/2, y: self.frame.height * 0.412 + sparklingEffect.frame.height/2)
        sparklingEffect.alpha = 0
        addChild(sparklingEffect)
        
//        
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
        
        
        spaceCreaturesLeft.position = CGPoint(x: self.frame.width * 0.0686 + spaceCreaturesLeft.frame.width/2, y: self.frame.height * 0.402 + spaceCreaturesLeft.frame.height/2)
        spaceCreaturesLeft.alpha = 0
        addChild(spaceCreaturesLeft)
        
        spaceCreaturesRight.position = CGPoint(x: self.frame.width * 0.67 + spaceCreaturesRight.frame.width/2, y: self.frame.height * 0.402 + spaceCreaturesRight.frame.height/2)
        spaceCreaturesRight.alpha = 0
        addChild(spaceCreaturesRight)
        
        
        text.text = "Eventually, Mr. Moon returned home empty-handed, his face filled with sadness."
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
                self.spaceCreaturesLeft.run(SKAction.fadeIn(withDuration: 2))
                self.spaceCreaturesRight.run(SKAction.fadeIn(withDuration: 2))
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
        if nextButton.contains(touchLocation) && nextButton.alpha == 1{
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
                    SKAction.run { [self] in
                        self.text.text = "The absence of any \"Moonbeams\" in his catch made his beloved creatures furious. They scratched and bit Mr. Moon... "
                        self.text.run(SKAction.fadeIn(withDuration: 1))
                        self.spaceCreaturesLeft.run(SKAction.move(to: CGPoint(x: self.frame.width * 0.25 + spaceCreaturesLeft.frame.width/2, y: self.frame.height * 0.38 + spaceCreaturesLeft.frame.height/2), duration: 0.3))
                        self.spaceCreaturesLeft.run(SKAction.rotate(byAngle: 9 * CGFloat.pi / 180.0, duration: 0.3))
                        
                        
                        self.spaceCreaturesRight.run(SKAction.move(to: CGPoint(x: self.frame.width * 0.5 + spaceCreaturesRight.frame.width/2, y: self.frame.height * 0.344 + spaceCreaturesRight.frame.height/2), duration: 0.3))
                        self.spaceCreaturesRight.run(SKAction.rotate(byAngle: -18 * CGFloat.pi / 180.0, duration: 0.3))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeIn(withDuration: 1))
                    }
                    
                ]))
                storyIdx += 1

            } else if storyIdx == 1 {
                self.run(SKAction.sequence([
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeOut(withDuration: 1))
                        self.bleedEffect.run(SKAction.fadeIn(withDuration: 1))
                        //                self.nextButton.isUserInteractionEnabled = true
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
//                        self.highFuel.run(SKAction.fadeOut(withDuration: 1))
                        self.text.run(SKAction.fadeOut(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
//                        self.moon.removeFromParent()
                        self.moon.run(SKAction.fadeAlpha(to: 0.5, duration: 0.5))
                        self.moon.texture = SKTexture(imageNamed: "moon_bleed")
                        self.moon.run(SKAction.fadeIn(withDuration: 0.5))
                        self.text.text = "Until he bled and turned red. This would later become the origin of the \"Total Lunar Eclipse\""
                        self.text.run(SKAction.fadeIn(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeIn(withDuration: 1))
//                        self.learnButton.run(SKAction.fadeIn(withDuration: 1))
                    }
                    
                ]))
                storyIdx += 1
            } else if storyIdx == 2 {
                self.run(SKAction.sequence([
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeOut(withDuration: 1))
                        //                self.nextButton.isUserInteractionEnabled = true
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
//                        self.highFuel.run(SKAction.fadeOut(withDuration: 1))
                        self.text.run(SKAction.fadeOut(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
//                        self.moon.removeFromParent()
                        self.text.text = "Seeing Mr. Moon injured, Mrs. Asteroids couldn't bear it any longer..."
                        self.text.run(SKAction.fadeIn(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeIn(withDuration: 1))
//                        self.learnButton.run(SKAction.fadeIn(withDuration: 1))
                    }
                    
                ]))
                storyIdx += 1
            } else if storyIdx == 3 {
                self.run(SKAction.sequence([
                    SKAction.run {
                        self.nextButton.run(SKAction.fadeOut(withDuration: 1))
                        //                self.nextButton.isUserInteractionEnabled = true
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
//                        self.highFuel.run(SKAction.fadeOut(withDuration: 1))
                        self.text.run(SKAction.fadeOut(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
//                        self.moon.removeFromParent()
                        self.text.text = "They decided to help heal Mr. Moon by gently circling around him. Eventually, Mr. Moon made a full recovery, just as he used to be."
                        self.text.run(SKAction.fadeIn(withDuration: 1))
                        self.sparklingEffect.run(SKAction.fadeIn(withDuration: 1))
                        self.spaceCreaturesLeft.run(SKAction.move(to: CGPoint(x: -self.frame.width, y: self.spaceCreaturesLeft.position.y), duration: 2))
                        self.spaceCreaturesRight.run(SKAction.move(to: CGPoint(x: self.frame.width * 2, y: self.spaceCreaturesRight.position.y), duration: 2))
                        self.moon.run(SKAction.fadeAlpha(to: 0.5, duration: 0.5))
                        self.moon.texture = SKTexture(imageNamed: "moon_happy")
                        self.moon.run(SKAction.fadeIn(withDuration: 0.5))
                        self.bleedEffect.run(SKAction.fadeOut(withDuration: 0.5))
                    },
                    
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
//                        self.nextButton.run(SKAction.fadeIn(withDuration: 1))
                        self.learnButton.run(SKAction.fadeIn(withDuration: 1))
                    }
                    
                ]))
                
                storyIdx += 1
            }

            
        }
        
        if learnButton.contains(touchLocation)  {
            AudioManager.shared.playSoundEffect(fileName: "button_clicked")
            if storyIdx >= 4 && learnButton.alpha != 0{
                self.view?.presentScene(FinalFull(size: self.size), transition: .crossFade(withDuration: 1))
            }
        }
    }
}
