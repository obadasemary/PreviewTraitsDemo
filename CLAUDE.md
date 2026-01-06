# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a SwiftUI iOS demo application showcasing PreviewTraits functionality. It serves as a starter/tutorial project for a YouTube video series by Stewart Lynch demonstrating how to use various SwiftUI preview traits for efficient UI development and testing.

## Architecture

### Application Structure
- **Entry Point**: [PreviewTraitsDemoApp.swift](PreviewTraitsDemo/PreviewTraitsDemoApp.swift) - Main app using SwiftUI App protocol
- **Root View**: [0. StartTab.swift](PreviewTraitsDemo/0.%20StartTab.swift) - Tab-based navigation container with 6 demo sections
- **Navigation**: Tab-style page view using `TabView` with `.page` style and custom menu-based tab selection

### State Management Pattern
The project uses Swift's modern `@Observable` macro for state management:
- **NavigationManager**: Manages selected tab state across the app
- **NetworkService**: Observable service class for mock network data
- Dependencies are injected via SwiftUI's `.environment()` modifier

### File Organization
Demo views are numbered 0-6 for sequential learning:
- `0. StartTab.swift` - Main tab container
- `1. Orientation Traits.swift` - Device orientation preview traits
- `2. Layout Traits.swift` - Layout-related preview configurations
- `3. AssistiveAccess Trait.swift` - Accessibility preview testing
- `4. Convenience Traits.swift` - Theme and appearance traits
- `5. Mock Network Trait.swift` - Network mocking in previews
- `6. Mock SwiftData.swift` - SwiftData mocking in previews

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
xcodebuild -project PreviewTraitsDemo.xcodeproj -scheme PreviewTraitsDemo -configuration Debug build

# Clean build folder
xcodebuild -project PreviewTraitsDemo.xcodeproj -scheme PreviewTraitsDemo clean
```

## SwiftUI Previews

Each demo view includes a `#Preview` macro demonstrating the preview trait being showcased. When adding new views or modifying existing ones, maintain the preview examples as they are the core teaching element of this project.

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

## MyTabs Enum
The [0. StartTab.swift:72](PreviewTraitsDemo/0.%20StartTab.swift#L72) file defines `MyTabs` enum that controls navigation. When adding new demo tabs, update this enum and add corresponding cases to the switch statement.
