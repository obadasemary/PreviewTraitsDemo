//
//  NavigationTrait.swift
//  PreviewTraitsDemo
//
//  Created by Abdelrahman Mohamed on 06.01.2026.
//

import SwiftUI

struct NavigationTrait: PreviewModifier {
    
    let selected: MyTabs
    
    func body(content: Content, context: Void) -> some View {
        @Previewable @State var navigationManager = NavigationManager()
        content
            .environment(navigationManager)
            .onAppear {
                navigationManager.selectedTab = selected
            }
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static func navigationTrait(selected: MyTabs) -> Self {
        .modifier(NavigationTrait(selected: selected))
    }
}
