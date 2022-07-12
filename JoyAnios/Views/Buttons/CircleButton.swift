//
//  CircleButton.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/7.
//

import SwiftUI

struct CircleButton<Label>: View where Label: View {

    let label: Label
    var diameter: CGFloat = 100.0
    var textColor = Color.white
    var backgroundColor = Color.mint
    var position: CGPoint = CGPoint(x: 50, y: 50)
    var onPressDown: (() -> Void)?
    var onPressUp: (() -> Void)?

    @State var activeScale: CGFloat = 1
    @State var pressed: Bool = false

    private let hapticsMgr = FeedbackHapticsManager()

    var trackDownAndUp: some Gesture {
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

        label
                .font(.system(size: diameter * 0.8))
                .foregroundColor(textColor)
                .frame(width: diameter * activeScale, height: diameter * activeScale)
                .background(backgroundColor)
                .clipShape(Circle()).contentShape(Circle()).clipped().gesture(trackDownAndUp)
                .position(x: (position.x), y: (position.y))

    }
}

class CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(label: Text("A"))

    }

//    #if DEBUG
//    @objc class func injected() {
//        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        //        windowScene?.windows.first?.rootViewController =
//        //                UIHostingController(rootView: ContentView())
//        windowScene?.windows.first?.rootViewController =
//                UIHostingController(rootView: FuncButtonGroup_Previews.previews)
//    }
//    #endif
}
