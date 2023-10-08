//
//  CGPoint+math.swift
//  HackathonNASA
//
//  Created by Gregorius Yuristama Nugraha on 10/7/23.
//

import Foundation

extension CGPoint {
    public static func - (lhs : CGPoint, rhs : CGPoint ) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    public static func + (lhs : CGPoint, rhs : CGPoint ) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

}
