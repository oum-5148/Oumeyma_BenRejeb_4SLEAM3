pipeline {

 agent any

 tools {jdk 'JAVA_HOME’, maven 'M2_HOME'}

 stages {

 stage('GIT') {

           steps {

               git branch: 'main',

               url: ' https://github.com/oum-5148/Oumeyma_BenRejeb_4SLEAM3.git'

          }

     }

 stage ('Compile Stage') {

 steps {

 sh 'mvn clean compile'

 }

 }

 }

}


