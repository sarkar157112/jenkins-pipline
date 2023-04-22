pipeline {
    agent any
    environment {
        DOCKER_USERNAME = '157112'
    }


  


    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the repository...'
                 checkout scmGit(branches: [[name: '*/teshla']], extensions: [], userRemoteConfigs: [[credentialsId: 'github_credentials', url: 'https://github.com/sarkar157112/jenkins-pipline.git']])
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

                    //withDockerRegistry(credentialsId: 'dockerhub', url: 'https://hub.docker.com/') {
                   withDockerRegistry(credentialsId: 'docker-credentials') {
                        def dockerImage = docker.build("${DOCKER_USERNAME}/${imageName}:${imageTag}", '.')
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
