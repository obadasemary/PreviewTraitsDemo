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

struct StartTab: View {
    @Environment(NavigationManager.self) var navManager
    var body: some View {
        @Bindable var navManager = navManager
        TabView(selection: $navManager.selectedTab) {
            Tab(value: .orientation) {
                OrientationTraits()
            }
            Tab(value: .layout) {
                LayoutTraits()
            }
            Tab(value: .assistiveAccess) {
               AssistiveAccessTrait()
            }
            Tab(value: .convenience) {
               ConvenienceTrait()
            }
            Tab(value: .mockNetwork) {
                MockNetworkTrait()
            }
            Tab(value: .mockSwiftData) {
                MockSwiftData()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .safeAreaInset(edge: .top, alignment: .trailing) {
            Menu {
                Picker("Select Tab", selection: $navManager.selectedTab) {
                    ForEach(MyTabs.allCases) { tab in
                        Button(tab.title) {
                            navManager.selectedTab = tab
                        }
                    }
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title)
                    .padding(5)
                    
            }
            .glassEffect(.regular)
            .offset(x: -60, y: -20)
        }
    }
}

#Preview(traits: .mockNetworkService) {
    StartTab()
        .environment(NavigationManager())
}

enum MyTabs: Hashable, CaseIterable, Identifiable {
    case orientation, layout, assistiveAccess, convenience, mockNetwork, mockSwiftData
    var id: Self { self }
    var title: String {
        switch self {
        case .orientation:
            "Orientation Traits"
        case .layout:
            "Layout Traits"
        case .assistiveAccess:
            "Assistive Access Trait"
        case .convenience:
            "Convenience Traits"
        case .mockNetwork:
            "Network Trait"
        case .mockSwiftData:
            "SwiftData Trait"
        }
    }

}
