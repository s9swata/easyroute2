# Implementation Plan - App Audit and Fixes

Audit of the EasyRoute app revealed several non-functional buttons and navigation missing between screens. This plan outlines the fixes to ensure all primary "functions" (navigation and basic interactions) work as expected.

## User Review Required

> [!IMPORTANT]
> Some screens (`ProfileScreen`, `CreateRosterScreen`) currently use `StatelessWidget` despite having interactive elements like TextFields and Toggle buttons. To make these "work" properly, I'll need to refactor them into `StatefulWidget`s. This is a standard Flutter practice for interactive screens but involves changing the class structure.

## Audit Findings (Non-Functional Areas)

### Navigation Gaps
- **HomeScreen**: "View Stats" action tile has no `onTap`.
- **HomeScreen**: Top header icons (History, Settings) are static icons.
- **StatsScreen**: App bar "Back" icon is static; it doesn't navigate back.
- **CreateRosterScreen**: "Save Roster" button has an empty `onTap`.

### Incomplete Interactions
- **HomeScreen**: AI Textbox "Send" button has no logic.
- **StatsScreen**: "EXPORT" button is a static container.
- **ProfileScreen**: "Save Changes" button does not save anything.
- **ProfileScreen**: TextFields use `TextEditingController` inside a `StatelessWidget`'s `build` method (memory leak and state loss).

## Proposed Changes

### [MODIFY] [home_screen.dart](file:////Users/s4swata/cwo/easyroute2/lib/home_screen.dart)
- [x] Wrap "View Stats" tile in `GestureDetector` to navigate to `StatsScreen`.
- [ ] Connect History and Settings icons to appropriate screens or show feedback.

### [MODIFY] [stats_screen.dart](file:////Users/s4swata/cwo/easyroute2/lib/stats_screen.dart)
- [x] Convert "Back" icon to `IconButton` for functional navigation.
- [ ] Add Snackbar feedback for "EXPORT" button.

### [MODIFY] [create_roster_screen.dart](file:////Users/s4swata/cwo/easyroute2/lib/create_roster_screen.dart)
- [ ] Convert some logic to `StatefulWidget` to allow selection (Login/Logout/Both).
- [x] Add logic to "Save Roster" button to pop back with confirmation.

### [MODIFY] [profile_screen.dart](file:////Users/s4swata/cwo/easyroute2/lib/profile_screen.dart)
- [ ] Refactor to `StatefulWidget` for proper state management and interactivity.

## Open Questions
1. Should "History" and "Settings" navigate to separate screens or just show a snackbar for now?
2. Do you want me to implement full state toggling for "Trip Direction" and "Weekly Offs" on the Create Roster screen?

## Verification Plan
- Run `flutter analyze` and `flutter test`.
- Verify all links and buttons now provide user feedback or navigate correctly.
