
# Hosts.txt

client01 ansible_host=192.168.1.47 ansible_user=root ansible_ssh_private_key_file=/maksym/.ssh/id_rsa

client02 ansible_host=192.168.1.48 ansible_user=root ansible_ssh_private_key_file=/maksym/.ssh/id_rsa




# Check connection to servers

ansible all -i hosts.txt -m ping

![image](https://user-images.githubusercontent.com/49572117/118463796-da003480-b708-11eb-87e4-109934b3d886.png)



# Generate Roles
 
 
ansible-galaxy init java

        ---
        - name: Install Java
        hosts: client02
        tasks:
            - name: Update repos
            apt: 
                name: "*"
                state: latest
            - name: Installing OpenJDK
            apt:
                name: openjdk-8-jdk
                update_cache: yes



ansible-galaxy init nginx

**path: ansible_files/nginx/tasks/main.yml**

    - name: ensure nginx is at the latest version
    apt:
        name: nginx
        state: latest

    - name: start nginx
    service:
        name: nginx
        state: started


# Inventory file
![image](https://user-images.githubusercontent.com/49572117/118483390-9e706500-b71e-11eb-9c93-045c0dab327d.png)


# Playbook with tasks
![image](https://user-images.githubusercontent.com/49572117/116903826-9952e680-ac45-11eb-853c-8c2f116dd91c.png)
# Playbook with tasks
![image](https://user-images.githubusercontent.com/49572117/118482805-e9d64380-b71d-11eb-8a7b-7474f3bdf6bc.png)


# Result 

![image](https://user-images.githubusercontent.com/49572117/118485308-eee8c200-b720-11eb-9579-4dc4010f31a8.png)

# Test command using shell
ansible testgroup -i hosts.txt -m shell -a "uptime"

- m module
- a argument

