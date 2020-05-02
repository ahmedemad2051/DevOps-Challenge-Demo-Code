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
                sh 'docker run -d --name=redis_server redis'
                sh 'docker run -d --name python_demo --link redis_server:redis_host -p 9000:8000 dockerImage.name'
            //    script{
            //         redis_container= docker.image("redis").run()
            //         python_container = dockerImage.run("--link ${redis_container.id}:redis_host -p 9000:8000")
            //     }
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
