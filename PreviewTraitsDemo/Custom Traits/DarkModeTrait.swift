//
//  DarkModeTrait.swift
//  PreviewTraitsDemo
//
//  Created by Abdelrahman Mohamed on 06.01.2026.
//

import SwiftUI

struct DarkModeTrait: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        content
            .preferredColorScheme(.dark)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var darkMode: Self = .modifier(DarkModeTrait())
}
