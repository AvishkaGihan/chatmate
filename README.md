# ChatMate

ChatMate is a modern, cross-platform chat application built with Flutter and powered by Firebase. It provides a seamless messaging experience with user authentication, real-time chat, and profile management features.

## Features

- **User Authentication**: Secure sign-in and sign-up using Firebase Authentication
- **Real-time Chat**: Instant messaging with real-time updates
- **Profile Management**: Customize your user profile
- **Cross-Platform**: Runs on Android, iOS, Web, Windows, macOS, and Linux
- **Firebase Integration**: Leverages Firebase for backend services

## Screenshots

_(Add screenshots here if available)_

## Installation

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart SDK
- Firebase account and project setup

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AvishkaGihan/chatmate.git
   cd chatmate
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup:**

   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication and Firestore
   - Download the `google-services.json` file for Android and place it in `android/app/`
   - For iOS, configure the iOS app in Firebase and add the GoogleService-Info.plist
   - Update `lib/firebase_options.dart` with your Firebase configuration

4. **Run the app:**
   ```bash
   flutter run
   ```

## Usage

1. Launch the app on your device or emulator
2. Sign up or log in with your credentials
3. Start chatting with other users
4. Manage your profile in the settings

## Project Structure

```
lib/
├── app/
│   ├── app.dart          # Main app widget
│   └── routes.dart       # App routing
├── core/
│   ├── constants/        # App constants
│   ├── errors/           # Error handling
│   ├── theme/            # App theming
│   └── utils/            # Utility functions
├── data/
│   ├── models/           # Data models
│   ├── repositories/     # Data repositories
│   └── services/         # External services
├── features/
│   ├── auth/             # Authentication feature
│   ├── chat/             # Chat feature
│   └── profile/          # Profile feature
└── shared/
    └── widgets/          # Shared UI widgets
```

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please ensure your code follows the existing style and includes appropriate tests.

## Testing

Run the tests with:

```bash
flutter test
```

## Building for Production

### Android

```bash
flutter build apk
```

### iOS

```bash
flutter build ios
```

### Web

```bash
flutter build web
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- Powered by [Firebase](https://firebase.google.com/)
- Icons and assets used in accordance with their respective licenses

## Contact

For questions or support, please open an issue on GitHub.
