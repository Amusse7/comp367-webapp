pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
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

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
