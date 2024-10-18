# aws-wildcard-certificate
# 1. Introduction
This project was created to showcase my skills using Terraform, AWS and CI/CD which it's in this case Github Actions

By following the example in this repository, you will learn how to:
- Create wildcard certificate in AWS
- Use Terrafom backend
- Provision AWS services using Terraform
- Automate the provisioning using Github Actions

# 2. Pre-Requisites
- IAM role with the required permissions
- S3 bucket that will contain the Terraform state file
- DynamoDB database that will used to lock the state file when it's used by another user
- Public hosted zone

# 3. Understanding Terraform Backend
In Terraform, the backend is a crucial component that defines how and where Terraform stores the state of your infrastructure. The state file is essential because it keeps track of the resources Terraform manages, their current configurations, and their relationships. Without this state file, Terraform cannot correctly determine which changes need to be applied.

# 4. Step by step guide
In this section, I will show you how to create all the infrastructure using Terraform
## 4.1 Preparing the environment
1. Clone this project in your own pc
2. Create another repo in Github
3. Push the project to your new repo

From now on you're going to use your own repo for the rest of the steps

## 4.2 Set AWS access
We're going to follow AWS best practices and use an AWS role to provision the resources
In case you don't have the role created, you can go to this repo and will found how to create it. You will find 2 methods provided, so just the one that you feel more comfortable doing it.
[aws-role-github](https://github.com/opsforall/aws-role-github)

After ensuring you have the right access role, you need to go to your own repository, create a secret named "AWS_ROLE_TO_ASSUME" and fill it with the arn of the role created

## 4.3 Configure Terraform backend
In this section, we're going to configure terraform backend
1. Configure the backend S3 bucket:
You need to create a secret named 'STATE_BUCKET' and fill it with the name of the backend bucket
2. Configure the DynamodDB database
You need to create a secret named 'LOCK_DYNAMODB' and fill it with the name of the backend dynamodb database

### 4.4 Configure domain name
In my case I decided to pass the domain name as secret. You just need to create a secret named 'DOMAIN_NAME' and fill it 

### 4.5 Provision the AWS certificate wildcard
In this section, we're going to provision the AWS certificate 

1. Go to Actions in your own repo 
2. In the panel, choose "Provision Certificates"
3. Click on "Run workflow". Check "Create a wildcard certificate" if you to create one. Also check "private" if you want it private
4. Click run

### 4.6 Destroy the AWS certificate wildcard (optional)
In this section, we're going to destroy the AWS certificate 

1. Go to Actions in your own repo 
2. In the panel, choose "Destroy Certificates"
3. Click on "Run workflow". Check "Destroy a wildcard certificate" if you created it wildcard. Also check "private" if you have created it private
4. Click run
```

<!-- # 5 Use the certificate in a real life project
I covered this section in another repo
[aws-terraform-frontend](https://github.com/opsforall/aws-terraform-frontend) -->