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
        SpriteView(scene: BranchingPage(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), debugOptions: [.showsFPS, .showsNodeCount])
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
