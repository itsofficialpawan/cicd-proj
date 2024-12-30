pipeline {
    agent {
        node {
            label 'jenkins-slave-node'
        }
    }
    
    stages {
        stage('Checkout code') {
            steps {
                git url: 'https://github.com/itsofficialpawan/cicd-proj.git', branch: 'main'
            }
        }
        stage('cleanup stage') {
            steps {
                sh 'docker rm -f $(docker ps -aq)'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myimage .'
            }
        }
       stage('Build and Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    sh 'docker tag myimage $DOCKER_USERNAME/myimage'
                    sh 'docker push $DOCKER_USERNAME/myimage'
                }
                   
            }
        }
        stage('Deploy application to kubernetes') {
            steps {
                sh 'kubectl apply -f my-deployment.yml'
            }
        }
    }
}
