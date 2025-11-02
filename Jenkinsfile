pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-login')   // Jenkins credential ID for Docker Hub
        DOCKER_IMAGE = "lohitkk/flaskapp"                         // Replace with your Docker Hub repo
        KUBE_CONFIG = credentials('kubeconfig')                   // Jenkins credential ID for kubeconfig file
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/lohitkk/Flaskapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh 'docker build -t $DOCKER_IMAGE:latest .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    echo 'Logging into Docker Hub...'
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo 'Pushing Docker image...'
                    sh 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo 'Deploying to Kubernetes...'
                    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                        sh '''
                            kubectl --kubeconfig=$KUBECONFIG apply -f k8s-deployment.yaml
                            kubectl --kubeconfig=$KUBECONFIG apply -f k8s-service.yaml
                            kubectl --kubeconfig=$KUBECONFIG rollout status deployment flask-deployment
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
            echo '❌ Pipeline failed. Check the logs.'
        }
    }
}
