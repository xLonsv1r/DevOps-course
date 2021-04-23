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
1. Создайте папку для проекта и перейдите в нее.
2. Установите докер на машину.
3. Запустите контейнер с nginx скачаный из docker hub. Контейнер должен быть запущен из командной строки с параметром –expose или -p для того чтобы после запуска стартовая страница nginx была доступна из браузера вашего компьютера.
    
    **docker run -d -p 8080:80 --name web nginx**
    ![image](https://user-images.githubusercontent.com/49572117/113869475-71dd3b00-97b9-11eb-8f10-7ca128d21d70.png)


4. Запустите контейнер с MySQL скачаный из докер хаба, используйте --volume , -v при запуске контейнера для того чтобы сохранить базу данных жестком диске хоста.

    
    **docker run --name mysql-test -v $(pwd)/mysql_volume:/mysql_volume -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql**

5. После запуска контейнера подключитесь к базе, создайте нового польщователя и новую базу.

    **docker exec -ti c693dd98ca25 bash** -  connect to container


    **mysql -u root -p**  - connect to mysql
![image](https://user-images.githubusercontent.com/49572117/115874863-4a3ed180-a44d-11eb-9c91-2643c50b6977.png)
![image](https://user-images.githubusercontent.com/49572117/115875298-bcafb180-a44d-11eb-97b2-65a7cb1829e8.png)
![image](https://user-images.githubusercontent.com/49572117/115875364-ce915480-a44d-11eb-92ec-146f2691db86.png)
![image](https://user-images.githubusercontent.com/49572117/115875419-de109d80-a44d-11eb-8ae5-1af2b1e59cb6.png)
![image](https://user-images.githubusercontent.com/49572117/115875462-e79a0580-a44d-11eb-9e51-a08b41e77498.png)
![image](https://user-images.githubusercontent.com/49572117/115875489-ee287d00-a44d-11eb-9205-9a281d50e7be.png)
![image](https://user-images.githubusercontent.com/49572117/115875511-f680b800-a44d-11eb-8298-5c9d57cce1e5.png)
![image](https://user-images.githubusercontent.com/49572117/115875589-0a2c1e80-a44e-11eb-91c7-2267f991d66d.png)
![image](https://user-images.githubusercontent.com/49572117/115875638-1912d100-a44e-11eb-8527-4089f0329d0c.png)
## 1.7 Work with Dockerfile


1. Создайте файл Dockerfile в корневой папке проекта. 
В качестве базового образа используйте Ubuntu 20.04
2. Дополните Dockerfile инструкциями из которого при выполнении команды docker build соберется docker образ с установленым Ruby 2.7.2

        FROM ubuntu:20.04
                # Install Ruby.
        RUN \
            apt-get update && \
            apt-get install -y ruby
        CMD ruby -v
3. После успешной сборки образа, запустите контейнер для выполнения команды 
ruby -v, для проверки работоспособности ruby.


![image](https://user-images.githubusercontent.com/49572117/115879664-97717200-a452-11eb-81c8-639d358a31d3.png)


## Work with Docker Compose

1. Установите docker-compose на хост
2. С помощью docker-compose установите и запустите сайт на Wordpress.
По мимо docker-compose.yml файла у вас могут быть другие файлы необхдимые для работы Wordpress, например nginx.conf и другие.

        version: '3.3'
        services:
        wordpress:
            image: wordpress:latest
            restart: always
            links:
            - db:mysql
            ports:
            - "8080:80"
            working_dir: /var/www/html
            volumes:
            - "/opt/wp-content:/var/www/html/wp-content"
            environment:
            WORDPRESS_DB_HOST: db:3306
            WORDPRESS_DB_USER: wordpress
            WORDPRESS_DB_PASSWORD: wordpress
            WORDPRESS_DB_NAME: wordpress 
        db:
            image: mysql:5.7
            restart: always
            volumes:
            - "/opt/mysql:/var/lib/mysql"
            environment:
            MYSQL_ROOT_PASSWORD: secret
            MYSQL_DATABASE: wordpress
            MYSQL_USER: wordpress
            MYSQL_PASSWORD: wordpress

![image](https://user-images.githubusercontent.com/49572117/115880967-f1266c00-a453-11eb-97c1-de30e847878e.png)
![image](https://user-images.githubusercontent.com/49572117/115881070-09968680-a454-11eb-997a-08234ca751aa.png)
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