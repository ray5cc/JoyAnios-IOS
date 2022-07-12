//
//  ButtonGallary.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/7.
//

import SwiftUI

struct StickTester: View {
    @State var lStickPoint: CGPoint = .zero

    var body: some View {
        VStack {
            Stick(diameter: 50, onMove: { x, y in
                lStickPoint = CGPoint(x: x, y: y)
            })
            Text("\(lStickPoint.x), \(lStickPoint.y)")
        }
    }
}

struct ButtonGallary: View {
    var body: some View {
        GeometryReader { proxy in
            let f = proxy.frame(in: .local)
            let centerPoint = CGPoint(x: f.midX, y: f.midY)
            List {
                NavigationLink(destination: StickTester(), label: {
                    Text("Stick")
                })
                NavigationLink(destination: CircleButton(label: Text("A"), position: centerPoint), label: {
                    Text("Cirle Button")
                })
                NavigationLink(destination: SquareButton(label: Image(systemName: "chevron.up"), position: centerPoint), label: {
                    Text("Square Button")
                })
                NavigationLink(destination: BarButton(label: Text("L"), position: centerPoint), label: {
                    Text("Bar Button")
                })
                NavigationLink(destination: FuncButtonGroup(
                        diameter: 300.0,
                        position: centerPoint), label: {
                    Text("Func Button Group")
                })
                NavigationLink(destination: CrossButtonGroup(
                        diameter: 300.0,
                        position: centerPoint), label: {
                    Text("Cross Button Group")
                })
            }
        }
                .navigationTitle("Button Gallary")
    }
}

struct ButtonGallary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonGallary()
    }
}
