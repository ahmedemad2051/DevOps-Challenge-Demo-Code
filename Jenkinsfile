pipeline{
    agent any
    stages{
        stage("run test"){
            steps{
                sh 'python tests/test.py'
            }
            post{
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "======== tests failed========"
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

}