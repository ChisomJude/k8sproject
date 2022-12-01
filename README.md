# Udacity Capstone Project

[![Passed](https://circleci.com/gh/ChisomJude/K8sproject.svg?style=shield)](https://github.com/ChisomJude/K8s)

## Project Overview

This capstone project showcases the use of  CI/CD tools and cloud services 
### Introduction

This project is an implementation of a sample python-flask app called ["simpleflaskapp"](./app/app.py), using [CircleCI](https://www.circleci.com) and
 a [Kubernetes](https://kubernetes.io/)(K8S) cluster deployed in [AWS EKS](https://aws.amazon.com/eks/)(Amazon Elastic Kubernetes Services):

* In a [CircleCI](https://www.circleci.com) pipeline,  build
 a [Docker](https://www.docker.com/resources/what-container) image and deploy it to a public
Docker Registry: [Docker Hub](https://hub.docker.com/repository/docker/chisomjude/simpleflaskapp)
* Then in an [AWS EKS](https://aws.amazon.com/eks/) cluster, we run the application
* Later, we promote to production a new app version using a rolling update strategy

All the project's tasks are included in a [Makefile](Makefile), which uses several shell scripts stored in the
[bash](bash) directory.

### Project Tasks

Using a CI/CD approach, we build a [Docker](https://www.docker.com/resources/what-container) image and then run it in a [Kubernetes](https://kubernetes.io/) cluster.

The project includes the following main tasks:

* Initialize the Python virtual environment:  `make setup`
* Install all necessary dependencies:  `make install`
* Test the project's code using linting:  `make lint`
  * Lints shell scripts, Dockerfile and python code
* Create a Dockerfile to "containerize" the [simpleflask](/app/app.py) application: [Dockerfile](app/Dockerfile)
* Deploy to a public Docker Registry:
 [Docker Hub](https://hub.docker.com/repository/docker/gampie/hello-app) the containerized application
* Deploy a Kubernetes cluster:  `make eks-create-cluster`
* Deploy the application:  `make k8s-deployment`
* Update the app in the cluster, using a rolling-update strategy:  `make rolling-update`
* Delete the cluster:  `make eks-delete-cluster`

The CirclCI pipeline([config.yml](.circleci/config.yml)) will execute the following steps automatically:

* `make setup`
* `make install`
* `make lint`
* Build and publish the container image



### CI/CD Tools and Cloud Services

* [Circle CI](https://www.circleci.com) - Cloud-based CI/CD service
* [Amazon AWS](https://aws.amazon.com/) - Cloud services
* [AWS EKS](https://aws.amazon.com/eks/) - Amazon Elastic Kubernetes Services
* [AWS eksctl](https://eksctl.io) - The official CLI for Amazon EKS
* [AWS CLI](https://aws.amazon.com/cli/) - Command-line tool for AWS
* [CloudFormation](https://aws.amazon.com/cloudformation/) - Infrastructure as Code
* [kubectl](https://kubernetes.io/docs/reference/kubectl/) - a command-line tool to control Kubernetes clusters
* [Docker Hub](https://hub.docker.com/repository/docker/chisomjude/simpleflaskapp) - Container images repository service

#### CicleCI Variables

  To `build` and `publish` your image, you need to set up the  environment
  variables for DOCKERHUB LOGIN in your CircleCI project

* DOCKER_LOGIN
* DOCKER_PASSWORD
  
### HOW TO RUN PROJECT

