pipeline {
    agent any

    stages {
        stage('Fetch code: STEP:-1') {
            steps {
               git branch: 'project', url: 'https://github.com/altamashGit/Website-Responsive-CICD-nginx.git'
            }
        }
   stage('Deploy STEP:-3') {
            steps {
                sh 'rm -rf /var/www/html/*'
                sh 'cp -R * /var/www/html/'
            }
        }
        stage('Health Check') {
            steps {
                sleep 2
                sh 'curl -Is http://localhost | grep "200 OK"'
            }
        }
    }
        post {
        always {
            echo 'Build Process Completed.'
        }
        success {
            echo 'Website deployed successfully!'
        }
        failure {
            echo 'Build failed. Checking logs...'
        }
    }
}
