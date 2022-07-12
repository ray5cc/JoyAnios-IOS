//
//  ContentView.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
            NavigationLink(destination: GamePadView(), label: {
                Text("Game Pad")
            })
            NavigationLink(destination: ButtonGallary(), label: {
                Text("Button Gallary")
            })
            }.navigationTitle("Menu")
        }
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    windowScene?.windows.first?.rootViewController =
            UIHostingController(rootView: ContentView_Previews.previews)
    }
    #endif
}
