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

struct MockNetworkTrait: View {
    
    @Environment(NavigationManager.self) private var navigationManager
    @Environment(NetworkService.self) var networkService
    
    var body: some View {
        NavigationStack {
            List(networkService.users) { user in
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(navigationManager.selectedTab.title)
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

#Preview(
    "Normal Network",
    traits: .navigationTrait(selected: .mockNetwork)
) {
    MockNetworkTrait()
        .environment(NetworkService())
}

#Preview(
    "Mock Network",
    traits: .mockNetworkService,
    .navigationTrait(selected: .mockNetwork)
) {
    MockNetworkTrait()
}
