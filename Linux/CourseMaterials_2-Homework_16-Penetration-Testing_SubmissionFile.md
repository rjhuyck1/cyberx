## Week 16 Homework Submission File: Penetration Testing 1

#### Step 1: Google Dorking


- Using Google, can you identify who the Chief Executive Officer of Altoro Mutual is:
   Answer: Yes, Karl Fitzgerald

- How can this information be helpful to an attacker:
 Answer: This person could then be spearfished


#### Step 2: DNS and Domain Discovery

Enter the IP address for `demo.testfire.net` into Domain Dossier and answer the following questions based on the results:

  1. Where is the company located:
 Answer: Dallas, TX  

  2. What is the NetRange IP address: 1.
 Answer: 65.61.137.64 – 65.61.137.127

  3. What is the company they use to store their infrastructure:
 Answer: Rackspace

  4. What is the IP address of the DNS server:
 Answer: There was no centralops.net domain dossier available on April 17.
     

#### Step 3: Shodan

- What open ports and running services did Shodan find:
  Answer:  80 443 8080

#### Step 4: Recon-ng

- Install the Recon module `xssed`. 
- Set the source to `demo.testfire.net`. 
- Run the module. 

Is Altoro Mutual vulnerable to XSS: 
  Answer: Yes it is. 

### Step 5: Zenmap

Your client has asked that you help identify any vulnerabilities with their file-sharing server. Using the Metasploitable machine to act as your client's server, complete the following:

- Command for Zenmap to run a service scan against the Metasploitable machine: 
 Answer: nmap -sV -T4 -O -F 192.168.0.10
 
- Bonus command to output results into a new text file named `zenmapscan.txt`:
 Answer: nmap -sV -T4 -O -F -oN zenmapscan.txt 192.168.0.10

- Zenmap vulnerability script command: 
 Answer: nmap --script smb-enum-shares 192.168.0.10
- Once you have identified this vulnerability, answer the following questions for your client:
  1. What is the vulnerability: 
 Answer: smb-enum-shares

  2. Why is it dangerous:
 Answer: This allows anonymous access to network shares

  3. What mitigation strategies can you recommendations for the client to protect their server:
 Answer: They need to upgrade to SMB2 and also assign authentication to the shares.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

