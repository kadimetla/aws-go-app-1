# Makefile

# Variables
IMAGE_NAME=qwai/sample-go-app
AWS_ACCOUNT_ID=
REGION=us-east-2
REPOSITORY_NAME=$(IMAGE_NAME)

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Tag the Docker image
tag:
	docker tag $(IMAGE_NAME):latest $(AWS_ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/$(REPOSITORY_NAME):latest

# Push the Docker image to Amazon ECR
push:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/$(REPOSITORY_NAME):latest

# Run the Docker container
run:
	docker run -d -p 8080:8080 $(IMAGE_NAME)

# Clean up Docker images
clean:
	docker rmi $(IMAGE_NAME)
	docker rmi $(AWS_ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/$(REPOSITORY_NAME):latest
