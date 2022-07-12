//
//  GamePadView.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/3.
//
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

struct GamePadRectLayout {
    let position: CGPoint
    let size: CGSize
}

struct GamePadCircleLayout {
    let position: CGPoint
    let diameter: CGFloat
}

struct GamePadLayout {
    let lStick: GamePadCircleLayout;
    let rStick: GamePadCircleLayout;
    let cross: GamePadCircleLayout;
    let functional: GamePadCircleLayout;
    let home: GamePadCircleLayout
    let menu: GamePadCircleLayout
    let view: GamePadCircleLayout
    let lt: GamePadRectLayout;
    let rt: GamePadRectLayout;
    let lb: GamePadRectLayout;
    let rb: GamePadRectLayout
}

struct FullScreenGamePadView: View {
    
    let layout: GamePadLayout;
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            GeometryReader{proxy in
                Group{
                    BarButton(label: Text("LT"), size: layout.lt.size, position: layout.lt.position)
                    BarButton(label: Text("RT"), size: layout.rt.size, position: layout.rt.position)
                    BarButton(label: Text("LB"), size: layout.lb.size, position: layout.lb.position)
                    BarButton(label: Text("RB"), size: layout.rb.size, position: layout.rb.position)
                    CircleButton(label: Image(systemName: "list.bullet.circle"),diameter: layout.menu.diameter ,position: layout.menu.position)
                    CircleButton(label: Image(systemName: "viewfinder.circle"),diameter: layout.view.diameter ,position: layout.view.position)
                    Stick(diameter: layout.lStick.diameter, position: layout.lStick.position)
                    Stick(diameter: layout.rStick.diameter, position: layout.rStick.position
                    )
                    CrossButtonGroup(diameter: layout.cross.diameter, position: layout.cross.position)
                    
                    
                    FuncButtonGroup(diameter: layout.functional.diameter, position: layout.functional.position)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName:"arrowshape.turn.up.backward.circle.fill")
                }).position(x:400, y: 10)
            }
        }
        
    }
}

struct GamePadView: View {
    var layout: GamePadLayout = GamePadLayout(
        lStick: GamePadCircleLayout(position: CGPoint(x: 20, y: 90), diameter: 80),
        rStick: GamePadCircleLayout(position: CGPoint(x: 280, y: 90), diameter: 80),
        cross: GamePadCircleLayout(position: CGPoint(x: 290, y: 120), diameter: 180),
        functional: GamePadCircleLayout(position: CGPoint(x: 510, y: 120), diameter: 180),
        home: GamePadCircleLayout(position: CGPoint(x: 0, y: 0), diameter: 100),
        menu: GamePadCircleLayout(position: CGPoint(x: 10, y: 50), diameter: 40),
        view: GamePadCircleLayout(position: CGPoint(x: 760, y: 50), diameter: 40),
        lt: GamePadRectLayout(position: CGPoint(x: 100, y: 50), size: CGSize(width: 100, height: 50)),
        rt: GamePadRectLayout(position: CGPoint(x: 680, y: 50), size: CGSize(width: 100, height: 50)),
        lb: GamePadRectLayout(position: CGPoint(x: 100, y: 110), size: CGSize(width: 100, height: 50)),
        rb: GamePadRectLayout(position: CGPoint(x: 680, y: 110), size: CGSize(width: 100, height: 50))
    )
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.scenePhase) private var scenePhase
    @State var lStickPoint: CGPoint = .zero
    @State var isFullScreen = false
    
    var body: some View {
        ZStack {}
            .fullScreenCover(isPresented: $isFullScreen, onDismiss: {
                presentationMode.wrappedValue.dismiss()
            }, content: {
                FullScreenGamePadView(layout: layout)
            } )
            .onChange(of: scenePhase, perform: {phase in
                if(phase == .active) {
                    isFullScreen = true
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
                }
            })
            .onAppear {
                isFullScreen = true
                AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                UINavigationController.attemptRotationToDeviceOrientation()
            }
            .onDisappear {
                DispatchQueue.main.async {
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
                }
            }
        
    }
}

class GamePadView_Previews: PreviewProvider {
    static var previews: some View {
        GamePadView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
    
#if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        //        windowScene?.windows.first?.rootViewController =
        //                UIHostingController(rootView: ContentView())
        windowScene?.windows.first?.rootViewController =
        UIHostingController(rootView: GamePadView_Previews.previews)
    }
#endif
}
