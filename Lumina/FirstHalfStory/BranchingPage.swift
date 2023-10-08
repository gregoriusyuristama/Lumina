//
//  BranchingPage.swift
//  Lumina
//
//  Created by Gregorius Yuristama Nugraha on 10/8/23.
//

import Foundation
import SpriteKit
import Combine

class BranchingPage: SKScene {
    
    var eclipseView = EclipseGameView()
    var controllerContainer = SKShapeNode()
    private var backgroundImg = SKSpriteNode(imageNamed: "bg_branching")
    private var cancellables: Set<AnyCancellable> = []
    private var branchIdx: Int = -1
    
    private var nextScene: [SKScene] = [SKScene]()
    private var hasSnapped = false
    
    
    override func didMove(to view: SKView) {
        nextScene.append(PenumbralEclipse1(size: self.size))
        nextScene.append(PartialEclipse1(size: self.size))
        nextScene.append(FullEclipse1(size: self.size))
        
        
        backgroundImg.scale(to: self.size)
        backgroundImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        backgroundImg.zPosition = -1
        addChild(backgroundImg)
        
        controllerContainer = SKShapeNode(rect: CGRect(x: self.frame.width * 0.567, y: self.frame.height * 0.0659, width: 450, height: 276), cornerRadius: 32)
        controllerContainer.fillColor = AppColor.grayColor!
        controllerContainer.strokeColor = .clear
        
        let controllerOverlay = SKShapeNode(rect: CGRect(x: self.frame.width * 0.58, y: self.frame.height * 0.083, width: 423, height: 247), cornerRadius: 29)
        controllerOverlay.fillColor = AppColor.blueColor!
        controllerOverlay.strokeColor = .clear
        
        addChild(controllerContainer)
        controllerContainer.addChild(controllerOverlay)
        controllerContainer.isUserInteractionEnabled = false
        eclipseView.getSceneFrame(sceneFrame: CGRect(x: controllerContainer.position.x, y: controllerContainer.position.y, width: 150, height: 150))
        eclipseView.addEclipseView()
        eclipseView.isUserInteractionEnabled = true
        eclipseView.position = CGPoint(x: controllerContainer.frame.midX + 37 - eclipseView.sceneFrame.width/2, y: controllerContainer.frame.midY - eclipseView.sceneFrame.height/2)

        controllerContainer.addChild(eclipseView)
        
        let earthShadow = SKSpriteNode(imageNamed: "earth_shadow")
        earthShadow.position = CGPoint(x: controllerContainer.frame.minX + 69 + earthShadow.frame.width/2, y: controllerContainer.frame.midY)
        controllerContainer.addChild(earthShadow)
        
        let sun = SKShapeNode(ellipseOf: CGSize(width: 93, height: 93))
        sun.fillColor = AppColor.sunColor!
        sun.position = CGPoint(x: controllerContainer.frame.minX + 32 + sun.frame.width/2, y: controllerContainer.frame.midY)
        sun.strokeColor = .clear
        controllerContainer.addChild(sun)
        controllerContainer.zPosition = 1
        eclipseView.snapIdxPublisher
            .sink { snapIndex in
                var newTexture = self.backgroundImg.texture!
                if snapIndex == 1 || snapIndex == 2 {
                    newTexture = SKTexture(imageNamed: "bg_penumbral")
                    self.branchIdx = 0
                } else if snapIndex == 3 || snapIndex == 4 {
                    newTexture = SKTexture(imageNamed: "bg_partial")
                    self.branchIdx = 1
                    
                } else if snapIndex == 0 {
                    newTexture = SKTexture(imageNamed: "bg_full")
                    self.branchIdx = 2
                    
                }
                
                let transitionDuration: TimeInterval = 1.0

                // Create an action to smoothly transition between textures
                let textureChangeAction = SKAction.animate(with: [self.backgroundImg.texture!, newTexture], timePerFrame: transitionDuration / 2)

                // Run the texture change action
                self.backgroundImg.run(textureChangeAction)
                self.hasSnapped = true
            }
            .store(in: &cancellables)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        eclipseView.update(currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if backgroundImg.contains(touchLocation) && hasSnapped{
            self.view?.presentScene(nextScene[branchIdx], transition: .crossFade(withDuration: 2))
        }
    }
}
