//
//  FirstHalfStory1.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation
import SpriteKit

class FirstHalfStory1: SKScene {
    private var backgroundImg = SKSpriteNode(imageNamed: "FHS1_background")
    private var nextButton = SKShapeNode()
    
    var moon = SKSpriteNode(imageNamed: "Moon")
    let city = SKSpriteNode(imageNamed: "City")
    var text = SKLabelNode(fontNamed: "PatrickHand-Regular")
    var titleText = SKLabelNode(fontNamed: "PatrickHand-Regular")
    
    var storyIdx: Int = 0
    
    var subtitleText = SKLabelNode(fontNamed: "PatrickHand-Regular")
    var asteroids = SKSpriteNode(imageNamed: "asteroids")
    var spaceCreatures = SKSpriteNode(imageNamed: "space_creatures")
    
    override func didMove(to view: SKView) {
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        addChild(backgroundImg)
        
        
        city.alpha = 0
        city.position = CGPoint(x: self.frame.width/2, y: city.frame.height/2)
        moon.setScale(1)
        moon.position = CGPoint(x: self.frame.width * 0.653 + moon.frame.width/2, y: self.frame.height * 0.575 + moon.frame.height/2)
        moon.alpha = 0
        
        text.text = "Once upon a time, in a galaxy high above the American skies, there was a special family known as the \"Cloud Family\" Yes, according to the folks in America, they were the family that lived in a galaxy far, far away."
        text.numberOfLines = 6
        text.fontSize = 24
        text.preferredMaxLayoutWidth = 435
        text.color = .white
        text.alpha = 0
        text.position = CGPoint(x: self.frame.width * 0.0585 + text.frame.width/2, y: self.frame.height * 0.7)
        
        addChild(city)
        addChild(moon)
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
        
        asteroids.position = CGPoint(x: self.frame.width * 0.3 + asteroids.frame.width/2, y: self.frame.height * 0.69 + asteroids.frame.height/2)
        asteroids.alpha = 0
        addChild(asteroids)
        
        spaceCreatures.position = CGPoint(x: self.frame.width * 0.133 + spaceCreatures.frame.width/2, y: self.frame.height * 0.35 + spaceCreatures.frame.height/2)
        spaceCreatures.alpha = 0
        addChild(spaceCreatures)
        
        titleText.text = "Mr. Moon"
        titleText.fontSize = 64
        titleText.alpha = 0
        titleText.numberOfLines = 2
        addChild(titleText)
        
        subtitleText.text = "This unique family consisted of a person named \"Mr. Moon\"..."
        subtitleText.fontSize = 24
        subtitleText.fontColor = .white
        subtitleText.alpha = 0
        subtitleText.preferredMaxLayoutWidth = 638
        subtitleText.numberOfLines = 3
        addChild(subtitleText)
        
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
                self.nextButton.run(SKAction.fadeIn(withDuration: 1))
                //                self.nextButton.isUserInteractionEnabled = true
            },
        ]))
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if nextButton.contains(touchLocation) && nextButton.alpha == 1{
            AudioManager.shared.playSoundEffect(fileName: "button_clicked")
            //            self.view?.presentScene(FirstHalfStory2(size: self.size),transition: SKTransition.crossFade(withDuration: 0.5))
            if storyIdx == 0 {
                self.run(SKAction.sequence([
                    SKAction.run { [self] in
                        text.run(SKAction.fadeOut(withDuration: 2))
                        moon.run(SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.546 + moon.frame.height * 0.5/2), duration: 2))
                        nextButton.run(SKAction.fadeOut(withDuration: 1))
                    },
                    SKAction.wait(forDuration: 2),
                    SKAction.run { [self] in
                        nextButton.run(SKAction.fadeIn(withDuration: 2))
                        
//                        subtitleText.position = CGPoint(x: self.frame.width * 0.24 + subtitleText.frame.width/2, y: self.frame.height * 0.432 + subtitleText.frame.height/2)
//                        subtitleText.run(SKAction.fadeIn(withDuration: 1))
                        subtitleText.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.4)
//                        subtitle.alpha = 0
                        subtitleText.run(SKAction.fadeIn(withDuration: 1))
//                        addChild(subtitle)
                        
                        titleText.position = CGPoint(x: self.frame.width * 0.034 + titleText.frame.width/2, y: self.frame.height * 0.699 + titleText.frame.height/2)
                        titleText.alpha = 0
                        titleText.run(SKAction.fadeIn(withDuration: 1))
                    }
                    
                ]))
            } else if storyIdx == 1 {
                self.run(SKAction.sequence([
                    SKAction.run {[self] in
                        nextButton.run(SKAction.fadeOut(withDuration: 2))
                        subtitleText.run(SKAction.fadeOut(withDuration: 2))
                        titleText.run(SKAction.fadeOut(withDuration: 2))
//                        subtitle.removeFromParent()
//                        title.removeFromParent()
                        
                    },
                    SKAction.wait(forDuration: 2),
                    SKAction.run { [self] in
                        
                        titleText.text = "20\nMrs. Asteroids"
                        
                        titleText.position = CGPoint(x: self.frame.width * 0.034 + titleText.frame.width/2, y: self.frame.height * 0.5 + titleText.frame.height/2)
//                        titleText.position = CGPoint(x: frame.width * 0.034, y: frame.height * 0.62)
                        subtitleText.text = "and a whopping twenty \"Mrs. Asteroids\"..."
                        nextButton.run(SKAction.fadeIn(withDuration: 2))
                        
//                        subtitle.alpha = 0
                        subtitleText.run(SKAction.fadeIn(withDuration: 1))
                        titleText.run(SKAction.fadeIn(withDuration: 1))
//                        addChild(subtitle)
                        
//
//                        title.alpha = 0
//                        title.run(SKAction.fadeIn(withDuration: 1))
//                        addChild(title)
                        
//                        moon.run(SKAction.move(to: CGPoint(x: self.frame.width * 0.5322 + moon.frame.width/2, y: self.frame.height * 0.546 + moon.frame.height/2), duration: 2))
                        
                        asteroids.run(SKAction.fadeIn(withDuration: 2))
                        
                    }
                ]))
            } else if storyIdx == 2 {
                self.run(SKAction.sequence([
                    SKAction.run {[self] in
                        nextButton.run(SKAction.fadeOut(withDuration: 2))
                        subtitleText.run(SKAction.fadeOut(withDuration: 2))
//                        subtitle.run(SKAction.fadeIn(withDuration: 2))
                        titleText.run(SKAction.fadeOut(withDuration: 2))
//                        subtitle.removeFromParent()
//                        title.removeFromParent()
                        
//                        subtitle = SKSpriteNode(imageNamed: "subtitle2c")
//                        title = SKSpriteNode(imageNamed: "title2c")
                    },
                    SKAction.wait(forDuration: 2),
                    SKAction.run { [self] in
                        nextButton.run(SKAction.fadeIn(withDuration: 2))
                        titleText.text = "Space\nCreatures"
                        titleText.position = CGPoint(x: self.frame.width * 0.034 + titleText.frame.width/2, y: self.frame.height * 0.55 + titleText.frame.height/2)
                        subtitleText.text = "...along with some space creatures they had to look after. These space creatures were quite demanding, making the Cloud Family's life both interesting and challenging"
                        titleText.run(SKAction.fadeIn(withDuration: 1))
                        
                        subtitleText.position = CGPoint(x: self.frame.width * 0.24 + subtitleText.frame.width/2, y: self.frame.height * 0.269 - subtitleText.frame.height/2)
//                        subtitle.alpha = 0
                        subtitleText.run(SKAction.fadeIn(withDuration: 1))
//                        addChild(subtitle)
                        
                        
//                        title.position = CGPoint(x: self.frame.width * 0.0585 + title.frame.width/2, y: self.frame.height * 0.829 + title.frame.height/2)
//                        title.alpha = 0
//                        title.run(SKAction.fadeIn(withDuration: 1))
//                        addChild(title)
                        
                        spaceCreatures.run(SKAction.fadeIn(withDuration: 2))
                        
                    }
                ]))
            } else if storyIdx == 3 {
                self.view?.presentScene(FirstHalfStory2(size: self.size), transition: SKTransition.crossFade(withDuration: 3))
            }
            storyIdx += 1
        }
    }
}
