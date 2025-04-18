# Docker Web App
## Youcef Islam CHEHBOUB & Soufiane ALAEDDINE

This project demonstrates how to set up a web application using Docker. You can run the project in two ways: using a `Makefile` or using Docker Compose.

## Part 1: Running with the Makefile

1. Ensure Docker is installed and running on your system.
2. Open a terminal.
3. Navigate to the project directory:
   ```cmd
   cd docker-web-app
   ```
4. Use the following `make` commands:
   - Start the containers:
     ```cmd
     make manual-up
     ```
   - Test the application:
     ```cmd
     make manual-test
     ```
   - Stop and clean up the containers:
     ```cmd
     make manual-down
     ```
5. Verify that the containers are running:
   ```cmd
   docker ps
   ```

## Part 2: Running with Docker Compose

1. Ensure Docker Compose is installed and running on your system.
2. Open a terminal.
3. Navigate to the project directory:
   ```cmd
   cd docker-web-app
   ```
4. Use the following `make` commands:
   - Start the containers:
     ```cmd
     make compose-up
     ```
   - Test the application:
     ```cmd
     make compose-test
     ```
   - Stop and clean up the containers:
     ```cmd
     make compose-down
     ```
5. Verify that the containers are running:
   ```cmd
   docker ps
   ```

## Accessing the Application

- The application should be accessible via the configured ports:
  - MySQL: `localhost:5655`
  - Nginx: `localhost:5423`
