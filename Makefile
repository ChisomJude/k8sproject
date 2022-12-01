## The Makefile includes instructions on: 
# environment setup, install, lint and build

#Vars
CLUSTER_NAME=K8sCapstoneProject
REGION_NAME=us-west-1
KEYPAIR_NAME=keyudapipo
DEPLOYMENT_NAME=app
NEW_IMAGE_NAME=registry.hub.docker.com/chisomjude/simpleflaskapp:latest
CONTAINER_PORT=80
HOST_PORT=8080
KUBECTL=./bash/kubectl

setup:
	# Create a python virtualenv & activate it
	python3 -m venv ~/.myk8s
	# source ~/.myk8s/bash/activate 

install:	# TODO: Add a Docker analysis (DevSecOps)
	# This should be run from inside a virtualenv
	echo "Installing: dependencies..."
	pip install --upgrade pip &&\
	pip install -r app/requirements.txt
	# pip install "ansible-lint[community,yamllint]"
	echo
	pytest --version
	# ansible --version
	# ansible-lint --version
	echo
	echo "Installing: shellcheck"
	./bash/install_shellcheck.sh
	echo
	echo "Installing: hadolint"
	./bash/install_hadolint.sh
	echo
	echo "Installing: kubectl"
	./bash/install_kubectl.sh
	echo
	echo "Installing: eksctl"
	./bash/install_eksctl.sh
	
test:
	# Additional, optional, tests could go here
	#python -m pytest -vv app/app.py
	#python -m pytest 

lint:
	# https://github.com/koalaman/shellcheck: a linter for shell scripts
	./bash/shellcheck -Cauto -a ./bash/*.sh
	# https://github.com/hadolint/hadolint: a linter for Dockerfiles
	./bash/hadolint app/Dockerfile
	# https://www.pylint.org/: a linter for Python source code 
	# This should be run from inside a virtualenv
	pylint --output-format=colorized --disable=C app/app.py

run-app:
	python3 app/app.py

build-docker:
	./bash/build_docker.sh

run-docker: build-docker
	./bash/run_docker.sh

upload-docker: build-docker
	./bash/upload_docker.sh

ci-validate:
	# Required file: .circleci/config.yml
	circleci config validate

k8s-deployment: eks-create-cluster
	# If using minikube, first run: minikube start
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
