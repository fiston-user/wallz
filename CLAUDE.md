# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application called "wallz" built with Flutter 3.35.2 and Dart 3.9.0. The project follows standard Flutter project structure with platform-specific directories for Android, iOS, Linux, macOS, Windows, and Web.

## Commands

### Development
- `flutter run` - Run the app on connected device/emulator
- `flutter run -d chrome` - Run the app in Chrome browser
- `flutter run -d macos` - Run the app on macOS
- `flutter run -d ios` - Run the app on iOS simulator

### Building
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app (requires macOS with Xcode)
- `flutter build web` - Build for web deployment
- `flutter build macos` - Build macOS desktop app
- `flutter build windows` - Build Windows desktop app
- `flutter build linux` - Build Linux desktop app

### Testing
- `flutter test` - Run all tests
- `flutter test test/widget_test.dart` - Run specific test file

### Analysis & Formatting
- `flutter analyze` - Analyze code for issues
- `dart format .` - Format all Dart files
- `dart fix --apply` - Apply available fixes

### Dependencies
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies
- `flutter pub outdated` - Check for outdated packages

## Project Structure

The application follows Flutter's standard structure:
- `lib/main.dart` - Application entry point containing MyApp and MyHomePage widgets
- `test/` - Widget and unit tests
- `pubspec.yaml` - Package configuration and dependencies
- Platform-specific directories (`android/`, `ios/`, `web/`, etc.) for native code

## Code Standards

The project uses `flutter_lints` package for enforcing Flutter best practices. Lint rules are configured in `analysis_options.yaml`.

## Current Dependencies

- flutter SDK
- cupertino_icons: ^1.0.8
- flutter_lints: ^5.0.0 (dev dependency)

## Development Notes

The project currently contains the default Flutter counter app template. When developing:
- Hot reload works with `r` in terminal or save in IDE
- Hot restart with `R` for stateful changes
- The app uses Material Design with a purple color scheme by default