pipeline {
    agent any
    
    environment {
        DOCKER_HOST = 'unix:///var/run/docker.sock'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                url: 'https://github.com/Atif-629/Mughal-s-Online-Hotel-Reservation.git'
            }
        }
        
        stage('Load Environment') {
            steps {
                script {
                    // Load environment variables from file
                    loadEnvironmentFile('.env.jenkins')
                }
            }
        }
        
        stage('Stop Existing Containers') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose-jenkins.yml down || true'
                }
            }
        }
        
        stage('Build and Run Containers') {
            steps {
                script {
                    sh '''
                        export $(cat .env.jenkins | xargs)
                        docker-compose -f docker-compose-jenkins.yml up --build -d
                    '''
                }
            }
        }
        
        stage('Health Check') {
            steps {
                script {
                    sleep time: 15, unit: 'SECONDS'
                    sh '''
                        echo "Checking if application is running..."
                        curl -f http://localhost:3001/ || exit 1
                        echo "Application is running successfully on port 3001"
                    '''
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline execution completed'
            sh 'docker-compose -f docker-compose-jenkins.yml ps'
        }
        failure {
            echo 'Pipeline failed - stopping containers'
            sh 'docker-compose -f docker-compose-jenkins.yml down'
        }
    }
}

// Function to load environment file
def loadEnvironmentFile(String filePath) {
    def envVars = readFile(filePath).split('\n')
    for (envVar in envVars) {
        if (envVar.trim() && !envVar.trim().startsWith('#')) {
            def keyValue = envVar.split('=', 2)
            if (keyValue.size() == 2) {
                env[keyValue[0].trim()] = keyValue[1].trim()
            }
        }
    }
}
               
