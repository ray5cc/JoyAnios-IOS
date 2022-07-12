//
//  CrossButtonGroup.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/8.
//

import SwiftUI

struct CrossButtonGroup: View {
    var containerDiameter: CGFloat = 100
    var position: CGPoint

    private var btnPos: SquareBtnPosition

    init(diameter: CGFloat = 100, position: CGPoint = CGPoint(x: 50, y: 50)) {
        self.containerDiameter = diameter
        self.position = position
        btnPos = SquareBtnPosition(containerDiameter: diameter)
    }

    var body: some View {
        ZStack {
            SquareButton(
                    label: Image(systemName: "chevron.up"),
                    size: CGSize(width: btnPos.width, height: btnPos.height),
                    position: btnPos.top,
                    rotation: .top
            )
            SquareButton(
                    label: Image(systemName: "chevron.up"),
                    size: CGSize(width: btnPos.width, height: btnPos.height),
                    position: btnPos.right,
                    rotation: .right
            )
            SquareButton(
                    label: Image(systemName: "chevron.up"),
                    size: CGSize(width: btnPos.width, height: btnPos.height),
                    position: btnPos.bottom,
                    rotation: .bottom
            )
            SquareButton(
                    label: Image(systemName: "chevron.up"),
                    size: CGSize(width: btnPos.width, height: btnPos.height),
                    position: btnPos.left,
                    rotation: .left
            )
        }
                .frame(width: containerDiameter, height: containerDiameter)
                .position(x: position.x, y: position.y)
    }
}

struct CrossButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        CrossButtonGroup()
    }
}
