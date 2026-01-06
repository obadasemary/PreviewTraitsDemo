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

struct LayoutTraits: View {
    
    @Environment(NavigationManager.self) private var navigationManager
    
    var body: some View {
        VStack{
            Text("Layout Constraints").font(.largeTitle.bold())
            VStack {
                Text("Welcome Back")
                    .font(.headline)
                Text("You have 3 new messages")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
        }
        .padding()
        .navigationTitle(navigationManager.selectedTab.title)
    }
}

#Preview("Normal", traits: .navigationTrait(selected: .layout)) {
    LayoutTraits()
}

#Preview(
    "Fit Content",
    traits: .sizeThatFitsLayout, .navigationTrait(selected: .layout)
) {
    LayoutTraits()
}

#Preview(
    "Fixed Layout",
    traits: .fixedLayout(
        width: 200,
        height: 200
    ),
    .navigationTrait(selected: .layout)
) {
    LayoutTraits()
}
