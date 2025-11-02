pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'lohit3799'              // ✅ Your Docker Hub username
        IMAGE_NAME = 'flaskapp'                    // ✅ Your repo name
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo '📦 Cloning the repository...'
                git branch: 'main', url: 'https://github.com/lohitkk/Flaskapp.git'
            }
        }

        stage('Docker Login + Build') {
            steps {
                script {
                    echo '🔐 Logging into Docker Hub before build...'
                    bat """
                    echo %DOCKERHUB_PASSWORD% | docker login -u %DOCKER_HUB_USER% --password-stdin
                    docker build -t %DOCKER_HUB_USER%/%IMAGE_NAME%:%IMAGE_TAG% .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo '🚀 Pushing Docker image to Docker Hub...'
                    bat "docker push %DOCKER_HUB_USER%/%IMAGE_NAME%:%IMAGE_TAG%"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            when {
                expression { return fileExists('deployment.yaml') }
            }
            steps {
                script {
                    echo '⚙️ Deploying to Kubernetes...'
                    bat """
                    kubectl apply -f deployment.yaml
                    kubectl rollout status deployment/flaskapp
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
