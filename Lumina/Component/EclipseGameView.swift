//
//  EclipseGameView.swift
//  HackathonNASA
//
//  Created by Gregorius Yuristama Nugraha on 10/7/23.
//

import Foundation
import SpriteKit
import Combine

class EclipseGameView: SKNode {
    var moonOrbit: SKShapeNode!
    var moon: SKShapeNode!
    var earth: SKSpriteNode!
    private var isMovingLittleCircle = false
    
    var isActionInProgress = false
    
    var sceneFrame = CGRect()
//    var targetCircle1: SKShapeNode!
//    var targetCircle2: SKShapeNode!
//    var targetCircle3: SKShapeNode!
    let positionTolerance : CGFloat = 20
//    var shouldDoSnap = true
    
    var targetCircles: [SKShapeNode] = [SKShapeNode]()
    
    var snapIdx = -1
    private var snapIdxSubject = PassthroughSubject<Int, Never>()
    
    override init() {
        super.init()
    }
    
    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
    }
    
    func addEclipseView() {
        
        
        moonOrbit = SKShapeNode(ellipseIn: CGRect(x: 0, y: 0, width: 150, height: 150))
        moonOrbit.position = CGPoint(x: sceneFrame.width / 2 - moonOrbit.frame.width/2, y: sceneFrame.height / 2 - moonOrbit.frame.height/2)
        moonOrbit.zPosition = 0
        addChild(moonOrbit)
        
        moon = SKShapeNode(ellipseOf: CGSize(width: 18, height: 18))
        moon.zPosition = 1
        moon.fillColor = AppColor.moonColor!
        moon.strokeColor = .clear
        moon.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2 + moonOrbit.frame.height/2)
        addChild(moon)
        
//        earth = SKShapeNode(ellipseIn: CGRect(x: 0, y: 0, width: moonOrbit.frame.width/4, height: moonOrbit.frame.height/4))
        earth = SKSpriteNode(imageNamed: "Earth")
        earth.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height/2 )
