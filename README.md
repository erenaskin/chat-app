# 💬 Flutter Real-time Chat Application

A modern real-time chat application built with **Flutter** and **Firebase**, featuring user authentication, profile management, instant messaging, media sharing, and online/offline user status tracking. The app follows **Material 3** design principles and provides a clean, responsive UI/UX.

---

## ✨ Features

* **User Authentication:** Sign up and log in using email and password.
* **Password Reset:** Easily reset your password via email.
* **Profile Management:** Update display name, status message, and profile picture.
* **Real-time Messaging:** Instant one-on-one chat using Firebase Firestore.
* **Media Messages:** Send images and GIFs from your device gallery.
* **Online/Offline Status:** See user presence and last seen timestamp.
* **Chat List:** Displays all available users to start conversations.
* **Modern UI/UX:** Clean Material 3 interface with Google Fonts (`Urbanist`).
* **Dark Mode:** Automatic theme switching based on the system preference.

---

## 🧯 Technologies Used

| Technology                  | Purpose                             |
| --------------------------- | ----------------------------------- |
| **Flutter**                 | Cross-platform mobile app framework |
| **Firebase Authentication** | Handles user registration & login   |
| **Firebase Firestore**      | Real-time chat data storage         |
| **Firebase Storage**        | Media and profile photo storage     |
| **Provider**                | State management                    |
| **Image Picker**            | Selecting media from the gallery    |
| **intl**                    | Date/time formatting                |
| **google_fonts**            | Custom fonts (Urbanist)             |

---

## 🛠️ Setup & Installation

Follow these steps to set up and run the project locally.

### ✅ Prerequisites

* [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
* [Firebase CLI](https://firebase.google.com/docs/cli) installed globally:

  ```bash
  npm install -g firebase-tools
  ```

---

### ⚙️ Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/flutter_chat_app.git
   cd flutter_chat_app
   ```

2. **Create a Firebase Project**

   * Go to the [Firebase Console](https://console.firebase.google.com/).
   * Create a **new project**.
   * Enable the following Firebase services:

     * **Authentication** → Enable **Email/Password** sign-in method.
     * **Firestore Database** → Start in **Test Mode** (for development).
     * **Cloud Storage** → Enable the default storage bucket.

3. **FlutterFire Configuration**
   In your Flutter project root directory, run:

   ```bash
   flutterfire configure
   ```

   This will automatically generate a `firebase_options.dart` file inside your project.

4. **Install Dependencies**

   ```bash
   flutter pub get
   ```

5. **Run the Application**

   ```bash
   flutter run
   ```

---

## 🚀 Usage Guide

1. **Launch the App** → You’ll see the **Login / Register** screen.
2. **Register or Login** → Create a new account or sign in using email and password.
3. **Home Screen (User List)** → Displays all registered users.
4. **Start Chatting** → Tap a user to open a private chat.
5. **Send Messages** → Type and send text, or tap the gallery icon to send images or GIFs.
6. **Profile Management** → Tap your profile icon to update your name, status, or photo.
7. **Password Reset** → Use the “Forgot Password?” link on the login screen.

---

## 🧩 Folder Structure

```
lib/
│
├── models/
│   ├── user_model.dart
│   ├── message_model.dart
│   └── chat_room_model.dart
│
├── services/
│   └── chat_service.dart
│
├── providers/
│   └── auth_provider.dart
│
├── screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── chat_screen.dart
│   ├── home_screen.dart
│   └── profile_screen.dart
│
└── main.dart
```

---

## 🌗 Theming

* Built with **Material 3** design system.
* Uses **Google Fonts (Urbanist)** for consistent typography.
* Supports **Dark/Light mode** automatically based on system preference.
