# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a SwiftUI iOS demo application showcasing PreviewTraits functionality. It serves as a starter/tutorial project for a YouTube video series by Stewart Lynch demonstrating how to use various SwiftUI preview traits for efficient UI development and testing.

The project demonstrates six categories of PreviewTraits with interactive examples, mock data support, and modern SwiftUI patterns including SwiftData integration.

## Architecture

### Application Structure

- **Entry Point**: [PreviewTraitsDemoApp.swift](PreviewTraitsDemo/PreviewTraitsDemoApp.swift) - Main app with environment setup and SwiftData model container
- **Root View**: [0. StartTab.swift](PreviewTraitsDemo/0.%20StartTab.swift) - Tab-based navigation container with 6 demo sections
- **Navigation**: Tab-style page view using `TabView` with `.page` style and custom menu-based tab selection via `.safeAreaInset`

### State Management Pattern

The project uses Swift's modern `@Observable` macro for state management:

- **NavigationManager**: Manages selected tab state across the app
- **NetworkService**: Observable service class for mock network data with boolean flag for test data
- **SwiftData**: TodoItem model for persistent storage demonstration
- Dependencies are injected via SwiftUI's `.environment()` modifier at the app level

### Data Models

#### TodoItem (SwiftData)

The TodoItem model in [6. Mock SwiftData.swift](PreviewTraitsDemo/6.%20Mock%20SwiftData.swift) demonstrates rich SwiftData usage:

```swift
@Model
class TodoItem {
    var title: String
    var todoDescription: String?      // Optional description
    var imageData: Data?               // Optional image storage
    var isCompleted: Bool
    var createdAt: Date
}
```

Key features:

- Stores images as `Data` type for persistence
- Uses PhotosPicker for image selection
- Demonstrates optional properties in SwiftData models
- Component-based view architecture (TodoRow, AddTodoSheet) to avoid Swift compiler timeouts

### File Organization

Demo views are numbered 0-6 for sequential learning:

- `0. StartTab.swift` - Main tab container with menu navigation
- `1. Orientation Traits.swift` - Device orientation preview traits
- `2. Layout Traits.swift` - Layout-related preview configurations
- `3. AssistiveAccess Trait.swift` - Accessibility preview testing
- `4. Convenience Traits.swift` - Theme and appearance traits
- `5. Mock Network Trait.swift` - Network mocking in previews
- `6. Mock SwiftData.swift` - SwiftData mocking with TodoRow and AddTodoSheet components

The `Services/` directory contains shared observable classes used across multiple views.

## Building and Running

This is a standard Xcode project with no external dependencies (no CocoaPods, no Swift Package Manager dependencies).

**In Xcode:**

- Build: `Cmd+B`
- Run: `Cmd+R`
- Clean: `Shift+Cmd+K`

**Command Line:**

```bash
# Build the project
xcodebuild -project PreviewTraitsDemo.xcodeproj -scheme PreviewTraitsDemo -sdk iphonesimulator -configuration Debug build -allowProvisioningUpdates

# Clean build folder
xcodebuild -project PreviewTraitsDemo.xcodeproj -scheme PreviewTraitsDemo clean
```

## SwiftUI Previews

Each demo view includes a `#Preview` macro demonstrating the preview trait being showcased. When adding new views or modifying existing ones, maintain the preview examples as they are the core teaching element of this project.

### Custom Preview Traits

The project includes custom preview traits located in the `Custom Traits/` directory for reusable preview configurations across the app.

## Code Patterns

### Observable Services

Services use the `@Observable` macro (not `ObservableObject`):

```swift
@Observable
class ServiceName {
    var property: Type
}
```

### Environment Injection

Views access services via `@Environment`:

```swift
@Environment(NavigationManager.self) var navManager
```

For two-way binding with Observable objects, use `@Bindable`:

```swift
@Bindable var navManager = navManager
```

### SwiftData Model Container

The app-level model container is configured in PreviewTraitsDemoApp:

```swift
WindowGroup {
    StartTab()
        .environment(navigationManager)
        .environment(networkService)
}
.modelContainer(for: TodoItem.self)
```

### PhotosPicker Integration

The TodoItem demo shows proper PhotosPicker usage with async image loading:

```swift
PhotosPicker(selection: $selectedPhoto, matching: .images) {
    Label("Select Photo", systemImage: "photo")
}
.onChange(of: selectedPhoto) { oldValue, newValue in
    Task {
        if let data = try? await newValue?.loadTransferable(type: Data.self) {
            selectedImageData = data
        }
    }
}
```

## Component Architecture

### Breaking Down Complex Views

When views become too complex for the Swift type-checker, break them into smaller components:

- **TodoRow** - Reusable row component for displaying todo items
- **AddTodoSheet** - Separate sheet view for adding/editing todos

This pattern prevents "type-checker timeout" errors and improves code organization.

## Navigation

### MyTabs Enum

The [0. StartTab.swift:70](PreviewTraitsDemo/0.%20StartTab.swift#L70) file defines `MyTabs` enum that controls navigation. When adding new demo tabs:

1. Add a new case to the enum
2. Update the `title` computed property
3. Add a new `Tab` in StartTab's TabView
4. Create corresponding view file

## Important Notes

- Always inject environment objects at the app level in PreviewTraitsDemoApp.swift
- Use `.environment()` for @Observable objects (not `.environmentObject()`)
- PhotosPicker requires `import PhotosUI`
- SwiftData models require `import SwiftData` and `@Model` macro
- Image data is stored as `Data` type for SwiftData compatibility
