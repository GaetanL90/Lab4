# Posts Manager – Flutter Lab 4

Simple Flutter app that consumes the JSONPlaceholder API to let staff **view, create, edit and delete posts**.  
This project was built for *INDIVIDUAL Flutter Lab 4: Consuming APIs in Flutter*.

---

## Features

- **Login simulation**
  - Simple login screen where you choose a user (e.g. `User #1`–`User #10`).
  - All new posts are created under the selected user id.

- **Posts list (from API)**
  - Fetches posts from `https://jsonplaceholder.typicode.com/posts` using the `http` package.
  - Displays posts in modern **cards** showing title, body preview and `User #id`.
  - Pull‑to‑refresh to reload data.

- **Post details**
  - Tapping a card opens a details screen with full title and body.

- **Create / Edit / Delete**
  - Create a new post with title and body.
  - Edit an existing post.
  - Delete a post with confirmation dialog.
  - JSONPlaceholder is a fake API, so changes are local and are not persisted on the server after reload.

- **Error handling**
  - Network and HTTP errors (e.g. 403) are caught and shown in the UI with a Retry button.
  - When the API is blocked, the app can fall back to local sample posts so the UI still works.

---

## Tech Stack & Dependencies

- **Flutter SDK + Material** – UI, navigation and theming.
- **`http`** – REST calls to JSONPlaceholder (`GET`, `POST`, `PUT`, `DELETE`).
- **`flutter_launcher_icons`** – Generates the custom launcher icon from `posts_manager/Assets/logo.png`.

---

## Screenshots

> Replace the image paths below with the actual file names you saved in `posts_manager/Assets/`.

- **App icon & splash**

  ![App icon](posts_manager/Assets/logo.png)

- **Login screen (select user)**

  `![Login screen](posts_manager/Assets/Login.jpeg)`

- **Posts list with cards**

  `![Posts list](posts_manager/Assets/Retrieval.jpeg)`

- **Post details**

  `![Post details](posts_manager/Assets/Post_Details.jpeg)`

- **Create post**

  `![Create post](posts_manager/Assets/Creating.jpeg)`

- **Edit post**

  `![Edit post](posts_manager/Assets/Editing.jpeg)`

- **Error / offline state**

  `![Error state](posts_manager/Assets/Offline_state.jpeg)`

---

## Running the Project

```bash
cd posts_manager
flutter pub get
flutter run -d <DEVICE_ID>
```

Use the login screen to pick a user id, then manage posts from the main Posts Manager screen. 
