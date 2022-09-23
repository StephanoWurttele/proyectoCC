# Comienza minikube con 3 nodos usando docker
echo "STARTING KUBERNETES---------------------------------------"
minikube start --kubernetes-version=1.22.3 --driver=docker --nodes=3 --logtostderr -v 10
echo "BUILDING RAILS IMAGE---------------------------------------"
minikube image build -t stephanofw/kub-rails-exa:pr1 .
echo "MINIKUBE IMAGE LIST---------------------------------------"
minikube image ls
echo "DEPLOY YAML CONFIG---------------------------------------"
# Usa el yaml creado para desplegar 3 contenedores
kubectl apply -f config/kube
# Revisamos los resulatados
echo "MINIKUBE CURRENT PODS---------------------------------------"
kubectl get pods -owide
# Revisamos los puertos
echo "MINIKUBE CURRENT SERVICES---------------------------------------"
kubectl get svc
echo "Ahora debes ejecutar 'minikube tunnel' para configurar el port en una terminal separada, pues se mantendrá corriendo"
echo "Luego ejecuta 'kubectl get svc' para ver el IP externo y el puerto (que sera 8080). Ponlo en el browser y podrás acceder a la aplicación"
# minikube tunnel &
