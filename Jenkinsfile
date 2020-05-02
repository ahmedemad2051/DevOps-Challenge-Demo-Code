pipeline{
    agent { docker { image 'python:3.7.2' } }
    environment {
        registry = "ahmedemad2051/python-demo"
        registryCredential = 'dockerhub'
        dockerImage = ''
        redisImage = "redis_server"
        pythonImage = "python_demo"
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
        stage("Image Prune"){
            steps{
                imagePrune(redisImage)
                imagePrune(pythonImage)
            }
        }
        stage("Run python container with sidecar"){
            steps{
               script{
                    redis_container= docker.image("redis").run("--rm --name ${redisImage}")
                    python_container = dockerImage.run("--link ${redis_container.id}:redis_host --rm --name ${pythonImage} -p 8000:8000")
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

def imagePrune(containerName){
    try {
        // sh "docker image prune -f"
        sh "docker stop $containerName"
    } catch(error){}
}
