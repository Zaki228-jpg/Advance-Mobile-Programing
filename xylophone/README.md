# Xylophone Tik-Tok Flutter App

This app uses the supplied xylophone image as the UI. Tap any colored wooden bar and it plays a short xylophone-like "tik" sound.

## 1. Create/open the project

If you already have Flutter installed, open this folder in VS Code or Android Studio.

## 2. Install packages

```bash
flutter pub get
```

## 3. Run

```bash
flutter run
```

## 4. Important files

- `lib/main.dart` — app code and tap areas
- `assets/images/xylophone.jpg` — supplied image
- `assets/audio/note_1.wav` ... `note_8.wav` — generated sounds
- `pubspec.yaml` — Flutter + audioplayers dependency

The hit boxes are transparent and positioned over the colored bars, so the original image remains unchanged.

The app uses `audioplayers` for local asset playback.
