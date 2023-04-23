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
                    env.timeStamp = new Date().format("yyyyMMddHHmmss")
                    env.GIT_COMMIT_SHORT = sh(returnStdout: true, script: "git rev-parse --short HEAD").trim()
                    def imageName = 'nginx-app'
                    def imageTag = "v${env.timeStamp}-${env.GIT_COMMIT_SHORT}"

                    withDockerRegistry(credentialsId: 'docker-credentials') {
                        def dockerImage = docker.build("${DOCKER_USERNAME}/${imageName}:${imageTag}", '.')
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the Docker image...'
                script {
                    def imageName = 'nginx-app'
                    def imageTag = "v${env.timeStamp}-${env.GIT_COMMIT_SHORT}"

                    withDockerRegistry(credentialsId: 'docker-credentials') {
                        def dockerImage = docker.image("${DOCKER_USERNAME}/${imageName}:${imageTag}")
                        dockerImage.pull()

                        sh "docker stop \$(docker ps -q --filter ancestor=${DOCKER_USERNAME}/${imageName}) || true"
                        sh "docker rm \$(docker ps -a -q --filter ancestor=${DOCKER_USERNAME}/${imageName}) || true"
                        sh "docker run -d -p 80:80 --restart always ${DOCKER_USERNAME}/${imageName}:${imageTag}"
                    }
                }
            }
        }
    }
}
