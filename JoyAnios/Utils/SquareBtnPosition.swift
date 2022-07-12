//
//  SquareBtnPosition.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/8.
//

import Foundation
import SwiftUI
import Foundation

enum CrossBtnRotation: Double {
    case top = 0
    case right = 90
    case bottom = 180
    case left = 270
    
}

struct SquareBtnPosition {
    var left: CGPoint
    var right: CGPoint
    var top: CGPoint
    var bottom: CGPoint
    // btn height & width
    var height: CGFloat
    var width: CGFloat
    
    public static var topRotation: Angle = .degrees(0)
    public  static var rightRotation: Angle = .degrees(90)
    public static var bottomRotation: Angle = .degrees(180)
    public static var leftRotation: Angle = .degrees(270)
    
    init(containerDiameter: CGFloat, btnWidthProportion: CGFloat = 0.2, btnHeightProportion: CGFloat = 0.3, btnGapProportion: CGFloat = 0.01) {
        height = containerDiameter * btnHeightProportion
        width = containerDiameter * btnWidthProportion
        
        // Get center position
        let center = CGPoint(x: (containerDiameter / 2), y: (containerDiameter / 2))
        // Get gap between each button
        let gap = containerDiameter * btnGapProportion
        // Centre space on cross
        let d = (gap + width + height) / 2
        
        left = CGPoint(x: (center.x - d), y: (center.y))
        right = CGPoint(x: (center.x + d), y: (center.y))
        top = CGPoint(x: (center.x), y: (center.y - d))
        bottom = CGPoint(x: (center.x), y: (center.y + d))
    }
}
