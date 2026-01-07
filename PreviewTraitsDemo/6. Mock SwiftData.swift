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
import PhotosUI

@Model
class TodoItem {
    var title: String
    var todoDescription: String?
    var imageData: Data?
    var isCompleted: Bool
    var createdAt: Date

    init(
        title: String,
        todoDescription: String? = nil,
        imageData: Data? = nil,
        isCompleted: Bool = false,
        createdAt: Date = Date.now
    ) {
        self.title = title
        self.todoDescription = todoDescription
        self.imageData = imageData
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}


struct MockSwiftData: View {

    @Environment(NavigationManager.self) private var navigationManager
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddSheet = false
    @State private var dateInput: String = ""
    @State private var titleInput: String = ""
    @State private var descriptionInput: String = ""
    @State private var selectedDate: Date = .now
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @Query private var todos: [TodoItem]

    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    TodoRow(todo: todo)
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
            .navigationTitle(navigationManager.selectedTab.title)
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New", systemImage: "plus") {
                        titleInput = ""
                        descriptionInput = ""
                        dateInput = ""
                        selectedDate = .now
                        selectedPhoto = nil
                        selectedImageData = nil
                        showingAddSheet = true
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddTodoSheet(
                    titleInput: $titleInput,
                    descriptionInput: $descriptionInput,
                    selectedDate: $selectedDate,
                    selectedPhoto: $selectedPhoto,
                    selectedImageData: $selectedImageData,
                    isPresented: $showingAddSheet,
                    modelContext: modelContext
                )
            }
        }
    }
}

// MARK: - TodoRow
struct TodoRow: View {
    let todo: TodoItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(todo.isCompleted ? .green : .gray)
                .font(.title2)

            if let imageData = todo.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .font(.headline)
                    .strikethrough(todo.isCompleted)

                if let description = todo.todoDescription, !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                Text(todo.createdAt, style: .date)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

// MARK: - AddTodoSheet
struct AddTodoSheet: View {
    @Binding var titleInput: String
    @Binding var descriptionInput: String
    @Binding var selectedDate: Date
    @Binding var selectedPhoto: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    @Binding var isPresented: Bool
    let modelContext: ModelContext

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $titleInput)
                        .textInputAutocapitalization(.sentences)

                    TextField("Description (Optional)", text: $descriptionInput, axis: .vertical)
                        .textInputAutocapitalization(.sentences)
                        .lineLimit(3...6)

                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                }

                Section("Image (Optional)") {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        Label("Select Photo", systemImage: "photo")
                    }

                    if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                        HStack {
                            Spacer()
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            Spacer()
                        }

                        Button(role: .destructive) {
                            self.selectedPhoto = nil
                            self.selectedImageData = nil
                        } label: {
                            Label("Remove Photo", systemImage: "trash")
                        }
                    }
                }
            }
            .onChange(of: selectedPhoto) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
            .navigationTitle("New To-Do")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        saveTodo()
                    }
                }
            }
        }
    }

    private func saveTodo() {
        let title = titleInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return }

        let description = descriptionInput.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalDescription = description.isEmpty ? nil : description

        let newItem = TodoItem(
            title: title,
            todoDescription: finalDescription,
            imageData: selectedImageData,
            isCompleted: false,
            createdAt: selectedDate
        )
        modelContext.insert(newItem)
        isPresented = false
    }
}

#Preview(
    traits: .mockData,
    .navigationTrait(selected: .mockSwiftData)
) {
    MockSwiftData()
}
