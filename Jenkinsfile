pipeline {
    agent any

    environment {
        IMAGE_NAME = "omkar797283/portfolio"
        IMAGE_TAG = "latest"
        DOCKER_HUB_CRED = "dockerhub-cred"
        CONTAINER_NAME = "portfolio-site"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/omkar2203030/Example_demo_1'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CRED,
                                                     usernameVariable: 'USER',
                                                     passwordVariable: 'PASS')]) {
                        sh """
                        echo "$PASS" | docker login -u "$USER" --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop old container (ignore error)
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"

                    // Run new updated container
                    sh """
                    docker run -d -p 8080:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful!"
        }
        failure {
            echo "Deployment Failed!"
        }
    }
}
