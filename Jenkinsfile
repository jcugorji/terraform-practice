Pipeline {
    agent any
    tools {
        maven 'maven'
    }
    parameters {
        choice (name:'version',choices:['1.1.0','1.2.0'],description:'pipeline version')
        booleanParam(name:'executeTest', defaultValue:true)
    }
}
    stages {
        stage ("build jar") {
            steps {
               echo 'building maven package'
               sh 'mvn package'
           }
        }
        stage ("build image") {
            steps {
               echo 'building docker image'
               withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')])
               sh 'docker build -t frost67/my-app:practice-1'
               sh "echo $PASS | docker login -u $USER --password-stdin"
               sh 'docker push frost67/my-app:practice-1'
           }
        }
        stage ("test") {
            when {
                expression {
                    Params.executeTest == true
                }
            }
            steps {
                echo 'testing build'
            }
        }
        stage ("deploy") {
            input {
                message "select deployment environment"
                ok "Done"
                parameters {
                    choice (name: 'ENV', choices: ['dev', 'prod'], description: 'deployment environment')
                }

            }
            steps {
                echo "deploying to ${ENV}"
            }
            
        }
           
    }
