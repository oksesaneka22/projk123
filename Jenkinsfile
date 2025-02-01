pipeline {
    agent any

    stages {
        stage('run') {
            steps {
                script {
                    //sh 'docker compose down'
                    sh 'ls'
                    sh 'docker compose up --build -d'
                    sh 'sleep 10'
                    sh 'docker restart site123-backend-1'
                }
            }
        }
    }
}
