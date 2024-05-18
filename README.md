# AI Image Generation Project

This project consists of a Flutter frontend and a Flask backend for generating images based on user input using an AI model.The Flask application is hosted on AWS EC2 instance.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Sample Images](#sample-images)
- [Project Structure](#project-structure)
- [Backend Setup](#backend-setup)
  - [Docker](#docker)
  - [Running the Backend](#running-the-backend)
- [Frontend Setup](#frontend-setup)
  - [Running the Frontend](#running-the-frontend)
- [Usage](#usage)
  

## Prerequisites

- Docker
- Flutter SDK

## Sample Images

![Dog-1](https://github.com/amith0206/AI_Image_Generator/blob/main/asset/dog-1.png)
![Dog-2](https://github.com/amith0206/AI_Image_Generator/blob/main/asset/dog-2.png)
![Zeus](https://github.com/amith0206/AI_Image_Generator/blob/main/asset/zeus.png)

## Project Structure
ai-image-generator/ <br>
├── backend/ <br>
│ ├── Dockerfile <br>
│ ├── app.py <br>
│ ├── requirements.txt <br>
│ ├── docker-download-and-configure.sh <br>
├── frontend/ <br>
│ ├── android/ <br>
│ │ └── app/ <br>
│ │ └── src/ <br>
│ │ └── main/ <br>
│ │ └── AndroidManifest.xml <br>
│ ├── assets/ <br>
│ │ └── icon/ <br>
│ │ └── logo.png <br>
│ ├── lib/ <br>
│ │ └── main.dart <br> 
│ ├── pubspec.yaml <br>
├── README.md


## Backend Setup

### Docker

1. **Install Docker**: Follow the steps in `docker-download-and-configure.sh` to install Docker on your system.

### Running the Backend

1. **Navigate to the backend directory**:
    ```sh
    cd backend
    ```

2. **Build the Docker image**:
    ```sh
    docker build -t ai-image-generator-backend .
    ```

3. **Run the Docker container**:
    ```sh
    docker run -d -p 8080:8080 ai-image-generator-backend
    ```

## Frontend Setup

### Running the Frontend

1. **Navigate to the frontend directory**:
    ```sh
    cd frontend
    ```

2. **Get the dependencies**:
    ```sh
    flutter pub get
    ```

3. **Run the Flutter app**:
    ```sh
    flutter run
    ```

## Usage

1. Open the app on your device/emulator.
2. Enter a text prompt in the input field.
3. Click the "Click to generate" button.
4. Wait for the AI to generate the image and display it on the screen.





