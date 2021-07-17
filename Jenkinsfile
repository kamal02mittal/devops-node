pipeline {
    agent any

    environment {
        SonarQubeScanner = tool name: 'SonarQubeScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        dockerimg = "i-kamal02-master"
        containername = "c-kamal02-master"
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                echo "Clean old checkout from workspace"
                cleanWs()
                echo "Source Code Checkout start"
                checkout scm
                echo "Source Code Checkout stop"
            }
        }

        stage("Build image"){
            steps{
                script{
                    app = docker.build("${dockerimg}") 
                }
            }
        }

        // stage("Run Docker Container"){
        //     steps{
        //         script{
        //             bat "docker run -d --name ${containername} -p 1800:1700 ${dockerimg}" 
        //         }
        //     }
        // }

        stage('Test image') {  
            steps{
                script{
                    app.inside {
                        sh 'npm start'
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