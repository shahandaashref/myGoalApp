# 🎯 Goal Tracker & Habit Builder

A clean, modern, and efficient Flutter application designed to help users track their daily goals, build healthy habits, and monitor their progress with insightful statistics.

Built with **Flutter** and powered by **SQLite** for offline data persistence.

## 📱 Screenshots

| Home Screen | Add Goal | Statistics |
|:---:|:---:|:---:|
| <img src="![alt text](image-2.png)" width="200"> | <img src="![alt text](image-1.png)" width="200"> | <img src="![alt text](image.png)" width="200"> |

## ✨ Features

* **Goal Management:** Add, edit, and delete daily goals easily.
* **Progress Tracking:** Visual circular progress indicator showing daily completion rate.
* **Weekly Overview:** A horizontal calendar strip to navigate through the week.
* **Smart Stats:** View current streak, best streak, and total active days.
* **Offline Storage:** All data is saved locally using **SQLite**, ensuring data privacy and offline access.
* **Interactive UI:** animated checkboxes, strikethrough effects, and clean transitions.
* **Responsive Design:** Adapts to different screen sizes.

## 🛠️ Tech Stack & Packages

* **Framework:** Flutter (Dart)
* **State Management:** `setState` (Clean Architecture approach)
* **Local Database:** `sqflite` + `path`
* **UI Components:**
    * `percent_indicator`: For the daily progress circle.
    * `intl`: For date formatting and calendar logic.
    * `fl_chart` (Planned): For weekly consistency graphs.

## 🚀 How to Run

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/shahandaashref/goal-tracker-app.git](https://github.com/shahandaashref/goal-tracker-app.git)
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd goal-tracker-app
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

## 📂 Project Structure