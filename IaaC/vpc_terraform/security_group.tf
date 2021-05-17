
provider "aws" {
    region = "eu-west-1"
}


resource "aws_vpc" "first-vpc" {
  cidr_block = "10.0.0.0/16"
  tags ={
      Name = "prodvpc"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.first-vpc.id
  tags = {
    Name = "first-vpc-gateway"
  }
}

#------------------------------------------


#-------------------------------------------
resource "aws_subnet" "public_subnet_A"{
    vpc_id = aws_vpc.first-vpc.id
    availability_zone = "eu-west-1a"
    cidr_block = "10.0.11.0/24"
    tags = {
        Name = "public_subnet_A"
    }
}

resource "aws_subnet" "private_subnet_A"{
    vpc_id = aws_vpc.first-vpc.id
    availability_zone = "eu-west-1a"
    cidr_block = "10.0.12.0/24"
    tags = {
        Name = "private_subnet_A"
    }
}


resource "aws_subnet" "public_subnet_B"{
    vpc_id = aws_vpc.first-vpc.id
    availability_zone = "eu-west-1b"
    cidr_block = "10.0.101.0/24"
    tags = {
        Name = "public_subnet_B"
    }
}

resource "aws_subnet" "private_subnet_B"{
    vpc_id = aws_vpc.first-vpc.id
    availability_zone = "eu-west-1b"
    cidr_block = "10.0.102.0/24"
    tags = {
        Name = "private_subnet_B"
    }
}

# -------------------------------------- Security Group

 resource "aws_security_group" "web-sg" {
   name        = "web-sg"
   description = "public internet access"
   vpc_id      = aws_vpc.first-vpc.id
 
   tags = {
     Name = "web-sg",
   }
 }

resource "aws_security_group_rule" "web-sg-ssh-rule"{
    type = "ingress"
    security_group_id = aws_security_group.web-sg.id
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks       = ["46.219.209.244/32"]

}

resource "aws_security_group_rule" "web-sg-http-rule"{
    type = "ingress"
    security_group_id = aws_security_group.web-sg.id
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks       = ["46.219.209.244/32"]

}


#--------------------------------------- Network interface for EC2

resource "aws_network_interface" "nt_interface_a" {
  subnet_id   = aws_subnet.public_subnet_A.id
  private_ips = ["10.0.11.10"]

  # security group
  # security_groups = [aws_security_group.web.id]


  tags = {
    Name = "public_network_interface_A"
  }
}


resource "aws_network_interface" "nt_interface_b" {
  subnet_id   = aws_subnet.public_subnet_B.id
  private_ips = ["10.0.101.10"]

  # security group
  # security_groups = [aws_security_group.web.id]

  tags = {
    Name = "public_network_interface_B"
  }
}


# -------------------------------------- EC2


resource "aws_instance" "server_a" {
  ami           = "ami-0943382e114f188e8"
  instance_type = "t2.micro"

  key_name = "ssh_key"
  network_interface {
    network_interface_id = aws_network_interface.nt_interface_a.id
    device_index = 0
  }

  tags = {
    Name = "ExampleAppServerInstance"
  }
}


resource "aws_instance" "server_b" {
  ami           = "ami-0943382e114f188e8"
  instance_type = "t2.micro"
  key_name = "ssh_key"

  network_interface {
    network_interface_id = aws_network_interface.nt_interface_b.id
    device_index = 0
  }


  tags = {
    Name = "ExampleAppServerInstance"
  }
}


#-------------------------------------- ELB Elastic Load Balancer

#-------------------------------------- RDS

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

#-------------------------------------- ElasticCache
resource "aws_elasticache_cluster" "memcached_cluster" {
  cluster_id           = "cluster-example"
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 2
  parameter_group_name = "default.memcached1.4"
  port                 = 11211
  security_group_ids = []
}

resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  security_group_ids = []
}

# -----------------------------------------
# resource "aws_security_group" "web-sg" {
#   name        = "web-sg"
#   description = "public internet access"
#   vpc_id      = aws_vpc.main.id

  
#   tags = {
#     Name = "web-sg",
#     Role = "public"
#   }
# }

