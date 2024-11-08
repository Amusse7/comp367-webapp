pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }

    stages {
        stage('Environment Diagnostics') {
            steps {
                sh 'echo "PATH = $PATH"'
                sh 'echo "JAVA_HOME = $JAVA_HOME"'
                sh '/usr/libexec/java_home'
                sh 'java -version'
                sh 'which mvn || echo "mvn not found in PATH"'
                sh 'mvn -version || echo "Failed to get Maven version"'
                sh 'docker --version || echo "Docker not found"'
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh '/usr/local/bin/mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh '/usr/local/bin/mvn test'
            }
        }

        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u am77445566 $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKERHUB_CREDENTIALS_USR/my-maven-webapp:$BUILD_NUMBER .'
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push $DOCKERHUB_CREDENTIALS_USR/my-maven-webapp:$BUILD_NUMBER'
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }
    }

    post {
        always {
            cleanWs()
            sh 'docker logout'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
