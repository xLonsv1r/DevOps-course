1.	Вам необходимо развернуть две виртуальные машины Azure с именами VMLU01 и VMLU02 на основе образа Ubuntu. Развертывание должно соответствовать следующим требованиям: Обеспечение SLA 99,95%.Использование managed disks.
![image](https://user-images.githubusercontent.com/49572117/117325812-bed82e00-ae99-11eb-9a05-5db2e2852fef.png)

## Нам не подходит стандартный HDD и стандартный SSD
![image](https://user-images.githubusercontent.com/49572117/117326458-563d8100-ae9a-11eb-8661-cab982db3fba.png)
![image](https://user-images.githubusercontent.com/49572117/117327094-eb407a00-ae9a-11eb-8d23-87600ac78ff5.png)
![image](https://user-images.githubusercontent.com/49572117/117327796-acf78a80-ae9b-11eb-8c31-4cbceb570ac3.png)
2.	Вы планируете забэкапить файлы и документы с on-premise Windows file server в хранилище Azure. Бэкап файлы будут храниться в виде блобов.
Вам необходимо создать storage account с именем CorpStorage01. Решение должно соответствовать следующим требованиям:

* Убедитесь, что документы доступны через drive mapping  c виртуальных машин Azure под управлением Windows Server.
* Обеспечьте максимально возможное redundancy документов.
* Минимизируйте затраты на storage account.

3.	Вы планируете развернуть Application Gateway с именем AppGw01 для балансировки нагрузки внутреннего IP-трафика на виртуальные машины Azure, подключенных к subnet0.
Вам необходимо настроить виртуальную сеть с именем VNET01 для поддержки Application Gateway.

4.	Вы планируете разместить несколько защищенных веб-сайтов на Web01. Вам необходимо разрешить HTTPS через TCP-порт 443 на Web01 и запретить HTTP через TCP-порт 80 на Web01.

https://docs.microsoft.com/en-us/azure/virtual-network/tutorial-filter-network-traffic

https://www.youtube.com/watch?v=z7ZA0s398oE

5.	Вам нужно создать веб-приложение с именем WabApp01, которое можно горизонтально скалировать. Решение должно использовать самый низкий возможный ценовой уровень app Service Plan.