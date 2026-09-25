# Lughati

**Lughati** is a full-stack language learning mobile application built with **Flutter, Node.js, Express.js, and MongoDB**.

The project was developed to apply practical software development concepts across the **mobile application, backend, database, containerization, and CI/CD** layers.

## 🎯 Project Overview

Lughati follows a client-server architecture where the Flutter mobile application communicates with a RESTful backend built with Node.js and Express.js.

The project demonstrates my ability to work across multiple layers of a software application, from building the mobile interface to developing backend APIs, integrating a database, containerizing the backend, and automating the development workflow with GitHub Actions.

## 🧩 Key Capabilities

* Developed a cross-platform mobile application using **Flutter & Dart**
* Built a RESTful backend using **Node.js & Express.js**
* Integrated **MongoDB** for application data persistence
* Connected the mobile application with the backend through APIs
* Used **Mongoose** for MongoDB data modeling and interaction
* Containerized the backend using **Docker**
* Implemented a **GitHub Actions CI/CD workflow**
* Structured the project into separate mobile and backend components
* Managed the project using **Git & GitHub**

## 🏗️ Architecture

```text
                    Lughati
                       │
                       ▼
        ┌─────────────────────────┐
        │     Flutter Mobile      │
        │       Application       │
        └────────────┬────────────┘
                     │
                     │ REST API
                     ▼
        ┌─────────────────────────┐
        │     Node.js + Express   │
        │         Backend         │
        └────────────┬────────────┘
                     │
                     │ Mongoose
                     ▼
        ┌─────────────────────────┐
        │         MongoDB         │
        │         Database        │
        └─────────────────────────┘

              Docker + CI/CD
```

## 🛠️ Technology Stack

| Area            | Technologies           |
| --------------- | ---------------------- |
| Mobile          | Flutter, Dart          |
| Backend         | Node.js, Express.js    |
| Database        | MongoDB, Mongoose      |
| API             | REST API               |
| DevOps          | Docker, GitHub Actions |
| Version Control | Git, GitHub            |

## 📂 Project Structure

```text
lughati/
│
├── lib/                       # Flutter application
├── assets/                    # Application assets
│
├── backend/                   # Node.js / Express backend
│
├── .github/
│   └── workflows/             # GitHub Actions workflows
│
├── Dockerfile                 # Backend container configuration
├── pubspec.yaml               # Flutter dependencies
└── README.md
```

## ⚙️ Getting Started

### Prerequisites

* Flutter SDK
* Dart SDK
* Node.js
* MongoDB
* Docker

### Clone the repository

```bash
git clone https://github.com/Moathhazeem/lughati.git
cd lughati
```

### Run the Flutter application

```bash
flutter pub get
flutter run
```

### Run the backend

```bash
cd backend
npm install
npm start
```

Configure the required environment variables in a `.env` file before starting the backend.

### Run the backend with Docker

```bash
docker build -t lughati-backend .
docker run -p 5000:5000 lughati-backend
```

## 🔄 CI/CD

The project includes a **GitHub Actions workflow** to automate parts of the development process.

This demonstrates practical experience with:

* Continuous Integration
* Automated workflows
* Build and validation processes
* GitHub Actions

## 🐳 Containerization

The backend is containerized using **Docker**, providing a consistent environment for running the server and simplifying the process of moving the application between development environments.

## 💡 What This Project Demonstrates

Through Lughati, I practiced and applied:

* **Mobile Development** — building applications with Flutter
* **Backend Development** — designing and implementing APIs with Node.js and Express
* **Database Development** — working with MongoDB and Mongoose
* **API Integration** — connecting a mobile client with a backend service
* **DevOps Fundamentals** — Docker and CI/CD
* **Software Development Workflow** — Git, GitHub, and automated workflows

## 🔮 Future Improvements

* Expand language-learning functionality
* Improve learning progress and user experience
* Add more automated tests
* Extend the CI/CD pipeline
* Deploy the application and backend to a production environment

## 👨‍💻 Author

**Moath Hazeem**

MIS Student | Full-Stack Developer

[GitHub](https://github.com/Moathhazeem)

---

⭐ This project is part of my software development portfolio.
