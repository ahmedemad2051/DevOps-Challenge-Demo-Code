pipeline{
    agent { docker { image 'python:3.7.2' } }
    environment {
        registry = "ahmedemad2051/python-demo_dev"
        registryCredential = 'dockerhub'
        dockerImage = ''
        redisContainer = "redis_server_dev"
        pythonContainer = "python_demo_dev"
        webPort = "9000"
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
        stage("Stop current containers"){
            steps{
                stopContainer(redisContainer)
                stopContainer(pythonContainer)
            }
        }
        stage("Run python container with sidecar"){
            steps{
               script{
                    redis_container= docker.image("redis").run("--rm --name ${redisContainer}")
                    python_container = dockerImage.run("--link ${redis_container.id}:redis_host --rm --name ${pythonContainer} -p ${webPort}:8000")
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

def stopContainer(containerName){
    try {
        sh "docker stop $containerName"
    } catch(error){}
}
