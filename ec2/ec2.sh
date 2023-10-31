
docker-compose exec localstack awslocal ec2 create-key-pair --key-name ec2-key --query 'KeyMaterial' --output text | tee key.pem

docker-compose exec localstack awslocal ec2 authorize-security-group-ingress     --group-id default     --protocol tcp     --port 8000 --cidr 0.0.0.0/0

docker-compose exec localstack awslocal ec2 describe-security-groups

docker-compose exec localstack awslocal ec2 run-instances --image-id ami-ff0fea8310f3  --count 1 --instance-type t3.nano --key-name ec2-key --security-group-ids 'sg-4d0eb73aa7496d7b3' --user-data file:///opt/code/localstack/ec2/user_script.sh

#######################

docker-compose exec localstack aws configure

tflocal apply

docker-compose exec localstack awslocal ec2 describe-instances

#######################

#Dependency graph of terraform resources
tflocal graph

#Parse output using GraphViz online https://dreampuf.github.io/GraphvizOnline
