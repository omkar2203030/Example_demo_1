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
                bat """
                docker build -t %IMAGE_NAME%:%IMAGE_TAG% .
                """
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CRED,
                                                 usernameVariable: 'USER',
                                                 passwordVariable: 'PASS')]) {
                    bat """
                    echo %PASS% | docker login -u %USER% --password-stdin
                    docker push %IMAGE_NAME%:%IMAGE_TAG%
                    """
                }
            }
        }

        stage('Deploy Container') {
            steps {
                bat """
                docker stop %CONTAINER_NAME% || echo No container running
                docker rm %CONTAINER_NAME% || echo Nothing to remove
                docker run -d -p 8080:80 --name %CONTAINER_NAME% %IMAGE_NAME%:%IMAGE_TAG%
                """
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
