# 1.1 Create ubuntu with packer 

## Packer ubuntu-18.04-vagrant.json

    {
    "builders": [
        {
            "type": "virtualbox-iso",
            "boot_command": [
				"<esc><wait>",
                "<esc><wait>",
                "<enter><wait>",
                "/install/vmlinuz<wait>",
                " auto<wait>",
                " console-setup/ask_detect=false<wait>",
                " console-setup/layoutcode=us<wait>",
                " console-setup/modelcode=pc105<wait>",
                " debconf/frontend=noninteractive<wait>",
                " debian-installer=en_US<wait>",
                " fb=false<wait>",
                " initrd=/install/initrd.gz<wait>",
                " kbd-chooser/method=us<wait>",
                " keyboard-configuration/layout=USA<wait>",
                " keyboard-configuration/variant=USA<wait>",
                " locale=en_US<wait>",
                " netcfg/get_domain=vm<wait>",
                " netcfg/get_hostname=vagrant<wait>",
                " grub-installer/bootdev=/dev/sda<wait>",
                " noapic<wait>",
                " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>",
                " -- <wait>",
                "<enter><wait>"
            ],
            "boot_wait": "10s",
            "disk_size": 81920,
            "guest_os_type": "Ubuntu_64",
            "headless": false,
            "http_directory": "http",
            "iso_urls": [
            "D:\\itransitionISO\\ubuntu-18.04-server-amd64.iso",
			"http://old-releases.ubuntu.com/releases/18.04.4/ubuntu-18.04-server-amd64.iso"
            ],
            "iso_checksum": "a7f5c7b0cdd0e9560d78f1e47660e066353bb8a79eb78d1fc3f4ea62a07e6cbc",
            "ssh_username": "vagrant",
            "ssh_password": "vagrant",
            "ssh_port": 22,
            "ssh_wait_timeout": "10000s",
            "shutdown_command": "echo 'vagrant'|sudo -S shutdown -P now",
            "guest_additions_path": "VBoxGuestAdditions_{{.Version}}.iso",
            "virtualbox_version_file": ".vbox_version",
            "vm_name": "packer-ubuntu-18.04-amd64",
            "vboxmanage": [
            [
                "modifyvm",
                "{{.Name}}",
                "--memory",
                "1024"
            ],
            [
                "modifyvm",
                "{{.Name}}",
                "--cpus",
                "1"
            ]
            ]
        }
    ],
    "provisioners": [{
      "type": "shell",
      "scripts": [
        "scripts/init.sh",
        "scripts/cleanup.sh"
      ]
    }],
    "post-processors": [{
      "type": "vagrant",
      "output": "ubuntu-18.04-{{.Provider}}.box"
    }]
    }

# Docker

## 1.6 Work with Docker

Start nginx container from dockerHub.

Command: docker run -d -p 8080:80 --name web nginx
![image](https://user-images.githubusercontent.com/49572117/113869475-71dd3b00-97b9-11eb-8f10-7ca128d21d70.png)

docker run --name mysql-test -v my-vol:/app -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql

docker run --name mysql-test -v $(pwd)/mysql_volume:/mysql_volume -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql


docker exec -ti c693dd98ca25 bash -  connect to container


mysql -u root -p  - connect to mysql


## 1.7 Work with Dockerfile


Dockerfile:

    FROM ubuntu:20.04
    # Install Ruby.
    RUN \
    apt-get update && \
    apt-get install -y ruby
    CMD ruby -v

docker run -i -t 465746e86b74 bash 


CMD will execute command and then die 

    FROM ubuntu:20.04
    # Install Ruby.
    RUN \
    apt-get update && \
    apt-get install -y ruby
    CMD bash

Using thid Dockerfile we can execute bash

docker run 8080bebf0798  it will execute cmd from dockerfile


OR 

    FROM ubuntu:20.04
    # Install Ruby.
    RUN \
    apt-get update && \
    apt-get install -y ruby

and the use docker run -i -t 465746e86b74 bash    



docker start -i fdf71e55b27c


docker build -t xlonsv1r/ruby:v1 . - will build Dockerfile in . directory



# KUBERNETES


## namespace 
        {
        "apiVersion":"v1",
        "kind":"Namespace",
        "metadata": {
            "name": "production",
            "labels": {

            "name": "production"
            }
          }
        }

        
## deployment

nginx-production.yaml

    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: nginx-deployment
    labels:
        app: nginx
    spec:
    replicas: 3
    selector:
        matchLabels:
        app: nginx
    template:
        metadata:
        labels:
            app: nginx
        spec:
        containers:
        - name: nginx
            image: nginx:1.14.2
            ports:
            - containerPort: 80


![image](https://user-images.githubusercontent.com/49572117/115464839-5866d500-a236-11eb-8f1f-78eaa59fbc2c.png)
![image](https://user-images.githubusercontent.com/49572117/115464902-72a0b300-a236-11eb-85a7-5063af3aee44.png)
![image](https://user-images.githubusercontent.com/49572117/115465028-9fed6100-a236-11eb-8952-66cf7c3d8faf.png)