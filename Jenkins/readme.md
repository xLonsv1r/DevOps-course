
**1. Установить Jenkins или Teamcity server. Это может быть установка на ваш локальный компьютер или на инстансе в облаке, это не имеет значение, как не имеет значение и метод уставки (с использованием docker контейнера, playbook или установка вручную из репзитория и пр.).**

# Install using docker container
    docker pull jenkins/jenkins

    docker run -p 8080:8080 --name=jenkins-master -d jenkins/jenkins

    docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
    
    docker rm jenkins-master

## Install using packages
    1. wget -q   -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    2. sudo nano /etc/apt/sources.list3. #Add next string after last row in the editing file deb https://pkg.jenkins.io/debian-stable binary/#And save changes
    4. sudo apt-get update
    5. java -version
    6. sudo apt-get install openjdk-8-jdk
    7. sudo apt-get install jenkins
    8. service jenkins status
    9. sudo cat /var/lib/jenkins/secrets/initialAdminPassword

    
## Give permissions jenkins to docker

    1) sudo -u jenkins /bin/bash

    2) usermod -a -G docker jenkins


2. Создать новый проект “Staging”, в нем добавить задачу для сборки простого приложения, например 

    a) net: https://github.com/chaitalidey6/HelloWorldAspNetCore/tree/master/HelloWorldAspNetCore

    b.	Java: https://github.com/jenkins-docs/simple-java-maven-app

    c.	Node JS: https://github.com/jenkins-docs/simple-node-js-react-npm-app 
    
    *Замечания:*
    
    o Вы можете использовать любое привычное приложение на любом языке (.net, java, js, python, php).
    
    o	Код приложения должен быть размещен в вашем собственном git-репозитории.
    
    o	Должна использоваться ветка “staging”.
    
    **git checkout -b staging**

    **sudo docker run -p 5000:5000 -d a2c**

    o	Приложение может быть собрано в контейнере (предпочтительный способ).
            
        FROM python:3.8
        WORKDIR /code
        COPY requirements.txt .
        RUN pip install -r requirements.txt
        COPY src/ .
        CMD [ "python", "./server.py" ]

    o	Задача по сборке должна запускаться с параметрами.
    
    ![image](https://user-images.githubusercontent.com/49572117/118539048-9da7f500-b757-11eb-8067-adb6e47017d1.png)

    o	Результатом сборки обязательно должен быть артифакт (архив, docker-контейнер), который вы дальше будете использовать.

    https://hub.docker.com/repository/docker/xlonsv1r/python_docker

    o	Необходимо самостоятельно подумать над тем, каким образом Jenkins/TeamCity получит доступ к git-репозиторию, при этом необходимо придумать наиболее безопасный на ваш вгляд способ.

    ![image](https://user-images.githubusercontent.com/49572117/118401678-3a429800-b66f-11eb-86f2-a217d57de2c0.png)


3. Создать задачу в Jenkins /Teamcity для деплоя вашего артифакта на сервер и перезапуск приложения.
    Замечания:
    
    o	Здесь артефакт может доставляться на удаленный сервер (например, на EC2 инстанс в AWS), либо на контейнер (при работе локально в Docker), либо на локальный сервер (при работе с Vagrant/VirtualBox).
    
    o	Необходимо самостоятельно подумать над тем, каким образом будет организован доступ из Jenkins/Teamcity на сервер (дря загрузки артефактов), при этом необходимо придумать наиболее безопасный на ваш вгляд способ.


4. Настроить зависимость задачи деплоя от задачи сборки.


5. Настроить деплой артифакта в место где он будет работать и запуск приложения.

    sudo docker run -p 5000:5000 -d xlonsv1r/python_docker:latest


6.	Добавить задачу создания бэкапа артефактов на сервере.

![image](https://user-images.githubusercontent.com/49572117/118401831-dff60700-b66f-11eb-96a8-3a17959cc60e.png)
![image](https://user-images.githubusercontent.com/49572117/118524376-c247a100-b746-11eb-8719-0b133f141337.png)

7.	Настроить пайплайн, где должны быть включены шаги: сборка, бэкап и деплой (опционально: тестирование).


![image](https://user-images.githubusercontent.com/49572117/118530061-e27a5e80-b74c-11eb-9af5-7f684d1c4eeb.png)


8.	Настроить автоматический запуск деплоя при добавлении нового commit’а в ветке “staging” git.
    * При запуске локально – здесь могут быть проблемы с настройкой webhook, потому используйте другой метод взаимодействия с git.

![image](https://user-images.githubusercontent.com/49572117/118401887-23e90c00-b670-11eb-9412-51912b652dd2.png)
![image](https://user-images.githubusercontent.com/49572117/118401922-424f0780-b670-11eb-97e7-127d73c0b37b.png)

9.	Создать новый проект “Production”, добавить задачу для сборки приложения, выполнить те же настройки, что и в Staging (п. 2), но с небольшими изменениями: должна использоваться ветка “master”.

10.	Создать задачу для деплоя Production артефактов на сервер (здесь может использоваться тот же сервер, но приложения должны быть различными: «висеть» на разных портах или под разными доменами).

11.	Настроить зависимость задачи деплоя от задачи сборки.

12.	Настроить автоматический запуск деплоя при подтверждении pull request’а в ветке “master” в git.



![image](https://user-images.githubusercontent.com/49572117/118538889-6c2f2980-b757-11eb-8fa6-25ace9369dd7.png)

![image](https://user-images.githubusercontent.com/49572117/118538996-8f59d900-b757-11eb-8ea2-9303bbd86a1c.png)
