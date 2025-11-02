pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('flaskapp')
                }
            }
        }

        stage('Run Tests') {
            steps {
                sh 'echo "Running tests..."'
            }
        }

        stage('Blue-Green Deployment') {
            steps {
                script {
                    // Deploy old version as "blue" and new as "green"
                    sh 'kubectl apply -f k8s/blue-deployment.yaml'
                    sh 'kubectl apply -f k8s/green-deployment.yaml'

                    // Switch traffic to green
                    sh 'kubectl apply -f k8s/service-green.yaml'
                }
            }
        }
    }
}
