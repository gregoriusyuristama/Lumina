//
//  ContentView.swift
//  HackathonNASA
//
//  Created by Gregorius Yuristama Nugraha on 10/7/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct ContentView: View {
    var body: some View {
        SpriteView(scene: EclipseGameView(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), debugOptions: [.showsFPS, .showsNodeCount, .showsPhysics])
            .ignoresSafeArea()
//        ZStack {
//                
//            
//            Rectangle()
//                .fill(.white)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//            
//            Text("Test Scene")
//            VStack {
//                SpriteView(scene: EclipseGameView(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), debugOptions: [.showsFPS, .showsNodeCount, .showsPhysics])
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//            }.frame(width: 200, height: 200)
//                .position(x: 200, y: 200)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                
//        }
    }
}

#Preview {
    ContentView()
}
