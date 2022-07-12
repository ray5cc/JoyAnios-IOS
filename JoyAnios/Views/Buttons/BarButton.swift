//
//  BarButton.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/7.
//

import SwiftUI

struct BarButton <Label>: View where Label: View {
    let label: Label

    var size = CGSize(width: 160.0, height: 80.0)
    var position: CGPoint = CGPoint(x: 80, y: 40)
    let textColor = Color.white
    let backgroudColor = Color.cyan.opacity(0.6)
    let borderColor = Color.cyan
    var onPressDown: (() -> Void)?
    var onPressUp: (() -> Void)?

    @State var activeScale: CGFloat = 1
    @State var pressed: Bool = false

    private let hapticsMgr = FeedbackHapticsManager()

    var g: some Gesture {
        DragGesture(minimumDistance: 0).onChanged({_ in
            if !pressed {
                withAnimation(.easeIn(duration: 0.1)) {
                    activeScale = ButtonConstants.BTN_ACTIVE_SCALE_FACTOR
                }
                onPressDown?()
                hapticsMgr.trigger(style: .medium)
                pressed = true
            }
        }).onEnded({_ in
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

        label.font(.system(size: size.height * 0.6))
            .foregroundColor(textColor)
            .frame(width: size.width * activeScale, height: size.height * activeScale, alignment: .center)
            .background(backgroudColor)
            .border(borderColor, width: size.width * 0.08)
            .clipShape(RoundedRectangle(cornerRadius: ButtonConstants.RECT_BUTTON_RADIUS))
            .contentShape(RoundedRectangle(cornerRadius: ButtonConstants.RECT_BUTTON_RADIUS))
            .clipped()
            .gesture(g)
            .position(x: position.x, y: position.y)

    }
}

struct BarButton_Previews: PreviewProvider {
    static var previews: some View {
        BarButton(label: Text("L"))
    }
}
