pipeline{
    agent { docker { image 'python:3.7.2' } }
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