pipeline {
    agent { label 'vm-local' }

    stages {
        stage('Cleanup') {
            steps {
                cleanWs()
            }
        }
        /*stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Spokay/landing-page-example-fork.git'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t registry.spokayhub.top/landing-page-example:latest .'
            }
        }
        stage('Push') {
            steps {
                  withDockerRegistry(credentialsId: 'spokay-registry-credentials', url: 'https://registry.spokayhub.top/') {
                        sh 'docker push registry.spokayhub.top/landing-page-example:latest'
                  }
            }
        }*/

        stage('Deploy') {
            steps {
                sshagent(credentials: ['azure-ssh-credentials']) {
                    withCredentials([usernamePassword(credentialsId: 'spokay-registry-credentials', usernameVariable: 'REGISTRY_USER', passwordVariable: 'REGISTRY_PASS')]) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no azureuser@74.234.235.112 "
                                echo $REGISTRY_PASS | docker login registry.spokayhub.top -u $REGISTRY_USER --password-stdin &&
                                docker pull registry.spokayhub.top/landing-page-example:latest &&
                                docker stop landing-page || true &&
                                docker rm landing-page || true &&
                                docker run -d -p 80:80 --name landing-page registry.spokayhub.top/landing-page-example:latest
                            "
                        '''
                    }
                }
            }
        }
    }
}
