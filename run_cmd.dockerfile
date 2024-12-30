pip install -r requirements.txt
uvicorn app.main:app --reload

aws eks describe-cluster --name healthsync-cluster --region ap-southeast-1 --query "cluster.status"

kubectl config use-context arn:aws:eks:ap-southeast-1:553580522931:cluster/healthsync-cluster


aws eks update-kubeconfig --region ap-southeast-1 --name healthsync-cluster

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 553580522931.dkr.ecr.ap-southeast-1.amazonaws.com


docker build -t patient-service .
docker tag patient-service:latest 553580522931.dkr.ecr.ap-southeast-1.amazonaws.com/healthsync/patient-service:latest
docker push 553580522931.dkr.ecr.ap-southeast-1.amazonaws.com/healthsync/patient-service:latest


kubectl create namespace healthsync
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

kubectl delete deployment patient-service


kubectl get svc patient-service

kubectl get pods -n healthsync



