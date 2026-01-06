//
//  MockSwiftDataTrait.swift
//  PreviewTraitsDemo
//
//  Created by Abdelrahman Mohamed on 06.01.2026.
//

import SwiftUI
import SwiftData

struct MockSwiftDataTrait: PreviewModifier {
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
    
    static func makeSharedContext() async throws -> Context {
        let container = try ModelContainer(
            for: TodoItem.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        let sampleTodos = [
            TodoItem(title: "Buy PS5", isCompleted: false),
            TodoItem(title: "Buy Coffee", isCompleted: false),
            TodoItem(title: "Finish my homework", isCompleted: true),
            TodoItem(title: "Call Mom", isCompleted: false),
            TodoItem(title: "Schedule a movie night", isCompleted: false),
            TodoItem(title: "Review Pull Request", isCompleted: true),
        ]
        
        for todo in sampleTodos {
            container.mainContext.insert(todo)
        }
        
        return container
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mockData: Self = .modifier(MockSwiftDataTrait())
}
