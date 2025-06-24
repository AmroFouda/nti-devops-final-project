pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    ECR_REPO = '015869558543.dkr.ecr.us-east-1.amazonaws.com/nti-devops-project-app-repo'
    IMAGE_TAG = "${env.BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
stage('Build Docker Image') {
  steps {
    sh 'docker build -t 015869558543.dkr.ecr.us-east-1.amazonaws.com/nti-devops-project-app-repo:3 -f docker/backend/Dockerfile .'
  }
}

  

    stage('Push to ECR') {
      steps {
        sh '''
          aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
          docker push $ECR_REPO:$IMAGE_TAG
        '''
      }
    }

    stage('Deploy with Helm') {
      steps {
        dir('helm-chart') {
          sh "helm upgrade --install my-app . --set image.repository=$ECR_REPO --set image.tag=$IMAGE_TAG"
        }
      }
    }
  }
}
