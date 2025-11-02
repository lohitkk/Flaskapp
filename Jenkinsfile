pipeline {
    agent any

    environment {
        // Jenkins credential IDs
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')   // Docker Hub login credentials
        KUBE_CONFIG = credentials('kubeconfig')                        // Kubeconfig file credential
        DOCKER_IMAGE = "lohitkk/flaskapp"                              // Your Docker Hub repo name
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo '📥 Cloning the repository...'
                git branch: 'main', url: 'https://github.com/lohitkk/Flaskapp.git'
            }
        }

     stage('Docker Login + Build') {
    steps {
        script {
            echo '🔐 Logging into Docker Hub before build...'
            bat "echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin"
            echo '🐳 Building Docker image...'
            bat "docker build -t %DOCKER_IMAGE%:latest ."
        }
    }
}


        stage('Login to Docker Hub') {
            steps {
                script {
                    echo '🔐 Logging into Docker Hub...'
                    bat "echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo '🚀 Pushing Docker image to Docker Hub...'
                    bat "docker push %DOCKER_IMAGE%:latest"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo '⚙️ Deploying to Kubernetes cluster...'
                    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                        bat '''
                        kubectl --kubeconfig=%KUBECONFIG% apply -f k8s-deployment.yaml
                        kubectl --kubeconfig=%KUBECONFIG% apply -f k8s-service.yaml
                        kubectl --kubeconfig=%KUBECONFIG% rollout status deployment flask-deployment
                        '''
                    }
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
