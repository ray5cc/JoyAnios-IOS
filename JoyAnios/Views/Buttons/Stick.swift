//
//  Stick.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/7.
//

import SwiftUI

struct Stick: View {
    var rangeScale = 2.0
    var diameter: CGFloat = 100.0

    private var stickRangeDiameter: CGFloat = 200.0
    private var stickRangeBorderWidth: CGFloat = 5
    private var maxR: CGFloat
    private var frameSize: CGSize

    private let position: CGPoint

    private var hapticMgr = FeedbackHapticsManager()

    var onMove: ((_ x: Double, _ y: Double) -> Void)?

    @State private var offset: CGPoint = .zero
    @State private var previousActR: CGFloat = 0

    var move: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let actX = value.translation.width
                let actY = value.translation.height
                let actR = sqrt(pow(Double(actX), 2) + pow(Double(actY), 2))

                if previousActR < maxR && actR >= maxR {
                    hapticMgr.trigger(style: .rigid)
                }

                self.previousActR = actR

                if actR <= maxR {
                    if onMove != nil {
                        onMove!(actX / maxR, actY / maxR)
                    }
                    offset = CGPoint(x: actX, y: actY)
                } else {
                    let s = maxR / actR
                    let x = actX * s
                    let y = actY * s
                    if onMove != nil {
                        onMove!(x / maxR, y / maxR)
                    }
                    offset = CGPoint(x: x, y: y)
                }
            }
            .onEnded { _ in
                hapticMgr.trigger(style: .heavy)
                if onMove != nil {
                    // TODO: transition to zero
                    onMove!(0, 0)
                }
                offset = .zero
            }
    }

    init(diameter: CGFloat = 100.0, position: CGPoint = .zero, onMove: ((_ x: Double, _ y: Double) -> Void)? = nil) {
        self.diameter = diameter
        if onMove != nil {
            self.onMove = onMove!
        }
        stickRangeDiameter = diameter * rangeScale
        self.position = CGPoint(x: position.x + stickRangeDiameter / 2, y: position.y + stickRangeDiameter / 2)
        stickRangeBorderWidth = diameter / 20
        maxR = sqrt(pow((stickRangeDiameter - diameter) / 2, 2))
        frameSize = CGSize(width: stickRangeDiameter + stickRangeBorderWidth, height: stickRangeDiameter + stickRangeBorderWidth)

    }

    var body: some View {
        Ellipse()
            .frame(width: diameter, height: diameter)
            .position(x: position.x, y: position.y)
            .offset(x: offset.x, y: offset.y)
            .gesture(move)
            .foregroundColor(Color.red)
            .overlay(Circle().stroke(Color.purple, lineWidth: stickRangeBorderWidth)
                .frame(width: stickRangeDiameter, height: stickRangeDiameter)
                .position(x: position.x, y: position.y))
            .frame(width: frameSize.width, height: frameSize.height)
            .position(x: position.x, y: position.y)
    }
}

struct Stick_Previews: PreviewProvider {
    static var previews: some View {
        Stick()
    }
}
