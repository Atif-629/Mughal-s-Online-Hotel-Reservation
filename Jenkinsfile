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
                        # Stop and remove any containers that might be running
                        docker-compose -f docker-compose-jenkins.yml down || true
                        
                        # Additional cleanup for any orphaned containers
                        docker stop mughal-hotel-app-jenkins mughal-mongodb-jenkins 2>/dev/null || true
                        docker rm mughal-hotel-app-jenkins mughal-mongodb-jenkins 2>/dev/null || true
                        
                        # Wait a moment for any prune operations to complete
                        sleep 5
                    '''
                }
            }
        }
        
        stage('Build and Run Containers') {
            steps {
                script {
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
                        # Try multiple times with backoff
                        for i in {1..10}; do
                            if curl -f http://localhost:3001/; then
                                echo "Application is running successfully on port 3001"
                                exit 0
                            fi
                            sleep 5
                        done
                        echo "Application failed to start"
                        exit 1
                    '''
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline execution completed'
            sh 'docker-compose -f docker-compose-jenkins.yml ps || true'
        }
        failure {
            echo 'Pipeline failed'
            sh 'docker-compose -f docker-compose-jenkins.yml down || true'
        }
    }
}
               
