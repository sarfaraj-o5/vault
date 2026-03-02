kubectl --namespace cert-manager get all

export GITHUB_TOKEN=XXXXXX

kubectl create ns actions-runner-system

kubectl create secret generic controller-manaager -n actions-runner-system  --from-literal=github_token=${GITHUB_TOKEN}

### Install action runner controller on the Kubernetes cluster
## Run the below helm commands

helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller

helm repo update

helm upgrade --install --namespace actions-runner-system  --create-namespace --wait actions-runner-controller 
actions-runner-controller/actions-runner-controller --set 
syncPeriod=1m

## Verify that the action-runner-controller installed properly using below command

kubectl --namespace actions-runner-system get all

## kubectl create -f runner.yaml

## Check that the pod is running using the below command:

kubectl get pod -n actions-runner-system | grep -i "k8s-action-runner"

## check the pod with 
kubectl get po -n actions-runner-system

Install a MySQL Database on the Kubernetes cluster
‍

Create PV and PVC for MySQL Database. 
Create mysql-pv.yaml with the below content.

## create mysql ns
kubectl create ns mysql

## Now apply mysql-pv.yaml to create PV and PVC 

kubectl create -f mysql-pv.yaml -n mysql

## Create the file mysql-svc-deploy.yaml and add the below content to mysql-svc-deploy.yaml

## Here, we have used MYSQL_ROOT_PASSWORD as “password”.

## create svc and deploy
kubectl create -f mysql-svc-deploy.yaml -n mysql

## verify mysql db is running
kubectl get pod -n mysql

# Create a GitHub repository secret to store MySQL password
# As we will use MySQL password in the GitHub action workflow file as a good practice, we should not use it in plain text. So we will store MySQL password in GitHub secrets, and we will use this secret in our GitHub action workflow file.

# Create a secret in the GitHub repository and give the name to the secret as “MYSQL_PASS”, and in the values, enter “password”. 
# Create a GitHub workflow file
# YAML syntax is used to write GitHub workflows. For each workflow, we use a separate YAML file, which we store at .github/workflows/ directory. So, create a .github/workflows/ directory in your repository and create a file .github/workflows/mysql_workflow.yaml as follows.

# If you check the docker run command in the mysql_workflow.yaml file, we are referring to the .sql file, i.e., test.sql. So, create a test.sql file in your repository as follows:

# In test.sql, we are running MySQL queries like create tables.
Push changes to your repository main branch.
If everything is fine, you will be able to see that the GitHub action is getting executed in a self-hosted runner pod. You can check it under the “Actions” tab of your repository.

# You can check the workflow logs to see the output of SHOW TABLES—a command we have used in the test.sql file—and check whether the persons tables is created.

