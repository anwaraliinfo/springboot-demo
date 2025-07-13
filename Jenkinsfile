pipeline {
    agent any                           // run on the Jenkins master for now

    tools {                             // uses Jenkins‑managed Maven install
        maven  'Maven 3.8'
    }

    environment {
        DOCKER_IMAGE = "anwaraliinfo/springboot-demo:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/anwaraliinfo/springboot-demo.git'
            }
        }

        stage('Build JAR with Maven') {
            steps {
                sh 'mvn -B clean package'
            }
        }

        stage('Build Docker image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                        credentialsId: 'docker-hub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS')]) {

                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push $DOCKER_IMAGE"
                }
            }
        }
    }

    post {
        always { archiveArtifacts '**/target/*.jar' }
        success { echo '✅ Build & push succeeded' }
        failure { echo '❌ Build failed' }
    }
}

