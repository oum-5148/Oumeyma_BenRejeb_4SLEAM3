pipeline {
    agent any

    tools { 
        jdk 'JAVA_HOME' 
        maven 'M2_HOME'
    }

    environment {
        DOCKERHUB_REPO = 'oumeyma5148/student-management'
        DOCKER_CREDENTIALS_ID = '1939bbb7-18d8-4cac-881a-7c1b66df39e4'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('GIT') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-token',
                    url: 'https://github.com/oum-5148/Oumeyma_BenRejeb_4SLEAM3.git'
            }
        }

        stage('Compile Stage') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Package Stage') {
            steps {
                sh 'mvn package -DskipTests'
                sh 'ls -la target'
            }
        }

         stage('MVN SonarQube') {
            environment {
                SONAR_TOKEN = credentials('sonar-token')  
            }
            steps {
                withSonarQubeEnv('sonarqube') { 
                    sh """
                        mvn sonar:sonar \
                        -Dsonar.projectKey=OumeymaProject \
                        -Dsonar.host.url=http://192.168.33.10:9000 \
                        -Dsonar.login=$SONAR_TOKEN
                    """
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKERHUB_REPO:$IMAGE_TAG ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: '1939bbb7-18d8-4cac-881a-7c1b66df39e4',
                                usernameVariable: 'DOCKER_USER',
                                passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push $DOCKERHUB_REPO:$IMAGE_TAG"
                }
            }
        }
    }

    post {
        success {
            echo "Image Docker poussée avec succès sur $DOCKERHUB_REPO:$IMAGE_TAG"
        }
        failure {
            echo "Erreur dans le pipeline."
        }
    }
}
