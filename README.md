# Docker Web App

This project demonstrates how to set up a web application using Docker. You can run the project in two ways: using a manual setup script or using Docker Compose.

## Part 1: Running with the Manual Script

1. Ensure Docker is installed and running on your system.
2. Open a terminal or PowerShell.
3. Navigate to the project directory:
   ```powershell
   cd docker-web-app
   ```
4. Run the setup script:
   ```powershell
   .\setup_manual.ps1
   ```
5. Verify that the containers are running:
   ```powershell
   docker ps
   ```

## Part 2: Running with Docker Compose

1. Ensure Docker Compose is installed and running on your system.
2. Open a terminal or PowerShell.
3. Navigate to the project directory:
   ```powershell
   cd docker-web-app
   ```
4. Run Docker Compose:
   ```powershell
   docker-compose up -d
   ```
5. Verify that the containers are running:
   ```powershell
   docker ps
   ```

## Accessing the Application

- The application should be accessible via the configured ports:
  - MySQL: `localhost:5655`
  - Nginx: `localhost:5423`
