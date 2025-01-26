pipeline {
    agent any

    stages {
        stage('run') {
            steps {
                script {
                    sh 'docker compose up --build -d'
                }
            }
        }
    }
}
