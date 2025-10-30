pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
               git branch: 'main', url: 'https://github.com/lohitkk/Flaskapp.git'

            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t lohitkk/flaskapp:latest .'
            }
        }
stage('Push to Docker Hub') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
            bat 'docker push lohitkk/flaskapp:latest'
        }
    }
}


        stage('Deploy to Kubernetes') {
            steps {
                bat '''
                kubectl apply -f k8s-deployment.yaml
                kubectl apply -f k8s-service.yaml
                '''
            }
        }
    }

    post {
        success {
            echo '🎉 Deployment Successful!'
        }
        failure {
            echo '❌ Build Failed!'
        }
    }
}
