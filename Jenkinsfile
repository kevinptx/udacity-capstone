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
    stage('Lint the Dockerfile') {
      steps {
        sh 'hadolint Dockerfile'
      }
    }
    stage('Build the Docker image') {
      steps {
         sh 'docker build -t capstone-final .'
      }
    }
    stage('Push docker image'){
      steps {
        withDockerRegistry([url: '', credentialsId: 'docker']) {
          sh 'docker tag capstone-final kpeery/capstone-final'
          sh 'docker push kpeery/capstone-final'
        }
      }
    }
    stage('Create Kubernetes cluster') {
      steps {
        sh 'echo creating EKS cluster'
        withAWS(credentials: 'aws', region: 'us-east-2') {
        sh '''eksctl create cluster \
            --name capstone-final \
            --region us-east-2 \
            --nodegroup-name capstone-final-nodes \
            --nodes 3 \
            --nodes-min 1 \
            --nodes-max 4 \
            --ssh-access \
            --managed'''
        }
      } 
    }
    stage('Create configuration file') {
      steps {
        withAWS(credentials: 'aws', region: 'us-east-2') {
        sh 'aws eks --region us-east-2 update-kubeconfig --name capstone-final'
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
        sh 'kubectl get service/capstone-final'
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