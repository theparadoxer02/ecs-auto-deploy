pip install --user awscli
export PATH=$PATH:$HOME/.local/bin

sudo add-apt-repository -y ppa:eugenesan/ppa
sudo apt-get update
sudo apt-get install jq -y

curl https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy | sudo tee -a /usr/bin/ecs-deploy
sudo chmod +x /usr/bin/ecs-deploy

# Use this for AWS ECR
# $(aws ecr get-login --no-include-email)

# Use this for Docker Hub
docker login --username $DOCKER_HUB_USER --password $DOCKER_HUB_PSW

docker build -t haoliangyu/ecs-auto-deploy .
docker tag haoliangyu/ecs-auto-deploy:latest $IMAGE_REPO_URL:latest
docker push $IMAGE_REPO_URL:latest

ecs-deploy -c $CLUSTER_NAME -n $SERVICE_NAME -i $IMAGE_REPO_URL:latest
