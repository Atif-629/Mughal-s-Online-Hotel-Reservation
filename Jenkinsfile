pipeline {
    agent any
    
    environment {
        COMPOSE_FILE = 'docker-compose-jenkins.yml'
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                echo 'Fetching code from GitHub...'
                checkout scm
            }
        }
        
        stage('Create .env File') {
            steps {
                echo 'Creating .env file in workspace...'
                sh '''
                    cat > .env << 'EOF'
ATLAS_DB_URL=mongodb+srv://ashar_fiaz012:earthandmoon210@cluster0.vhi4xgo.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
CLOUD_NAME=dun3y3vhe
CLOUD_API_KEY=167761484856692
CLOUD_API_SECRET=IQP7qWxPYStcIkpl3pPBFank5X4
MAP_TOKEN=pk.eyJ1IjoiYXNoYXItZmlhejAxMiIsImEiOiJjbWR4NmU1YzgxZmxwMm1xeThhcXgwYjRtIn0.rfRfQmbmz6XFB8h1VY40-w
SECRET=SNNDJSNJNSHDNWDNJDNDJN2JE22
EOF
                    echo "✅ .env file created successfully"
                    cat .env
                '''
            }
        }
        
        stage('Stop Previous Containers') {
            steps {
                echo 'Stopping any existing containers...'
                sh '''
                    docker compose -f ${COMPOSE_FILE} down || true
                '''
            }
        }
        
        stage('Build and Deploy') {
            steps {
                echo 'Starting application containers...'
                sh '''
                    docker compose -f ${COMPOSE_FILE} up -d
                '''
            }
        }
        
        stage('Verify Deployment') {
            steps {
                echo 'Verifying deployment...'
                sh '''
                    echo "Waiting for application to start..."
                    sleep 25
                    echo "Checking container status..."
                    docker ps
                    echo "Checking application logs..."
                    docker logs hotel-app-jenkins --tail 30 || echo "Container not ready yet"
                '''
            }
        }
        
        stage('Test Application') {
            steps {
                echo 'Testing if application responds...'
                sh '''
                    echo "Attempting to connect to application..."
                    for i in 1 2 3 4 5; do
                        echo "Attempt $i..."
                        if curl -f http://localhost:3001 2>/dev/null; then
                            echo "✅ Application is responding!"
                            break
                        else
                            echo "Waiting 5 seconds before retry..."
                            sleep 5
                        fi
                    done
                '''
            }
        }
    }
    
    post {
        success {
            echo '✅ ============================================='
            echo '✅ DEPLOYMENT SUCCESSFUL!'
            echo '✅ Application is running on port 3001'
            echo '✅ ============================================='
        }
        failure {
            echo '❌ ============================================='
            echo '❌ DEPLOYMENT FAILED!'
            echo '❌ Check logs below for errors'
            echo '❌ ============================================='
            sh 'docker logs hotel-app-jenkins --tail 100 || echo "No container logs available"'
            sh 'docker ps -a | grep jenkins || echo "No jenkins containers found"'
        }
        always {
            echo 'Build completed. Check results above.'
        }
    }
}
