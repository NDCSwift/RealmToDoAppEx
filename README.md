# ✅ Realm To-Do App
A SwiftUI to-do list app using Realm as the local database — fast, reactive persistence with zero boilerplate.

---

## 🤔 What this is
This project demonstrates how to use the Realm Swift SDK to persist to-do items locally in a SwiftUI app. It covers creating Realm object models, writing and deleting objects, and observing Realm collections so the UI updates automatically. A practical alternative to Core Data for local persistence in SwiftUI.

## ✅ Why you'd use it
- **Realm persistence** — Shows how to define `Object` subclasses, open a Realm, and write/delete records
- **Reactive UI updates** — Demonstrates using `@ObservedResults` to automatically refresh SwiftUI views when Realm data changes
- **CRUD operations** — Covers the full lifecycle: create a task, mark it complete, and delete it from Realm

## 📺 Watch on YouTube
[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/TbSw8E8vgcM)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@noahdoescoding).

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/RealmToDoAppEx.git
cd RealmToDoAppEx
```

### 2. Open in Xcode
Double-click `RealmToDoAppEx.xcodeproj`.

### 3. Add Realm via Swift Package Manager
In Xcode: **File → Add Package Dependencies** → `https://github.com/realm/realm-swift` → add `RealmSwift`.

### 4. Set Your Development Team
In Xcode: **TARGET → Signing & Capabilities → Team** — select your team.

### 5. Update the Bundle Identifier
Change `com.example.MyApp` to a unique reverse-domain ID.

## 🛠️ Notes
- Realm must be added via SPM before the project will build (see step 3).
- If you see a code signing error, verify Team and Bundle ID are set.

## 📦 Requirements
- Xcode 15+
- iOS 16+
- Realm Swift (via SPM)

📺 [Watch the guide on YouTube](https://youtu.be/TbSw8E8vgcM)
