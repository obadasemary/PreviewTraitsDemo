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
import SwiftData

@Model
class TodoItem {
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(title: String, isCompleted: Bool = false, createdAt: Date = Date.now) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}


struct MockSwiftData: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddSheet = false
    @State private var dateInput: String = ""
    @State private var titleInput: String = ""
    @State private var selectedDate: Date = .now
    @Query private var todos: [TodoItem]
        var body: some View {
            NavigationStack {
                List {
                    ForEach(todos) { todo in
                        HStack {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(todo.isCompleted ? .green : .gray)
                            VStack(alignment: .leading) {
                                Text(todo.title)
                                    .strikethrough(todo.isCompleted)
                                Text(todo.createdAt, style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                withAnimation(.easeInOut) {
                                    todo.isCompleted.toggle()
                                }
                            } label: {
                                Label(todo.isCompleted ? "Uncomplete" : "Complete", systemImage: todo.isCompleted ? "arrow.uturn.backward.circle" : "checkmark.circle")
                            }
                            .tint(todo.isCompleted ? .orange : .green)

                            Button(role: .destructive) {
                                withAnimation(.easeInOut) {
                                    modelContext.delete(todo)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .navigationTitle("SwiftData")
                .toolbarTitleDisplayMode(.inlineLarge)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("New", systemImage: "plus") {
                            titleInput = ""
                            dateInput = ""
                            selectedDate = .now
                            showingAddSheet = true
                        }
                    }
                }
                .sheet(isPresented: $showingAddSheet) {
                    NavigationStack {
                        Form {
                            Section("Details") {
                                TextField("Title", text: $titleInput)
                                    .textInputAutocapitalization(.sentences)
                                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                            }
                        }
                        .navigationTitle("New To-Do")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button(role: .cancel) { showingAddSheet = false }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button(role: .confirm) {
                                    let title = titleInput.trimmingCharacters(in: .whitespacesAndNewlines)
                                    guard !title.isEmpty else { return }
                                    let newItem = TodoItem(title: title, isCompleted: false, createdAt: selectedDate)
                                    modelContext.insert(newItem)
                                    showingAddSheet = false
                                }
                            }
                        }
                    }
                }
            }
        }
}

#Preview {
    MockSwiftData()
}
