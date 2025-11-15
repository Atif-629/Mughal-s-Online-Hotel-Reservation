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
        
        stage('Stop Existing Containers') {
            steps {
                 script {
                    sh '''
                        # Force stop and remove any containers with our names
                        docker stop mughal-hotel-app-jenkins || true
                        docker stop mughal-mongodb-jenkins || true
                        docker rm mughal-hotel-app-jenkins || true
                        docker rm mughal-mongodb-jenkins || true
                        
                        # Remove any orphaned networks
                        docker network prune -f
                        
                        # Then run docker-compose down
                        docker-compose -f docker-compose-jenkins.yml down || true
                    '''
                }
            }
        }
        
        stage('Build and Run Containers') {
            steps {
                script {
                    // Copy environment file and run with env variables
                    sh '''
                        cp .env.jenkins .env
                        docker-compose -f docker-compose-jenkins.yml up --build -d
                    '''
                }
            }
        }
        
        stage('Health Check') {
            steps {
                script {
                    sleep time: 20, unit: 'SECONDS'
                    sh '''
                        echo "Waiting for application to start..."
                        # Try multiple times with timeout
                        timeout 60s bash -c 'until curl -f http://localhost:3001/; do sleep 5; done'
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
               
