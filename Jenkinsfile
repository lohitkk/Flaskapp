pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/lohitkkk/flaskapp.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('flaskapp:latest')
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    sh 'docker run -d -p 5000:5000 flaskapp:latest'
                }
            }
        }
    }
}
