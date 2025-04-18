# Docker Web App
## Authors: Youcef Islam CHEHBOUB & Soufiane ALAEDDINE

This project demonstrates how to set up and run a web application using Docker.

## Cloning the Repository

To get started, clone the repository:

```bash
git clone https://github.com/youcisla/DockerTP.git
```

Navigate to the project directory:

```bash
cd docker-web-app
```

## Project Structure

The project is organized as follows:

```
docker-web-app/
├── .env
├── compose.yaml
├── Makefile
├── setup_manual.ps1
├── app/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── src/
│       └── app.py
├── mysql/
│   ├── Dockerfile
│   └── init.sql
└── nginx/
    ├── Dockerfile
    └── conf/
        └── nginx.conf
```

- `.env`: Contains environment variables for the project.
- `compose.yaml`: Defines services and their configurations for Docker Compose.
- `Makefile`: Includes commands to manage the project.
- `setup_manual.ps1`: PowerShell script for manual setup.
- `app/`: Contains the application code, dependencies, and its Dockerfile.
- `mysql/`: Contains the MySQL Dockerfile and initialization script.
- `nginx/`: Contains the Nginx Dockerfile and configuration files.

## Running the Project

### Part 1: Using the Makefile

1. Ensure Docker is installed and running.
2. Open a terminal and navigate to the project directory:
   ```bash
   cd docker-web-app
   ```
3. Use the following `make` commands:
   - Start the containers:
     ```bash
     make manual-up
     ```
   - Test the application:
     ```bash
     make manual-test
     ```
   - Stop and clean up the containers:
     ```bash
     make manual-down
     ```
4. Verify that the containers are running:
   ```bash
   docker ps
   ```

### Part 2: Using Docker Compose

1. Ensure Docker Compose is installed and running.
2. Open a terminal and navigate to the project directory:
   ```bash
   cd docker-web-app
   ```
3. Use the following `make` commands:
   - Start the containers:
     ```bash
     make compose-up
     ```
   - Test the application:
     ```bash
     make compose-test
     ```
   - Stop and clean up the containers:
     ```bash
     make compose-down
     ```
4. Verify that the containers are running:
   ```bash
   docker ps
   ```

## Accessing the Application

The application should be accessible via the following ports:
- MySQL: `localhost:5655`
- Nginx: `localhost:5423`
