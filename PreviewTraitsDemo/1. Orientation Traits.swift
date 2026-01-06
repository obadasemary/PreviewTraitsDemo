//
//----------------------------------------------
// Original project: PreviewTraitsDemo
//
// Follow me on Mastodon: https://iosdev.space/@StewartLynch
// Follow me on Threads: https://www.threads.net/@stewartlynch
// Follow me on Bluesky: https://bsky.app/profile/stewartlynch.bsky.social
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Email: slynch@createchsol.com
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2026 CreaTECH Solutions (Stewart Lynch). All rights reserved.


import SwiftUI

struct OrientationTraits: View {
    
    @Environment(NavigationManager.self) private var navigationManager
    
    var body: some View {
        NavigationStack {
            ViewThatFits {
                HStack {
                    threeSquares
                }
                VStack {
                    threeSquares
                }
            }
            .navigationTitle(navigationManager.selectedTab.title)
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
    
    @ViewBuilder
    var threeSquares: some View {
        ForEach(1...3, id: \.self) { _ in
            Rectangle()
                .frame(width: 175, height: 175)
        }
    }
}

#Preview(
    "Protrait",
    traits: .navigationTrait(selected: .orientation)
) {
    OrientationTraits()
}

#Preview(
    "Landscape",
    traits: .landscapeLeft, .navigationTrait(selected: .orientation)
) {
    OrientationTraits()
}

