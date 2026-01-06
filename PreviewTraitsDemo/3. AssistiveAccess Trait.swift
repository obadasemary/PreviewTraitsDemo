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

struct AssistiveAccessTrait: View {
    
    @Environment(NavigationManager.self) private var navigationManager
    @State private var toggle = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button("Call Mom") {
                    print("Calling...")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Send Text") {
                    print("Texting...")
                }
                .buttonStyle(.bordered)
                
                Toggle("Wi-Fi", isOn: $toggle)
                
                List {
                    NavigationLink("Mom") {
                        Text("Mom's Details")
                    }
                    NavigationLink("Dad") {
                        Text("Dad's Details")
                    }
                    NavigationLink("Sister") {
                        Text("Sister's Details")
                    }
                }
            }
            .padding()
            .navigationTitle(navigationManager.selectedTab.title)
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

#Preview(
    "Normal",
    traits: .navigationTrait(selected: .assistiveAccess)
) {
    AssistiveAccessTrait()
}

#Preview(
    "Assistive Access",
    traits: .assistiveAccess,
    .navigationTrait(selected: .assistiveAccess)
) {
    AssistiveAccessTrait()
}
