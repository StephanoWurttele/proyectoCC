# Comienza minikube con 1 nodos usando docker
# Temporalmente comentado el multi nodo minikube start --kubernetes-version=1.22.3 --driver=docker --nodes=3 --logtostderr -v 10
minikube start --kubernetes-version=1.22.3 --driver=docker --logtostderr -v 10
eval $(minikube -p minikube docker-env)
docker build -t stephanofw/kub-rails-exa:pr1 .
docker run -p 3000:3000 stephanofw/kub-rails-exa:pr1 .
minikube tunnel &
# Usa el yaml creado para desplegar 3 contenedores
kubectl apply -f config/kube
# Revisamos los resulatados
kubectl get pods -owide
# Revisamos los puertos
kubectl get svc
