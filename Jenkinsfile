pipeline {
    agent {
                label ("node1 || node2 || node3 || node4")
            }
    options {
    //timeout(time: 1, unit: 'HOURS') 
    
    buildDiscarder(logRotator(numToKeepStr: '2'))
    disableConcurrentBuilds()
    timeout (time: 60, unit: 'MINUTES')
    timestamps()
    }
    stages {
        stage('Setup parameters') {
            steps {
                sh '''
                      rm -rf check.sh
                      cat <<EOF > check.sh

                           #!/bin/bash
                           USER=${User}
                          cat permission.txt |grep -i $User
                           if [[ $? -eg 0 ]]
                           then 
                           echo "you have permission to run this job"
                           else
                           echo "you don't have permission to run this job"
                           exit 1
                           fi
                          EOF
                            pwd
                            ls
                            cat check.sh
                   '''
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
                echo 'Hello World'
            }
        }
        stage('cleaning') {
            steps {
                echo 'Hello World'
            }
        }
        stage('sonarqube') {
            steps {
                echo 'Hello World'
            }
        }
        stage('build-dev') {
            steps {
                echo 'Hello World'
            }
        }
        stage('build-sandbox') {
            steps {
                echo 'Hello World'
            }
        }
        stage('build-pro') {
            steps {
                echo 'Hello World'
            }
        }
        stage('push-to-dockerhub-dev') {
            steps {
                echo 'Hello World'
            }
        }
        stage('push-to-dockerhub-sandbox') {
            steps {
                sh'''
                echo 'Hello World'
                ls
                uname -r
                '''
            }
        }
        stage('push-to-dockerhub-pro') {
            steps {
                echo 'Hello World'
            }
        }
        stage('update helm charts-dev') {
            steps {
                echo 'Hello World'
            }
        }
        stage('update helm charts-sanbox') {
            steps {
                echo 'Hello World'
            }
        }
        stage('update helm charts-pro') {
            steps {
                echo 'Hello World'
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
