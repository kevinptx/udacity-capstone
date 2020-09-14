# Udacity Capstone project

## Project Scope
Create a rolling update pipeline that takes files and containerizes them into a Docker image. 
The docker image is then pushed into Kubernetes clusters using Amazon EKS. 

### Environment setup.
1. Create an EC2 standalone instance.
2. Install necessary packages.
3. Install Jenkins and configure credentials for Docker and AWS.
4. Install BlueOcean and other necessary plugins.
6. Install eksctl, kubectl, awscli on the standalone instance.
7. Add Docker to the usergroup.
8. Install tidy lint for linting.
9. Configure AWS CLI.
10. Check for the pipeline completion process.

### Steps 
1. Create the file for containerization.
2. Create a Dockerfile for building an image.
3. Create a Jenkinsfile for the pipeline process.
4. Create a deployment file for Kubernetes.
5. Run the Jenkins pipeline from BlueOcean.