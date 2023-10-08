//
//  EclipseGameView.swift
//  HackathonNASA
//
//  Created by Gregorius Yuristama Nugraha on 10/7/23.
//

import Foundation
import SpriteKit

class EclipseGameView: SKNode {
    var moonOrbit: SKShapeNode!
    var moon: SKShapeNode!
    var earth: SKSpriteNode!
    private var isMovingLittleCircle = false
    
    var sceneFrame = CGRect()
//    var targetCircle1: SKShapeNode!
//    var targetCircle2: SKShapeNode!
//    var targetCircle3: SKShapeNode!
    let positionTolerance : CGFloat = 20
//    var shouldDoSnap = true
    
    var targetCircles: [SKShapeNode] = [SKShapeNode]()
    
    private var snapIdx = -1
    
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
        
        moon = SKShapeNode(circleOfRadius: 20)
        moon.zPosition = 1
        moon.fillColor = .black
        moon.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2 + moonOrbit.frame.height/2)
        addChild(moon)
        
//        earth = SKShapeNode(ellipseIn: CGRect(x: 0, y: 0, width: moonOrbit.frame.width/4, height: moonOrbit.frame.height/4))
        earth = SKSpriteNode(imageNamed: "Earth")
        earth.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height/2 )
//        earth.fillColor = .green
        addChild(earth)
        
        let targetCircle1 = SKShapeNode(circleOfRadius: 15)
        targetCircle1.position = CGPoint(x: sceneFrame.width / 2 + moonOrbit.frame.width/2, y: sceneFrame.height / 2 )
        targetCircle1.fillColor = .red
        targetCircles.append(targetCircle1)
        
        let center = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        let angle = atan2(targetCircle1.position.y + 100 - center.y, targetCircle1.position.x - 20 - center.x)
        
        // Calculate the position of the little circle on the circumference
        let radius = moonOrbit.frame.width/2 // Adjust this value to change the radius of movement
        let newX = center.x + CGFloat(radius) * cos(angle)
        let newY = center.y + CGFloat(radius) * sin(angle)
        
        let targetCircle2 = SKShapeNode(circleOfRadius: 15)
        targetCircle2.position = CGPoint(x: newX, y: newY)
        targetCircle2.fillColor = .red
        targetCircles.append(targetCircle2)
        
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
        if moon.contains(touchLocation) {
            isMovingLittleCircle = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isMovingLittleCircle, let touch = touches.first else { return }

        // Calculate the angle between the touch location and the center of the larger circle
        let touchLocation = touch.location(in: self)
        let center = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        let angle = atan2(touchLocation.y - center.y, touchLocation.x - center.x)

        // Calculate the position of the little circle on the circumference
        let radius = moonOrbit.frame.width / 2
        let newX = center.x + CGFloat(radius) * cos(angle)
        let newY = center.y + CGFloat(radius) * sin(angle)

        // Ensure the moon stays within the moonOrbit
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
        print("cek update")
        if !isMovingLittleCircle {
            let closestPoint = checkNearestPoint()
            let distanceToClosestPoint = distanceBetween(point1: moon.position, point2: closestPoint.position)
            
            if distanceToClosestPoint <= positionTolerance {
                print("Snap")
                
                moon.run(SKAction.move(to: closestPoint.position, duration: 0.5))
                snapIdx = targetCircles.firstIndex(of: closestPoint)!
                
                print(snapIdx)
//                targetCircle!.run(SKAction.fadeOut(withDuration: 0.2))
                
//                shouldDoSnap = false
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
}
