//
//  SquareButton.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/7.
//

import SwiftUI

struct SquareButton<Label>: View where Label: View {
    let label: Label

    var size: CGSize = CGSize(width: 80.0, height: 120.0)
    var position: CGPoint = CGPoint(x: 40, y: 60)
    var rotation: CrossBtnRotation = .top
    let textColor = Color.white
    let backgroundColor = Color.blue.opacity(0.6)

    let borderColor = Color.blue
    var onPressDown: (() -> Void)?
    var onPressUp: (() -> Void)?

    @State var activeScale: CGFloat = 1
    @State var pressed: Bool = false

    private let hapticsMgr = FeedbackHapticsManager()

    var g: some Gesture {
        DragGesture(minimumDistance: 0).onChanged({ _ in
                    if !pressed {
                        withAnimation(.easeIn(duration: 0.1)) {
                            activeScale = ButtonConstants.BTN_ACTIVE_SCALE_FACTOR
                        }
                        onPressDown?()
                        hapticsMgr.trigger(style: .medium)
                        pressed = true
                    }
                })
                .onEnded({ _ in
                    if pressed {

                        withAnimation(.easeIn(duration: 0.1)) {
                            activeScale = 1
                        }
                        onPressUp?()
                        pressed = false
                    }
                })

    }
    var body: some View {

        label.font(.system(size: size.width * 0.8))
                .scenePadding(.top)
                .foregroundColor(textColor)
                .frame(width: size.width * activeScale, height: size.height * activeScale, alignment: .top)
                .background(backgroundColor)
                .border(borderColor, width: size.width * 0.08)
                .clipShape(RoundedRectangle(cornerRadius: ButtonConstants.RECT_BUTTON_RADIUS))
                .contentShape(RoundedRectangle(cornerRadius: ButtonConstants.RECT_BUTTON_RADIUS))
                .clipped()
                .gesture(g)

                .rotationEffect(.degrees(rotation.rawValue))
                .position(x: position.x, y: position.y)

    }
}

struct SquareButton_Previews: PreviewProvider {
    static var previews: some View {
        SquareButton(label: Image(systemName: "chevron.up"))
    }
}
