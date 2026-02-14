# Tipper

Tip calculator app for iOS.

Created For: CodePath - iOS Development

## User Stories

### Required

- [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
- [x] User can select between tip percentages by tapping different values on the segmented control and the tip value is updated accordingly.

### Bonus

- [ ] UI animations.
- [x] Remembering the bill amount across app restarts (if <10mins).
- [ ] Using locale-specific currency and currency thousands separators.
- [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

### Additional

- [x] Settings menu to set the default tip percentages.
- [x] Allows you to choose the number of people to divide the bill by.

## Notes

A challenge I faced when setting up the app was preserving the tip settings across different uses. There were several small things to think about when implementing it. Such as setting defaults for the first time versus loading the previously saved values afterwards or opening the settings menu and leaving the inputs blank, or updating the segmented control to reflect the changed values.
