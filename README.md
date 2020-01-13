# timeoff-management-devops

Solution based in:

https://github.com/awslabs/ecs-refarch-continuous-deployment

Deploy stack: 


chmod +x deploy.sh
aws s3api create-bucket --region us-east-1 --bucket timeoff-management-devops-solution  
./deploy.sh timeoff-management-devops-solution
