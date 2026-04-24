pipeline {
    agent any

    environment {
        IMAGE_NAME = "A6-Q2-java-docker-app"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo "Building the Java Docker image..."
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Run and Verify') {
            steps {
                script {
                    echo "Running container to verify output..."
                    // Run container, capture output, and remove it immediately (--rm)
                    def output = sh(script: "docker run --rm ${IMAGE_NAME}", returnStdout: true).trim()
                    
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
    }

    post {
        always {
            echo "Cleaning up local images..."
            sh "docker rmi ${IMAGE_NAME} || true"
        }
    }
}
