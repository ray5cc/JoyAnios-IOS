//
//  CircleBtnPosition.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/8.
//
import SwiftUI
import Foundation


struct CircleBtnPosition {
    var left: CGPoint
    var right: CGPoint
    var top: CGPoint
    var bottom: CGPoint
    var diameter: CGFloat
    
    init(containerDiameter: CGFloat, btnSizeProportion: CGFloat = 0.3, btnGapProportion: CGFloat = 0.0) {
        diameter = containerDiameter * btnSizeProportion
        // Get center position
        let center = CGPoint(x: (containerDiameter / 2), y: (containerDiameter / 2))
        // Get gap between each button
        let gap = containerDiameter * btnSizeProportion
        // Get distance between centre and each button
        let d = (gap + diameter) / 2
        
        left = CGPoint(x: (center.x - d), y: (center.y))
        right = CGPoint(x: (center.x + d), y: (center.y))
        top = CGPoint(x: (center.x), y: (center.y - d))
        bottom = CGPoint(x: (center.x), y: (center.y + d))
    }
}
