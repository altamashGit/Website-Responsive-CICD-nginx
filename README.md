This project demonstrates a complete CI/CD pipeline where application code changes pushed by a developer are automatically built, tested, 
and deployed to an AWS EC2 instance using Jenkins, with NGINX serving the application to end users.
The goal of this project is to showcase real-world DevOps practices, including automation, continuous integration, 
continuous deployment, and cloud infrastructure usage.

*🧱 Architecture Diagram*
<1>

********************************
🛠️ Tech Stack Used
Version Control: Git & GitHub
CI/CD Tool: Jenkins
Cloud Provider: AWS
Compute Service: EC2
Web Server: NGINX
Automation Trigger: GitHub Webhooks
OS: Linux (Amazon Linux / Ubuntu)

**************************************
🔄 CI/CD Workflow Explanation

Developer writes or updates code locally.
Code is pushed to the GitHub repository.
GitHub Webhook automatically triggers Jenkins.
Jenkins Pipeline:
Pulls the latest code from GitHub
Builds the application
Deploys it to the EC2 instance
NGINX serves the deployed application.
Users access the application via public IP / DNS.

***********************************

*STEPS*
1. Launch EC2 Instance
2. Install and Set up nginx
3. Install and set up of Jenkins
4. Create Jenkins Pipeline 
5. Configure GitHub Webhook
6. Deploy Application via NGINX

************   Launch EC2 Instance  ************
Step 1: Launch EC2 Instance

1. Launch an EC2 instance (Ubuntu).
2. Create Key pair (login)
3. Instance type (t2.medium)
4. Configure Security Group:
	22 – SSH
	80 – HTTP
	8080 – Jenkins
After launch Instance wait for Instance status it should be Running and instance
health check should green and 2/2 passed.
<Image 2 >

Verify Security Group
<Image 3>

Connect your ec2 instance to your local machine thorugh ssh use your key-pair .pem 
to connect your ec2 instance use this command before ssh give that file to 400 permission.
For permission
`chmod 400 "three-tier-architecture.pem"`
For ssh
`ssh -i "pathof_your_.pem_key" ubuntu@ec2<PublicIPofEc2Instance>.ap-south-1.compute.amazonaws.com`
<image 4>

************ Install and Set up nginx ************ 

Step 1: Update & Upgrade the System
`sudo apt update`
`sudo apt upgrade -y`

Step 2: Install NGINX
`sudo apt install nginx -y`

Step 3: Start & Enable NGINX Service
`sudo systemctl start nginx`
`sudo systemctl enable nginx`

(Optional: Restart if needed)
`sudo systemctl restart nginx`
 
Step 4: Verify NGINX Installation
  A. Check NGINX Service Status
    `sudo systemctl status nginx`
(Status should be active (running))
  <Image 5>
  B. Verify Default Web Directory
   `ls /var/www/html`
(Default index.html file should exist)

  C. Access NGINX in Browser
Copy the Public IP of your EC2 instance
Open browser and visit:

   `http://<PublicIp>`

 <Image 6>

************   Install and set up of Jenkins  ************
Step 1: Install Java (Jenkins Dependency)

`sudo apt install openjdk-17-jdk -y
`
Verify Java installation:
`java -version
`
Step 2: Add Jenkins Repository & Key
`curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null`

`echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
`

Step 3: Install Jenkins
`
sudo apt update
sudo apt install jenkins -y
`
You can use official Documentation for jenkins Installation.

Step 4: Start & Enable Jenkins Service
`
sudo systemctl start jenkins
sudo systemctl enable jenkins
`
Step 6: Verify Jenkins Installation
  A. Check Jenkins Status
  `sudo systemctl status jenkins
  `
  (Status should be active (running))
  <Image 7>

 B. Access Jenkins Dashboard
  Copy EC2 Public IP
  Open browser and visit:
  `
  http://<EC2-Public-IP>:8080
  `
  <Image 8>
Step 7: Unlock Jenkins
`
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
`
Copy the password
Paste it into Jenkins UI
Install Suggested Plugins
Create Admin User

<Image 9-10>

Step 1: Create a New Jenkins Job
Open Jenkins Dashboard
Click New Item
Enter job name (e.g., website-Pipeline)
Enable GitHub Trigger (GitHub hook trigger for GITScm polling)
Select Pipeline script from SCM
Take a Look for Refrence
< Image 11>

*********** Configure GitHub Webhook ***********
Step 1: Open GitHub Repository
Go to your GitHub Repository
Navigate to Settings → Webhooks
Click Add webhook
Step 2: Add Webhook Details
Fill in the following fields:
`
http://<EC2-Public-IP>:8080/github-webhook/
`
<Image 12>

Step 3: Verify Webhook
Make a code push to the repository
Go to Webhooks → Recent Deliveries
Ensure response status is 200 OK
<Image 13>

Final Result 

<Final Image>
