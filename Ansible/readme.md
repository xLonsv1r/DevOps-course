
# Check connection to servers
ansible all -i hosts.txt -m ping



# Generate Roles
ansible-galaxy init apt 

ansible-galaxy init ntp 

ansible-galaxy init monit 

ansible-galaxy init haproxy 
 
ansible-galaxy init java

ansible-galaxy init logstash

ansible-galaxy init elasticsearch

ansible-galaxy init rsyslog

ansible-galaxy init kibana 3.x

ansible-galaxy init nginx





# Inventory file
![hosts.txt](https://user-images.githubusercontent.com/49572117/116903359-fac68580-ac44-11eb-97cd-48b8ad618794.png)

# Playbook with tasks
![image](https://user-images.githubusercontent.com/49572117/116903826-9952e680-ac45-11eb-853c-8c2f116dd91c.png)
# Playbook with taks+role
![image](https://user-images.githubusercontent.com/49572117/116907482-4def0700-ac4a-11eb-92bd-e0a081bc178c.png)


ansible testgroup -i hosts.txt -m shell -a "uptime"

- m module
- a argument