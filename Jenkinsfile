pipeline {
    agent any
    environment {
        SonarQubeScanner = tool name: 'SonarQubeScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        dockerimg = "i-kamal02-master"
        containername = "c-kamal02-master"
        BUILD_DIR_JENKINS ='./'
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                dir("${BUILD_DIR_JENKINS}"){
                    script{
                        echo "Clean old checkout from workspace"
                        cleanWs()
                        echo "Source Code Checkout start"
                        checkout scm
                        echo "Source Code Checkout stop"
                    }
                }
            }
        }

        stage("Build image"){
            steps{
                script{
                    echo "docker image build start"
                    docker.build("${dockerimg}")
                    echo "docker image build ends"
                    // withDockerContainer("${dockerimg}"){
                    //     sh "pwd"
                    // }
                }
            }
        }

        stage("Run Docker Container"){
            steps{
                script{
                    bat "docker run -d --name ${containername} -p 1700:1700 ${dockerimg}" 
                }
            }
        }

        stage('Run Test cases inside container') {  
            steps{
                dir("${BUILD_DIR_JENKINS}"){
                    script{
                        bat "docker exec -d ${containername} /bin/bash npm run coverage"
                        // docker.image("${dockerimg}").inside{
                        //     echo "start inside"
                        //     sh 'npm start'
                        // }
                        // app.inside{
                        //     echo "start inside"
                        //     sh 'npm start'
                        // }
                        // withDockerContainer(image: 'i-kamal02-master') {
                        //     sh 'npm start'
                        // }
                    } 
                }
            }   
        }

        // stage('Clean and Build'){
        //     steps{
        //         echo "clean starts here"
        //         // Installed MSBuild plugin and added path C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe
        //         //{workspace} is default variable of Jenkins. It will provide path to project in jenkis
        //         bat "\"${msbuild}\" -t:restore,clean,build ${workspace}\\WebApplication1.sln"
        //     }
        // }

        // stage('Unit Test'){
        //     steps{
        //         echo "Unit Test Starts Here"
        //         bat "\"${nunit}\" --result=NUnitResults.xml ${workspace}\\TestProject1\\bin\\Debug\\netcoreapp3.1\\TestProject1.dll"
        //     }
        // }

        // stage('Run SonarQube Analysis'){
        //     steps{
        //         withSonarQubeEnv(installationName: 'Test_Sonar')  
        //          {
        //             //Scan Modules  
        //             echo 'Sonarqube scanning started'                               
        //             bat  """ ${SonarQubeScanner} -Dsonar.projectKey=using_jenkins -Dsonar.projectname=using_jenkins -Dsonar.sourceEncoding=UTF-8 -Dsonar.sources=${workspace}\\WebApplication1 -Dsonar.testExecutionReportPaths=coverage/test_results.xml=\\coverage\\test_results.xml -Dsonar.javascript.lcov.reportPaths=\\coverage\\lcov.info -Dsonar.verbose=true """
        //          }
        //     }
        // }
    }
}
//withDockerRegistry(credentialsId: 'dockercredentials', url: 'https://registry.hub.docker.com'){