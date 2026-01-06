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

struct ConvenienceTrait: View {
    
    @Environment(NavigationManager.self) private var navigationManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Theme Aware Design")
                    .font(.largeTitle)
                    .bold()
                RoundedRectangle(cornerRadius: 16)
                    .fill(.blue.gradient)
                    .frame(height: 100)
                    .overlay {
                        Text("Some Card")
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                
                HStack {
                    Label("Light", systemImage: "sun.max.fill")
                    Spacer()
                    Label("Dark", systemImage: "moon.fill")
                }
                .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle(navigationManager.selectedTab.title)
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

#Preview(
    "Normal",
    traits: .navigationTrait(selected: .convenience)
) {
    ConvenienceTrait()
}

#Preview(
    "Dark Mode",
    traits: .navigationTrait(selected: .convenience)
) {
    ConvenienceTrait()
        .preferredColorScheme(.dark)
}

#Preview(
    "Dark Mode",
    traits: .modifier(DarkModeTrait()),
    .navigationTrait(selected: .convenience)
) {
    ConvenienceTrait()
}

#Preview(
    "Dark Mode",
    traits: .darkMode,
    .navigationTrait(selected: .convenience)
) {
    ConvenienceTrait()
}

#Preview(
    "Light Mode",
    traits: .navigationTrait(selected: .convenience)
) {
    ConvenienceTrait()
        .preferredColorScheme(.light)
}

#Preview(
    "Dark Mode + XXXLarge Type",
    traits: .navigationTrait(selected: .convenience)
) {
    ConvenienceTrait()
        .preferredColorScheme(.dark)
        .environment(\.dynamicTypeSize, .xxxLarge)
}

#Preview(
    "Dark Mode + accessibility4 Type",
    traits: .darkMode, .dynamicTypeSize(.accessibility4),
    .navigationTrait(selected: .convenience)
) {
    ConvenienceTrait()
}
