This project demonstrates a complete CI/CD pipeline where application code changes pushed by a developer are automatically built, tested, 
and deployed to an AWS EC2 instance using Jenkins, with NGINX serving the application to end users.
The goal of this project is to showcase real-world DevOps practices, including automation, continuous integration, 
continuous deployment, and cloud infrastructure usage.

*🧱 Architecture Diagram*
<img width="1536" height="1024" alt="Image" src="https://github.com/user-attachments/assets/aa20ab74-76d4-438b-9332-a06f3ea771d1" />

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

<img width="1616" height="554" alt="Image" src="https://github.com/user-attachments/assets/d2315e11-70d1-4bfe-bd5d-1ecf6a5bac3a" />

Verify Security Group

<img width="1806" height="868" alt="Image" src="https://github.com/user-attachments/assets/e57a6c6f-8893-48df-9e59-2f434b27ec90" />

Connect your ec2 instance to your local machine thorugh ssh use your key-pair .pem 
to connect your ec2 instance use this command before ssh give that file to 400 permission.
For permission

`chmod 400 "three-tier-architecture.pem"`

For ssh

`ssh -i "pathof_your_.pem_key" ubuntu@ec2<PublicIPofEc2Instance>.ap-south-1.compute.amazonaws.com`

<image 4>

************ Install and Set up nginx ************ 

Step 1: Update & Upgrade the System

``sudo apt update
sudo apt upgrade -y``

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

 <img width="1079" height="378" alt="Image" src="https://github.com/user-attachments/assets/accecec7-30d9-4bde-9a6a-22c3acb7bfab" />
 
  B. Verify Default Web Directory
  
   `ls /var/www/html`
   
(Default index.html file should exist)

  C. Access NGINX in Browser
Copy the Public IP of your EC2 instance
Open browser and visit:

   `http://<PublicIp>`

<img width="1418" height="764" alt="Image" src="https://github.com/user-attachments/assets/119a84b0-7e5b-4c51-9f80-4a8903da9045" />


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

You can use official Documentation for jenkins Installation [https://www.jenkins.io/doc/book/installing/linux/#debianubuntu](url).

Step 4: Start & Enable Jenkins Service

`sudo systemctl start jenkins`

`sudo systemctl enable jenkins`

Step 6: Verify Jenkins Installation

  A. Check Jenkins Status
  
  `sudo systemctl status jenkins
  `
  
  (Status should be active (running))
  <img width="837" height="413" alt="Image" src="https://github.com/user-attachments/assets/856ff555-03a3-4ce9-b69c-5907d4610f05" />

 B. Access Jenkins Dashboard
  Copy EC2 Public IP
  Open browser and visit:
  
  `
  http://<EC2-Public-IP>:8080
  `
  
<img width="1495" height="997" alt="Image" src="https://github.com/user-attachments/assets/33101b2b-bd8b-497a-bece-923bdaef4200" />
Step 7: Unlock Jenkins

`
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
`

Copy the password

Paste it into Jenkins UI

Install Suggested Plugins

Create Admin User

<img width="1534" height="984" alt="Image" src="https://github.com/user-attachments/assets/4f623544-7678-450e-ac1c-f013810c9b81" />

<img width="1026" height="927" alt="Image" src="https://github.com/user-attachments/assets/4d5096cf-b031-4052-af37-fd12ac67c765" />

Step 1: Create a New Jenkins Job

Open Jenkins Dashboard

Click New Item

Enter job name (e.g., website-Pipeline)

Enable GitHub Trigger (GitHub hook trigger for GITScm polling)

Select Pipeline script from SCM

Take a Look for Refrence

<img width="1682" height="988" alt="Image" src="https://github.com/user-attachments/assets/4cc0352c-9bf9-410b-b02e-d68535f8628a" />

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

<img width="1542" height="982" alt="Image" src="https://github.com/user-attachments/assets/91bd5f2b-25f5-45c1-83f3-ebeef336f236" />

Step 3: Verify Webhook

Make a code push to the repository

Go to Webhooks → Recent Deliveries

Ensure response status is 200 OK

<img width="1297" height="371" alt="Image" src="https://github.com/user-attachments/assets/493807d8-2dc4-4c43-890d-abfe0724ca98" />

Final Result 

<img width="1640" height="951" alt="Image" src="https://github.com/user-attachments/assets/53e70f0d-8d00-4249-a926-7216a55bde2b" />
