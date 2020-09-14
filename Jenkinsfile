pipeline {
  agent any 
  stages {
    stage('Start the Jenkins pipeline') {
      steps {
        sh 'echo Starting Jenkins pipeline build'
      }
    }
    stage('Start HTML file') {
      steps {
        sh 'tidy -q -e index.html'
      }
    }
    stage('Build the Docker image') {
      steps {
         sh 'docker build -t capstone .'
      }
    }
    stage('Push docker image'){
      steps {
        withDockerRegistry([url: '', credentialsId: 'docker']) {
          sh 'docker tag capstone kpeery/capstone'
          sh 'docker push kpeery/capstone'
        }
      }
    }
    stage('Create Kubernetes cluster') {
      steps {
        sh 'echo creating EKS cluster'
        withAWS(credentials: 'aws', region: 'us-east-2') {
        sh '''eksctl create cluster \
            --name capstone \
            --region us-east-2 \
            --nodegroup-name capstone \
            --nodes 3 \
            --nodes-min 1 \
            --nodes-max 4 \
            --managed'''
        }
      } 
    }
    stage('Create configuration file') {
      steps {
        withAWS(credentials: 'aws', region: 'us-east-2') {
        sh 'aws eks --region us-east-2 update-kubeconfig --name capstone'
        } 
      }
    }
    stage('Apply the deployment') {
      steps {
        withAWS(credentials: 'aws', region: 'us-east-2') {
        sh 'kubectl apply -f deployment.yml'
        } 
      }
    }
    stage('Access the created clusters') {
      steps {
        withAWS(credentials: 'aws', region: 'us-east-2') {
        sh 'kubectl get nodes'
        sh 'kubectl get deployment'
        sh 'kubectl get pod -o wide'
        sh 'kubectl get service/capstone'
        } 
      }
    }
    stage('Clean Docker processes') {
      steps {
        echo 'Clean-up process initiated'
        sh 'docker system prune'
      }
    }
  }
}