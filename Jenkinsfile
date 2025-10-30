pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-login')
        IMAGE_NAME = 'lohit3799/flaskapp:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/lohitkk/Flaskapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat """
                    docker build -t ${IMAGE_NAME} .
                """
            }
        }

        stage('Push to Docker Hub') {
            steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-login', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
    bat """
        docker login -u %DOCKER_USER% -p %DOCKER_PASS%
        docker push lohit3799/flaskapp:latest
    """
}

            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat """
                    kubectl config use-context minikube
                    kubectl apply -f k8s-deployment.yaml
                    kubectl apply -f k8s-service.yaml
                """
            }
        }
    }

    post {
        success {
            echo '✅ Build and Deployment Successful!'
        }
        failure {
            echo '❌ Build Failed!'
        }
    }
}