//        earth.fillColor = .green
        addChild(earth)
        
        let targetCircle1 = SKShapeNode(ellipseOf: CGSize(width: 7, height: 7))
        targetCircle1.position = CGPoint(x: sceneFrame.width / 2 + moonOrbit.frame.width/2 - targetCircle1.frame.width/4, y: sceneFrame.height / 2 )
        targetCircle1.fillColor = AppColor.targetColor!
        targetCircle1.strokeColor = .clear
        targetCircles.append(targetCircle1)
        
        let center = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        let angle = atan2(targetCircle1.position.y + 53 + targetCircle1.frame.height/2 - center.y, targetCircle1.position.x - 5 - targetCircle1.frame.width/2 - center.x)
        
        // Calculate the position of the little circle on the circumference
        let radius = moonOrbit.frame.width/2 // Adjust this value to change the radius of movement
        let newX = center.x + CGFloat(radius) * cos(angle)
        let newY = center.y + CGFloat(radius) * sin(angle)
        
        let targetCircle2 = SKShapeNode(ellipseOf: CGSize(width: 7, height: 7))
        targetCircle2.position = CGPoint(x: newX - targetCircle2.frame.width/4, y: newY - targetCircle2.frame.height/4)
        targetCircle2.fillColor = AppColor.targetColor!
        targetCircle2.strokeColor = .clear
        targetCircles.append(targetCircle2)
        
        let center2 = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        let angle2 = atan2(targetCircle1.position.y - 53 - targetCircle1.frame.height/2 - center.y, targetCircle1.position.x + 5 - targetCircle1.frame.width/2 - center.x)
        
        
        let newX2 = center.x + CGFloat(radius) * cos(angle2)
        let newY2 = center.y + CGFloat(radius) * sin(angle2)
        
        let targetCircle3 = SKShapeNode(ellipseOf: CGSize(width: 7, height: 7))
        targetCircle3.position = CGPoint(x: newX2 - targetCircle3.frame.width/4, y: newY2 - targetCircle3.frame.height/4)
        targetCircle3.fillColor = AppColor.targetColor!
        targetCircle3.strokeColor = .clear
        targetCircles.append(targetCircle3)
        
        let center3 = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        let angle3 = atan2(targetCircle1.position.y - 15 - targetCircle1.frame.height/2 - center.y, targetCircle1.position.x + 5 - targetCircle1.frame.width/2 - center.x)
        
        let newX3 = center.x + CGFloat(radius) * cos(angle3)
        let newY3 = center.y + CGFloat(radius) * sin(angle3)
        
        let targetCircle4 = SKShapeNode(ellipseOf: CGSize(width: 7, height: 7))
        targetCircle4.position = CGPoint(x: newX3 - targetCircle4.frame.width/4, y: newY3 - targetCircle4.frame.height/4)
        targetCircle4.fillColor = AppColor.targetColor!
        targetCircle4.strokeColor = .clear
        targetCircles.append(targetCircle4)
        
        let center4 = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        let angle4 = atan2(targetCircle1.position.y + 17 + targetCircle1.frame.height/2 - center.y, targetCircle1.position.x - 5 - targetCircle1.frame.width/2 - center.x)
        
        let newX4 = center.x + CGFloat(radius) * cos(angle4)
        let newY4 = center.y + CGFloat(radius) * sin(angle4)
        
        let targetCircle5 = SKShapeNode(ellipseOf: CGSize(width: 7, height: 7))
        targetCircle5.position = CGPoint(x: newX4 - targetCircle5.frame.width/4, y: newY4 - targetCircle5.frame.height/4)
        targetCircle5.fillColor = AppColor.targetColor!
        targetCircle5.strokeColor = .clear
        targetCircles.append(targetCircle5)
        
        
        for circle in targetCircles {
            addChild(circle)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if sceneFrame.contains(touchLocation) {
            isMovingLittleCircle = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isMovingLittleCircle, let touch = touches.first else { return }

        // Calculate the angle between the touch location and the center of the larger circle
        let touchLocation = touch.location(in: self)
        let center = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        let angle = atan2(touchLocation.y - center.y, touchLocation.x - center.x)

        let radius = moonOrbit.frame.width / 2
        let newX = center.x + CGFloat(radius) * cos(angle)
        let newY = center.y + CGFloat(radius) * sin(angle)

        let deltaX = newX - center.x
        let deltaY = newY - center.y
        let distance = sqrt(deltaX * deltaX + deltaY * deltaY)
        
        if distance <= radius {
            moon.position = CGPoint(x: newX, y: newY)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isMovingLittleCircle = false
    }
    
    func update(_ currentTime: TimeInterval) {
        if !isActionInProgress && !isMovingLittleCircle {
            let closestPoint = checkNearestPoint()
            let distanceToClosestPoint = distanceBetween(point1: moon.position, point2: closestPoint.position)
            
            if distanceToClosestPoint <= positionTolerance {
                print("Snap")
                
                // Set the flag to indicate that an action is in progress
                isActionInProgress = true
                
                moon.run(SKAction.move(to: closestPoint.position, duration: 0.5)) {
                    [weak self] in
                    // This code block is executed after the action completes
                    
                    // Reset the flag to indicate that the action has finished
                    self?.isActionInProgress = false
                    
                    // Notify about the snap index
                    self?.snapIdx = self?.targetCircles.firstIndex(of: closestPoint) ?? -1
                    self?.snapIdxSubject.send(self?.snapIdx ?? -1)
                }
            }
        }
    }

    
    func checkNearestPoint() -> SKShapeNode {
        var closestPoint: SKShapeNode = targetCircles.first!
        var closestDistance: CGFloat = distanceBetween(point1: moon.position, point2: closestPoint.position)
        
        for candidatePoint in targetCircles {
            let distance = distanceBetween(point1: moon.position, point2: candidatePoint.position)
            if distance < closestDistance {
                closestPoint = candidatePoint
                closestDistance = distance
            }
        }
        return closestPoint
    }
    
    func distanceBetween(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let deltaPos = point1 - point2
        return sqrt(deltaPos.x * deltaPos.x + deltaPos.y * deltaPos.y)
    }
    
    var snapIdxPublisher: AnyPublisher<Int, Never> {
        return snapIdxSubject.eraseToAnyPublisher()
    }
}
