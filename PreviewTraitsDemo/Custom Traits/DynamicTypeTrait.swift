//
//  DynamicTypeTrait.swift
//  PreviewTraitsDemo
//
//  Created by Abdelrahman Mohamed on 06.01.2026.
//

import SwiftUI

struct DynamicTypeTrait: PreviewModifier {
    let dynamicTypeSize: DynamicTypeSize
    
    func body(content: Content, context: Void) -> some View {
        content
            .environment(\.dynamicTypeSize, dynamicTypeSize)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static func dynamicTypeSize(_ size: DynamicTypeSize) -> PreviewTrait {
        .modifier(DynamicTypeTrait(dynamicTypeSize: size))
    }
}
