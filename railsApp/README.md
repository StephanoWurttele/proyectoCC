# Rais Application Deployment

This is a Ruby on Rails application that works as a template for deployment of a Web Application. It is currently built on Ruby on Rails 7, and has a Dockerfile that installs all prerequisites into a container. After the steps of deployment are complete, a user should be able to access the Web Application, hosted on Kubernetes, from their prefered Web Browser.

## Deployment instructions

A change was done in the deployment.yaml file, adding "imagePullPolicy: Never". 

To deploy in multinode, follow the commands as shown in the `multinode.sh` file, though running it doesn't work. That includes:
1. Start minikube by running `minikube start --kubernetes-version=1.22.3 --driver=docker --nodes=3 --logtostderr -v 10`
2. Build docker image inside kubernetes with `minikube image build -t stephanofw/kub-rails-exa:pr1 .`
3. Look at minikube's image list with `minikube image ls`
4. Run `kubectl apply -f config/kube` to apply configuration with recently created image and port configuration
5. Check results with `kubectl get nodes` and `kubectl get pods -owide` and check running server status with `kubect logs <pod>`
6. Run `minikube tunnel` in a separate terminal, as it will run continuously. This will configure an accessible port by building a tunnel between the container's network and the host's, fixing an 'EXTERNAL-IP pending' problem.
7. Run `kubectl get svc` and copy the EXTERNAL-IP for rails-deployment
8. Connect to Rails server by entering `EXTERNAL-IP:8080`
