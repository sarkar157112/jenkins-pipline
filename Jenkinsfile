pipeline {
    agent any
    options {
        disableConcurrentBuilds()
        quietPeriod(60)
    }
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

        /*stage('Deploy') {
            steps {
                echo 'Deploying the Docker image...'
                script {
                    def imageName = 'nginx-app'
                    def imageTag = "v${env.timeStamp}-${env.GIT_COMMIT_SHORT}"

                    withDockerRegistry(credentialsId: 'docker-credentials') {
                        def dockerImage = docker.image("${DOCKER_USERNAME}/${imageName}:${imageTag}")
                        dockerImage.pull()

                         // Stop any containers using the same image and port
                        sh "docker ps -q --filter ancestor=${DOCKER_USERNAME}/${imageName} --filter publish=80 | xargs -r docker stop"

                        // Remove any stopped containers using the same image and port
                        sh "docker ps -a -q --filter ancestor=${DOCKER_USERNAME}/${imageName} --filter publish=80 | xargs -r docker rm"
                        sh "docker run -d -p 8090:80 --restart always ${DOCKER_USERNAME}/${imageName}:${imageTag}"
                    }
                }
            }
        }
    }
}
*/
        stage('Deploy') {
            steps {
                echo 'Deploying the Docker image...'
                script {
                    def imageName = 'nginx-app'
                    def imageTag = "v${env.timeStamp}-${env.GIT_COMMIT_SHORT}"

                    withDockerRegistry(credentialsId: 'docker-credentials') {
                        def dockerImage = docker.image("${DOCKER_USERNAME}/${imageName}:${imageTag}")
                        dockerImage.pull()

                       /* // Check if port 80 is already in use
                        def portCheck = sh(returnStatus: true, script: "lsof -i :80 | grep -q 'LISTEN'")
                        if (portCheck == 0) {
                            error("Port 80 is already in use. Please stop the process using port 80 and try again.")
                        }*/

                        // Stop and remove any containers using the same image
                        sh "docker ps -a | grep ${DOCKER_USERNAME}/${imageName} | awk '{ print \$1 }' | xargs  -r docker stop"
                        sh "docker ps -a | grep ${DOCKER_USERNAME}/${imageName} | awk '{ print \$1 }' | xargs  -r docker rm" 

                        //sh "docker ps  -a -q --filter ancestor=${DOCKER_USERNAME}/${imageName} | awk '{ print \$1 }' | xargs  -r docker stop"

                        //sh "docker ps -a -q --filter ancestor=${DOCKER_USERNAME}/${imageName} | awk '{ print \$1 }'| xargs -r docker rm"
                        // Wait for 30 seconds
                        sh "sleep 05"
                        sh "docker run -d -p 8090:80 --restart always ${DOCKER_USERNAME}/${imageName}:${imageTag}"
                    }
                }
            }
        }
    }
}