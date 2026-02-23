pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Spokay/landing-page-example-fork.git'
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([file(
                    credentialsId: 'ssh-always-data',
                    variable: 'SSH_KEY'
                )]) {
                    sh '''
                        chmod 600 $SSH_KEY
                        scp -i $SSH_KEY -o StrictHostKeyChecking=no index.html spokay@ssh-spokay.alwaysdata.net:~/www/TP_2/index.html
                    '''
                }
            }
        }
    }
}
