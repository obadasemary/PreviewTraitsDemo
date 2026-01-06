//
//  NetworkServiceTrait.swift
//  PreviewTraitsDemo
//
//  Created by Abdelrahman Mohamed on 06.01.2026.
//

import SwiftUI

struct NetworkServiceTrait: PreviewModifier {
    func body(content: Content, context: NetworkService) -> some View {
        content
            .environment(context)
    }
    
    static func makeSharedContext() async throws -> NetworkService {
        let service = NetworkService(mockData: true)
        return service
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mockNetworkService: Self = .modifier(NetworkServiceTrait())
}

