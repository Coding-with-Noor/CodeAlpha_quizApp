# CodeAlpha_quizApp

# Quiz App

A cross-platform Flutter application designed to create, organize, and practice flashcards across various custom categories. Built with local data persistence using SQLite (`sqflite`), this app provides a fast, offline-first study experience.

---

##  Features

**Category Management:** 

Create, view, edit, and delete flashcard categories with custom title and image paths.

**Interactive Flashcards:** 

Add, edit, and manage flashcards (questions and answers) assigned to specific categories.

**Local Persistence:**

Powered by SQLite with `PRAGMA foreign_keys = ON` and `CASCADE` deletion—deleting a category automatically deletes all associated flashcards.

**Custom UI Components:**

Built using custom dialogs, avatars, and custom typography (Poppins) for an aesthetic user experience.

---


##  Project Structure


lib/

├── Database/

│   └── SQLiteDBHelper.dart       # Local database helper & CRUD operations

├── Dialogs/

│   ├── add_card_dialog.dart      # Dialog modal to create flashcards

│   └── add_category_dialog.dart  # Dialog modal to create categories

├── Screens/

├── CardScreen.dart               # Displays flashcards inside a selected category

├── CategoryAvatar.dart           # UI avatar component for category image icons

├── EditCardScreen.dart           # Screen for editing individual flashcards

├── EditCategoryScreen.dart       # Screen for editing category details

├── FlashCard.dart                # Flashcard data model

├── FlashCardCategory.dart        # Category data model

├── FlashCardWidget.dart          # Reusable flashcard UI widget

├── HomeScreen.dart               # Main dashboard showing categories list

├── SplashScreen.dart             # Animated initial splash screen

└── main.dart                     # App entry point


**Getting Started**

**Prerequisites**

Ensure you have the following installed:

Flutter SDK

Android Studio / VS Code with Dart & Flutter extensions

Android emulator or physical device

**Installation & Setup**

Install dependencies:

flutter pub get


Run the app:

flutter run
