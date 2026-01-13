# SwiftUI Migration Notes

## Overview

This project has been migrated from XIB-based storyboards to SwiftUI. The migration targets Xcode 15 and macOS 14+.

## Old Architecture (XIB/Storyboard)

```
AppDelegate (@NSApplicationMain)
  ├── OpenFileWindowController (XIB)
  ├── AttributeInspectorWindowController (XIB)
  ├── DragDestinationView (Custom NSView)
  └── AttributeCellView (NSTableCellView)
```

## New Architecture (SwiftUI)

```
XattrEditorApp (@main)
  └── ContentView
      ├── OpenFileView (drag-and-drop)
      └── TabView
          └── AttributeInspectorView (per file)
```

## Changes Made

### New Files

- **XattrEditorApp.swift**: Main SwiftUI application entry point with `@main` attribute
- **OpenFileView.swift**: SwiftUI view for file selection with drag-and-drop support
- **AttributeInspectorView.swift**: SwiftUI view for viewing and editing extended file attributes
- **ContentView**: Container view that manages the app state and switches between open and inspector views

### Modified Files

- **Attribute.swift**: Updated to conform to `ObservableObject`, `Identifiable`, and `Hashable` for SwiftUI compatibility
- **Info.plist**: Removed `NSMainNibFile` and `NSPrincipalClass` entries (not needed for SwiftUI apps)
- **project.pbxproj**: Updated to include new SwiftUI files, deployment target set to macOS 11.0, Swift version updated to 5.9

### Deprecated Files (No Longer Used)

The following files are no longer referenced in the project but remain in the repository for reference:

#### XIB Files

- `MainMenu.xib` - Main menu interface definition
- `AttributeInspectorWindow.xib` - Inspector window interface
- `OpenFileWindow.xib` - Open file window interface

#### AppKit Window Controllers

- `AppDelegate.swift` - Application delegate (replaced by XattrEditorApp)
- `OpenFileWindowController.swift` - Window controller for file selection (replaced by OpenFileView)
- `AttributeInspectorWindowController.swift` - Window controller for attribute inspector (replaced by AttributeInspectorView)

#### AppKit Views

- `AttributeCellView.swift` - Table cell view for attributes (functionality integrated into AttributeInspectorView)
- `DragDestinationView.swift` - Custom drag-and-drop view (replaced by SwiftUI `.onDrop` modifier)
- `LineNumberView.swift` - Line number ruler view for text view (not yet reimplemented in SwiftUI)
- `NSTextView+LineNumber.swift` - Extension for line numbers (not yet reimplemented in SwiftUI)

#### Remove obsolete files in Terminal

```bash
# XIB files
rm "Xattr-Editor/Xattr Editor/MainMenu.xib"
rm "Xattr-Editor/Xattr Editor/Classes/WindowControllers/AttributeInspectorWindow.xib"
rm "Xattr-Editor/Xattr Editor/Classes/WindowControllers/OpenFileWindow.xib"

# Old controllers
rm "Xattr-Editor/Xattr Editor/Classes/Appdelegate/AppDelegate.swift"
rm "Xattr-Editor/Xattr Editor/Classes/WindowControllers/OpenFileWindowController.swift"
rm "Xattr-Editor/Xattr Editor/Classes/WindowControllers/AttributeInspectorWindowController.swift"

# Old views
rm "Xattr-Editor/Xattr Editor/Classes/Views/AttributeCellView.swift"
rm "Xattr-Editor/Xattr Editor/Classes/Views/DragDestinationView.swift"
rm "Xattr-Editor/Xattr Editor/Classes/Views/LineNumberView.swift"
rm "Xattr-Editor/Xattr Editor/Classes/Extensions/NSTextView+LineNumber.swift"

# Remove empty directories
rmdir "Xattr-Editor/Xattr Editor/Classes/Appdelegate" 2>/dev/null || true
rmdir "Xattr-Editor/Xattr Editor/Classes/WindowControllers" 2>/dev/null || true
```

**Note**: Only do this cleanup AFTER merging and verifying everything works!

## Features Preserved

- Drag-and-drop file selection
- Extended attribute viewing and editing
- Add/remove attributes
- Attribute name editing
- Attribute value editing
- Localized strings support
- Error handling with user-friendly alerts

## Features Not Yet Reimplemented

- Line numbers in the attribute value text editor (SwiftUI TextEditor doesn't have built-in line number support)
  - Could be added in the future using a custom text editor component

## Build Requirements

- Xcode 15 or later
- macOS 14.0 or later deployment target
- Swift 5.9

## Architecture

The app now uses SwiftUI's declarative UI framework with:

- `@main` app entry point
- `@StateObject` and `@Published` for state management
- `@EnvironmentObject` for sharing app state
- SwiftUI views instead of NSView subclasses
- Native SwiftUI controls (List, TextEditor, Button, etc.)

## Future Improvements

- Implement line numbers for the text editor using a custom component
- Add support for multiple inspector windows simultaneously (currently uses tabs)
- Improve keyboard shortcuts and accessibility
