## The Makefile includes instructions on: 
# environment setup, install, lint and build

#Vars
CLUSTER_NAME=K8sCapstoneProject
REGION_NAME=us-west-1
KEYPAIR_NAME=keyudapipo
DEPLOYMENT_NAME=app
NEW_IMAGE_NAME=registry.hub.docker.com/chisomjude/myflaskapp:latest
CONTAINER_PORT=80
HOST_PORT=8082
KUBECTL=./bash/kubectl



install:	# TODO: Add a Docker analysis (DevSecOps)

	echo "Installing: kubectl"
	./bash/install_kubectl.sh
	echo
	
	echo "Installing: eksctl"
	./bash/install_eksctl.sh
	

ci-validate:
	# Required file: .circleci/config.yml
	circleci config validate

k8s-deployment: eks-create-cluster
	./bash/k8s_deployment.sh

port-forwarding: 
	# Needed for "minikube" only
	${KUBECTL} port-forward service/${DEPLOYMENT_NAME} ${HOST_PORT}:${CONTAINER_PORT}

rolling-update:
	${KUBECTL} get deployments -o wide
	${KUBECTL} set image deployments/${DEPLOYMENT_NAME} \
		${DEPLOYMENT_NAME}=${NEW_IMAGE_NAME}
	echo
	${KUBECTL} get deployments -o wide
	${KUBECTL} describe pods | grep -i image
	${KUBECTL} get pods -o wide

rollout-status:
	${KUBECTL} rollout status deployment ${DEPLOYMENT_NAME}
	echo
	${KUBECTL} get deployments -o wide

rollback:
	${KUBECTL} get deployments -o wide
	${KUBECTL} rollout undo deployment ${DEPLOYMENT_NAME}
	${KUBECTL} describe pods | grep -i image
	echo
	${KUBECTL} get pods -o wide
	${KUBECTL} get deployments -o wide

k8s-cleanup-resources:
	./bash/k8s_cleanup_resources.sh

eks-create-cluster:
	./bash/eks_create_cluster.sh

eks-delete-cluster:
	./bash/eksctl delete cluster --name "${CLUSTER_NAME}" \
		--region "${REGION_NAME}"
