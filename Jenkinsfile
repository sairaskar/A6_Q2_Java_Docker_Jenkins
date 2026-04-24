pipeline {
    agent any

    environment {
        // Keeping your specific data
        IMAGE_NAME = "sairaskar/a6-q2-java-docker-app"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo "Building the Java Docker image..."
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo "Running container to verify output..."
                    def output = sh(script: "docker run --rm $IMAGE_NAME", returnStdout: true).trim()
                    
                    echo "--- Container Output Start ---"
                    echo output
                    echo "--- Container Output End ---"

                    if (output.contains("Hello from Java inside Docker!")) {
                        echo "SUCCESS: Output verified!"
                    } else {
                        error "FAILURE: Unexpected output from container."
                    }
                }
            }
        }

        stage('Docker Hub Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'a6_q2_dockerhub_cred',
                    usernameVariable: ''DOCKER_USER',
                    passwordVariable: ''DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE_NAME'
            }
        }
    }

    post {
        always {
            echo "Cleaning up local images..."
            sh 'docker rmi $IMAGE_NAME || true'
        }
    }
}
