<p align="center">
    <img src="https://user-images.githubusercontent.com/62269745/174906065-7bb63e14-879a-4740-849c-0821697aeec2.png#gh-light-mode-only" width="40%">
    <img src="https://user-images.githubusercontent.com/62269745/174906068-aad23112-20fe-4ec8-877f-3ee1d9ec0a69.png#gh-dark-mode-only" width="40%">
</p>

# Full-Stack Todo List Application

This repository hosts a full-stack Todo List application designed to allow users to create, manage, and organize their tasks efficiently. The application features a React-based frontend and a Node.js backend, utilizing MongoDB for data persistence.

## Technologies Used

- **Frontend**: React, Material-UI
- **Backend**: Node.js, Express
- **Database**: MongoDB
- **Other Tools**: Vite, React Toastify, Lucide Icons

## Project Structure

The project is divided into three main parts:
- **Frontend**: Located in the `frontend/` directory with its own [README](frontend/README.md).
- **Backend**: Located in the `backend/` directory with its own [README](backend/README.md).

- **Infrastructure**: Located in the `infrastructure/` directory with its own [README](infrastructure/README.md).

# DevOps Project

## Project Structure
```

devops-project/
├── Frontend/
├── Backend/
└── infrastructure/
    ├── versions.tf
    ├── .gitignore
    └── README.md
```

## Components
- Frontend: React application
- Backend: Node.js API
- Infrastructure: AWS resources managed with Terraform, Docker Compose, and Ansible

## Getting Started
1. Set up infrastructure:
   ```bash
   cd infrastructure
   terraform init
   terraform apply
   ```

2. Deploy backend:
   ```bash
   cd Backend
   npm install
   npm start
   ```

3. Deploy frontend:
   ```bash
   cd Frontend
   npm install
   npm start
   ```

## Features

- Create, view, update, and delete todo items.
- Organize tasks with tags/categories.
- Responsive user interface adaptable to different screen sizes.
- Real-time updates without page reloads.

## Contributing

Contributions are welcome! See the specific README files in the `frontend/` and `backend/` directories for more details on contributing.

## Live Demo

<h4 align="left">Live Preview is available at https://fullstack-todolist-1.onrender.com/</h4>

## Snapshots

<img src="./Frontend/src/assets/home-snapshot.png" alt="home page"/>
