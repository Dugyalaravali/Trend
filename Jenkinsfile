pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "dugyalaravali28/trend-app"
        KUBE_NAMESPACE = "monitoring"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git 'https://github.com/Dugyalaravali/Trend.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE:latest'
            }
        }

        stage('Deploy App to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }

        stage('Setup Monitoring (Prometheus & Grafana)') {
            steps {
                sh '''
                kubectl create namespace $KUBE_NAMESPACE || true

                helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
                helm repo update

                helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
                --namespace $KUBE_NAMESPACE
                '''
            }
        }

        stage('Verify Monitoring') {
            steps {
                sh 'kubectl get pods -n $KUBE_NAMESPACE'
                sh 'kubectl get svc -n $KUBE_NAMESPACE'
            }
        }
    }
}
