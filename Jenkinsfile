pipeline {
    agent {
                label ("node1 || node2 || node3 || node4")
            }
    options { 
    
    buildDiscarder(logRotator(numToKeepStr: '2'))
    disableConcurrentBuilds()
    timeout (time: 60, unit: 'MINUTES')
    timestamps()
    }
      environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub_oumar_ID')
	
            
	     
	        
	}
    stages {
        
        stage('Setup parameters') {
            steps {

                script {
                    properties([
                        parameters([
                        
                        choice(
                            choices: ['Dev', 'sandbox', 'Prod'], 
                            name: 'Environment'
                                 
                                ),

                          string(
                            defaultValue: 's4oumar',
                            name: 'User',
                            description: 'Required to enter your name',
                            trim: true
                            ),
                          string(
                            defaultValue: 's4oumar',
                            name: 'DB-Tag',
                            description: 'Required to enter the image tag',
                            trim: true
                            ),
                          string(
                            defaultValue: 's4oumar',
                            name: 'UI-Tag',
                            description: 'Required to enter the image tag',
                            trim: true
                            ),
                          string(
                            defaultValue: 's4oumar',
                            name: 'WEATHER-Tag',
                            description: 'Required to enter the image tag',
                            trim: true
                            ),
                          string(
                            defaultValue: 's4oumar',
                            name: 'AUTH-Tag',
                            description: 'Required to enter the image tag',
                            trim: true
                            ),
                          string(
                            defaultValue: 's4oumar',
                            name: 'Area',
                            description: 'Required to enter your name',
                            trim: true
                            ),
                        ])
                    ])
                }
            }
        }
    
        stage('permission') {
            steps {
                
              sh '''
                ls
                hostname -I
         
                echo $Environment
                echo $USER

                cat permission.txt |grep -o $USER
                echo $?
                ls -la
		cat /home/jenkins/.docker/config.json
               '''
            }
        }
        stage('cleaning') {
            steps {
                echo 'Hello World'
            }
        }
        // stage('SonarQube analysis') {
          //  agent {
           //     docker {
            //      image 'sonarsource/sonar-scanner-cli:4.7.0'
            //    }
            //   }
           //    environment {
       // CI = 'true'
        //  scannerHome = tool 'Sonar'
       // scannerHome='/opt/sonar-scanner'
 //   }
      //      steps{
          //      withSonarQubeEnv('Sonar') {
             //       sh "${scannerHome}/bin/sonar-scanner"
             //   }
           // }
       // }
        stage('build-dev') {
          when{ 
          
          expression {
            env.Environment == 'Dev' }
          
            }
            steps {
                sh '''
                                cd UI
                docker build -t oumarkenneh/oumar-ui:${BUILD_NUMBER}$UITag .
                cd -

                cd DB
                docker build -t oumarkenneh/oumar-db:${BUILD_NUMBER}$DBTag .
                cd -

                cd auth
                docker build -t oumarkenneh/oumar-auth:${BUILD_NUMBER}$AUTHTag .
                cd -

                cd weather
                docker build -t oumarkenneh/oumar-weather:${BUILD_NUMBER}$WEATHERTag .
                cd -
                ls 
                pwd
                
                '''
            }
        }
        stage('login to dockerhub') {
            steps {
               sh '''
               echo $DOCKERHUB_CREDENTIALS | docker login -u oumarkenneh --password-stdin
	       
               '''
            }
        }
        stage('build-sandbox') {
          when{ 
          
          expression {
            env.Environment == 'sandbox' }
          
            }
            steps {
                sh '''
                                cd UI
                docker build -t oumarkenneh/oumar-ui:${BUILD_NUMBER}$UITag .
                cd -

                cd DB
                docker build -t oumarkenneh/oumar-db:${BUILD_NUMBER}$DBTag .
                cd -

                cd auth
                docker build -t oumarkenneh/oumar-auth:${BUILD_NUMBER}$AUTHTag .
                cd -

                cd weather
                docker build -t oumarkenneh/oumar-weather:${BUILD_NUMBER}$WEATHERTag .
                cd -
                ls 
                pwd
                
                '''
            }
        }

        stage('build-pro') {
          when{ 
          
          expression {
            env.Environment == 'Prod' }
          
            }
            steps {
              sh'''
		                                cd UI
                docker build -t oumarkenneh/oumar-ui:${BUILD_NUMBER}$UITag .
                cd -

                cd DB
                docker build -t oumarkenneh/oumar-db:${BUILD_NUMBER}$DBTag .
                cd -

                cd auth
                docker build -t oumarkenneh/oumar-auth:${BUILD_NUMBER}$AUTHTag .
                cd -

                cd weather
                docker build -t oumarkenneh/oumar-weather:${BUILD_NUMBER}$WEATHERTag .
                cd -
                ls 
                pwd
		
	       '''
		    
            }
        }
        stage('push-to-dockerhub-dev') {
          when{
            expression {
              env.Environment == 'Dev' }
            }
            steps {
               sh '''
                docker push oumarkenneh/oumar-ui:${BUILD_NUMBER}$UITag 
                docker push oumarkenneh/oumar-db:${BUILD_NUMBER}$DBTag 
                docker push oumarkenneh/oumar-auth:${BUILD_NUMBER}$AUTHTag 
                docker push oumarkenneh/oumar-weather:${BUILD_NUMBER}$WEATHERTag
               '''
            }
        }
        stage('push-to-dockerhub-sandbox') {
          when{
            expression {
              env.Environment == 'sandbox' }
	  }
            steps {
               sh '''
                docker push oumarkenneh/oumar-ui:${BUILD_NUMBER}$UITag 
                docker push oumarkenneh/oumar-db:${BUILD_NUMBER}$DBTag 
                docker push oumarkenneh/oumar-auth:${BUILD_NUMBER}$AUTHTag 
                docker push oumarkenneh/oumar-weather:${BUILD_NUMBER}$WEATHERTag
               '''
            }
        }
        stage('push-to-dockerhub-prod') {
          when{
            expression {
              env.Environment == 'Prod' }
	  }
            steps {
               sh '''
                docker push oumarkenneh/oumar-ui:${BUILD_NUMBER}$UITag 
                docker push oumarkenneh/oumar-db:${BUILD_NUMBER}$DBTag 
                docker push oumarkenneh/oumar-auth:${BUILD_NUMBER}$AUTHTag 
                docker push oumarkenneh/oumar-weather:${BUILD_NUMBER}$WEATHERTag
               '''
            }
        }
        stage('update helm charts-dev') {
            steps {
                sh '''
		pwd

		rm -rf demo
		git clone https://oumar-token-ID@github.com/nostradamus/demo.git
		cd demo/CHARTS
		 DBTag=${BUILD_NUMBER}
		 UITag=${BUILD_NUMBER}
		 AUTHTag=${BUILD_NUMBER}
		 WEATHERTag=${BUILD_NUMBER}
		
		git config --global user.email "kenneho@yahoo.com"
		git config --global user.name "oumarkenneh"
cat <<EOF > dev-values.yaml
    image :
      db: 
        repository: oumarkenneh/oumar-db
	tag: "${BUILD_NUMBER}"
  
      ui: 
        repository: oumarkenneh/oumar-ui
	tag: "${BUILD_NUMBER}" 
	
      db: 
        repository: oumarkenneh/oumar-auth
	tag: "${BUILD_NUMBER}"
	
      db: 
        repository: oumarkenneh/oumar-weather
	tag: "${BUILD_NUMBER}"
EOF   
		'''
            }
        }
        stage('update helm charts-sanbox') {
            steps {
	       sh '''
                echo "hello World"
		ls -ltr
cat <<EOF > sandbox-values.yaml
    image :
      db: 
        repository: oumarkenneh/oumar-db
	tag: "${BUILD_NUMBER}"
  
      ui: 
        repository: oumarkenneh/oumar-ui
	tag: "${BUILD_NUMBER}" 
	
      db: 
        repository: oumarkenneh/oumar-auth
	tag: "${BUILD_NUMBER}"
	
      db: 
        repository: oumarkenneh/oumar-weather
	tag: "${BUILD_NUMBER}"
	
EOF
	       '''
            }
        }
        stage('update helm charts-pro') {
            steps {
                sh '''
cat <<EOF > pro-values.yaml
    image :
      db: 
        repository: oumarkenneh/oumar-db
	tag: "${BUILD_NUMBER}"
  
      ui: 
        repository: oumarkenneh/oumar-ui
	tag: "${BUILD_NUMBER}" 
	
      db: 
        repository: oumarkenneh/oumar-auth
	tag: "${BUILD_NUMBER}"
	
      db: 
        repository: oumarkenneh/oumar-weather
	tag: "${BUILD_NUMBER}"
	
EOF
		'''
            }
        }
	    
        stage('wait for argocd') {
            steps {
                echo 'Hello World'
            }
        }
        stage('deploy to production') {
            steps {
                echo 'Hello World'
            }
        }

    }


   post {
   
   success {
      slackSend (channel: '#development-alerts', color: 'looking good', message: "SUCCESSFUL:  Branch name  <<${env.BRANCH_NAME}>>  Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
 
    unstable {
      slackSend (channel: '#development-alerts', color: 'warning shut', message: "UNSTABLE:  Branch name  <<${env.BRANCH_NAME}>>  Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
    failure {
      slackSend (channel: '#development-alerts', color: '#FF0000', message: "FAILURE:  Branch name  <<${env.BRANCH_NAME}>> Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
   
    cleanup {
      deleteDir()
    }
}

}
