//
//  FuncButtonGroup.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/8.
//

import SwiftUI



struct FuncButtonGroup: View {
    var containerDiameter: CGFloat = 100
    var position: CGPoint
    
    private var btnPos: CircleBtnPosition
    
    init(diameter: CGFloat = 100, position: CGPoint = CGPoint(x: 50, y: 50)) {
        self.containerDiameter = diameter
        self.position = position
        btnPos = CircleBtnPosition(containerDiameter: diameter)
    }
    
    var body: some View {
        ZStack {
            CircleButton(label: Text("Y"), diameter: btnPos.diameter, position: btnPos.top)
            CircleButton(label: Text("X"), diameter: btnPos.diameter, position: btnPos.left)
            CircleButton(label: Text("B"), diameter: btnPos.diameter, position: btnPos.right)
            CircleButton(label: Text("A"), diameter: btnPos.diameter, position: btnPos.bottom)
        }.frame(width: containerDiameter, height: containerDiameter).position(x: position.x, y: position.y)
    }
}

class FuncButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        FuncButtonGroup()
    }
    //
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
