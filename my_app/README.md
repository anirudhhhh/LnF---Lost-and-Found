# LnF - Lost and Found App

A simple Flutter app for posting and finding lost items at IIT Patna.

## Features
- Google Sign-In
- Add lost/found items with images
- Search and filter items
- Delete your own posts

## Setup
1. Clone this repo
2. Run `cd my-app` inside the repository
3. Run `flutter pub get`
4. Add your Firebase config files:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`
5. Run `flutter run`

## Build APK
```bash
flutter build apk --release
```

## Tech Stack
- Flutter + Firebase (Auth + Firestore)

---
*Prototype for IIT Patna Lost & Found system*
