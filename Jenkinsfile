pipeline{
    agent { docker { image 'python:3.7.2' } }
    environment {
        registry = "ahmedemad2051/python-demo"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    stages{
        stage('build') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage("test"){
            steps{
                sh 'python tests/test.py'
            }
            post{
                success{
                    echo "======== test successfully========"
                    stage('Building image') {
                        steps{
                            script {
                            dockerImage = docker.build registry + ":$BUILD_NUMBER"
                            }
                        }
                    }
                }
                failure{
                    echo "======== test failed========"
                }
            }
        }
    
    }
    post{
            always{
                echo "========always========"
            }
            success{
                echo "========pipeline executed successfully ========"
            }
            failure{
                echo "========pipeline execution failed========"
            }
    }

}