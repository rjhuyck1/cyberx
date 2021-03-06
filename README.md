# cyberx## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Azure Cloud Diagram](Diagrams/Bob_Huyck_Cloud_Network.jpeg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  [Ansible Files](Ansible/)

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
By restricting access to the load balancer front end with Network Security Group settings (limiting HTTP access from a specific IP address range to the Load Balancer) we are able to control access, while at the same time ensuring high availability in the event one of the web servers stops responding.
By utiizing a Jump Box, we are able to limit access from a specific IP host to a single public IP. From this point, access to the internal webservers can be initiated only via SSH, and using public key authentication from the Jump Box container.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the docker and system metrics.
- In our implementation of filebeat, we monitored system logs
- Metricbeat takes metrics and statistics from the monitored servers and ships them to output in Kibana

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | IP Address | Operating System | Public IP    |
|----------|----------|------------|------------------|--------------|
| Jump Box | Gateway  | 10.0.0.7   | Linux            | 13.91.224.32 |
| Web-1    | DVWA     | 10.0.0.9   | Linux            |
| Web-2    | DVWA     | 10.0.0.10  | Linux            |  
| Web-3    | DVWA     | 10.0.0.11  | Linux            |    
| ElkServer| ElkStack | 10.1.0.4   | Linux            |20.190.12.186 |
### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Student PC public IP address

Machines within the network can only be accessed by Jump Box Ansible docker container.
- The ELK server is in another region, using a different virtual internal network. Its access is also only allowed from the Jump Box Ansible docker container. The public key of the Ansible container is used for SSH access.

A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible   | Allowed IP Addresses        |
|-----------    |-----------------------|-----------------------------|
| Jump Box      | Yes                   | Only Student Home Public IP |
| Elk Server    | Only on port 5601     | Only Student Home Public IP |
| Load Balancer | Only on port 80       | Only Student Home Public IP |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- By automating tasks, we are able to duplicate the same installs on multiple machines, and are also able to avoid any user errors.

The playbook implements the following tasks:
- Install docker.io
- Install python3-pip
- Install docker using pip
- Increase virtual memory
- Download and launch a docker web container
- Enable and run docker service


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![docker ps](Diagrams/docker-ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1, Web-2, Web-3

We have installed the following Beats on these machines:
- Filebeat, Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat is configured to ship system logs to the ELK server. These logs can then be viewed and analyzed in Kibana
- Metricbeat is configured to send docker metrics to the ELK server. This data can then be graphed and viewed in Kibana

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the ansible.cfg file to /etc/ansible
- Update the hosts file to include  webservers section with their IP addresses and python interpreter
- 10.0.0.9 ansible_python_interpreter=/usr/bin/python3
- 10.0.0.10 ansible_python_interpreter=/usr/bin/python3
- 10.0.0.11 ansible_python_interpreter=/usr/bin/python3
- Then add an elk section, using this info
- 10.1.0.4 ansible_python_interpreter=/usr/bin/python3
- Run the playbook, and ssh to Web servers and ELK server to check that the installation worked as expected. Alternately, you can also check the status by opening URL to ELK server, and opening HTTP port 80 to load balancer IP address. If the DVWA web page opens, then shut down individual VMs and verify they are all working.

Their are several ansible playbooks. They are located in /etc/ansible/roles
- filebeat-playbook.yml  
- install-elk.yml  
- metricbeat-playbook.yml  
- pentest.yml

In order to control which servers to run specific playbooks against, the /etc/ansible/hosts file 
In order to check if the ELK server is running open the following URL: 20.190.12.186:5601/app/kibana#/home

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
