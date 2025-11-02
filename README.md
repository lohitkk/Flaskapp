# Flask CI/CD Pipeline using Jenkins, Docker, and Kubernetes

This project demonstrates a simple Flask app automated using Jenkins CI/CD pipeline.

## Pipeline Steps
1. Clone from GitHub
2. Build Docker image
3. Push image to Docker Hub
4. Deploy to Kubernetes cluster

## Commands for local testing
```bash
docker build -t lohitkk/flaskapp .
docker run -p 5000:5000 lohitkk/flaskapp
