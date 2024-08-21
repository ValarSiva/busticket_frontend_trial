Bus Ticket System CI/CD pipeline (Single container application):

create folder: "bus_ticket_system_trial"
In cmd:
D:/Docker/bus_ticket_system_trial>git clone git@github.com:/ValarSiva/busticket_frontend_trial 
D:/Docker/bus_ticket_system_trial/busticket_frontend_trial>git init
D:/Docker/bus_ticket_system_trial/busticket_frontend_trial>git commit -m "first commit"
D:/Docker/bus_ticket_system_trial/busticket_frontend_trial>git add .
D:/Docker/bus_ticket_system_trial/busticket_frontend_trial>git commit -m "first commit"
D:/Docker/bus_ticket_system_trial/busticket_frontend_trial>git push -u origin main
In VS code: create "Dockerfile"
Create folder ".github". create subfolder "workflow" under ".github".
Create file "main.yml" under "workflow"
create "build" folder.
Create "git_update.sh" under "build"
Create react-app (npx create-react-app .)
create ECR repo "front_end" (private) => "create repository"
IAM=>Policies=>create policy=>json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "elasticbeanstalk:CreateApplicationVersion",
                "elasticbeanstalk:UpdateEnvironment",
                "elasticbeanstalk:DescribeEnvironments",
                "elasticbeanstalk:DescribeApplicationVersions",
                "elasticbeanstalk:ListAvailableSolutionStacks",
                "elasticbeanstalk:CreateStorageLocation",
                "elasticbeanstalk:DescribeApplications",
                "elasticbeanstalk:DescribeConfigurationOptions",
                "elasticbeanstalk:ValidateConfigurationSettings"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetAuthorizationToken",
                "ecr:DescribeRepositories",
                "ecr:ListImages"
            ],
            "Resource": "arn:aws:ecr:ap-south-1:058264377207:repository/front_end"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "arn:aws:iam::058264377207:role/front_end_dev"
        }
    ]
}
Give policy name "front_end_additional_policy" => create policy
IAM=>User Group=>create=>"	
front_end_group" (group name) => Add permission ("front_end_additional_policy", AdministratorAccess-AWSElasticBeanstalk 
and "AmazonEC2ContainerRegistryFullAccess")
IAM=>users=>Add_user=>"front_end_dev"(user name)=> "Add user to group"=>
select "front_end_group" group =>create user
Create Accesskey id for this user(front_end_dev)
Add secrets in github(settings=>secret variables=>actions=>new repository)
git status
git add .
git commit -a -m "third commit"
git push -u origin main
git status

deployment to ebs:
create ebs application "front_end"
create ebs environment: "Frontend-env"
    platform "Docker"=>"Docker running on 64bit Amazon Linux 2"
    EC2 instance role(front_end_ec2_role)=>AWSElasticBeanstalkMulticontainerDocker,AWSElasticBeanstalkWebTier,
     AWSElasticBeanstalkWorkerTier
    ElasticBeanStalk service role(front_end_service_role):AWSElasticBeanstalkEnhancedHealth,AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy and AWSElasticBeanstalkService
  Update main.yml file for EBS deployment
  Now push to github