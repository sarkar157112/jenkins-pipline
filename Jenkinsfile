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
    }
}
