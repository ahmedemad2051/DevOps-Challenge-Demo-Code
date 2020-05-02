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
                }
                failure{
                    echo "======== test failed========"
                }
            }
        }
        stage('Building image') {
            steps{
                script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
                }
            }
        }
        // stage('Remove Unused docker image') {
        //     steps{
        //         sh "docker rmi $registry:$BUILD_NUMBER"
        //     }
        // }
        stage("Run python container with sidecar"){
            steps{
               script{
                    docker.run("redis") { c ->
                   
                    }
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

//  docker.image(registry+":$BUILD_NUMBER").inside("--link ${c.id}:redis_host") {
//                         /*
//                         * Run some tests which require MySQL, and assume that it is
//                         * available on the host name `db`
//                         */
                        
//                     }