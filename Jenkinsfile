pipeline {
    agent any

    environment {
        GIT_CREDENTIALS = 'git-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the repository...'
                git branch: 'teshla', credentialsId: 'githubcreds', url: 'https://github.com/sarkar157112/jenkins-pipline.git'
            }
        }
    stage('Build and Push Docker Image') {
            steps {
                echo 'Building and pushing the Docker image...'
                script {
                    // Replace 'your_image_name' with your desired image name and './Dockerfile' with the path to your Dockerfile
                    def imageName = 'nginx-app'
                    def timeStamp = new Date().format("yyyyMMddHHmmss")
                    def imageTag = "v${timeStamp}"

                    withDockerRegistry(credentialsId: 'dockerhub', url: 'https://hub.docker.com/') {
                        def dockerImage = docker.build("${DOCKER_USERNAME}/${imageName}:${imageTag}")
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
