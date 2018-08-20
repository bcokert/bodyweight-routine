variable "env" {
  description = "One of dev/production"
}

variable "vpc_region" {}
variable "vpc_cidr" {}

variable "subnet_cidrs" {
  type = "map"
}

variable "ports" {
  type = "map"

  default = {
    ssh = 22
  }
}

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "bodyweight-routine-${var.env}"
  }
}

resource "aws_subnet" "b" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.subnet_cidrs["b"]}"
  availability_zone = "${var.vpc_region}b"

  tags {
    Name = "bodyweight-routine-${var.env}"
  }
}

resource "aws_subnet" "d" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.subnet_cidrs["d"]}"
  availability_zone = "${var.vpc_region}d"

  tags {
    Name = "bodyweight-routine-${var.env}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "bodyweight-routine-${var.env}"
  }
}

resource "aws_default_route_table" "main" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "bodyweight-routine-${var.env}"
  }
}

resource "aws_security_group" "webserver" {
  name        = "bodyweight-routine-webserver-${var.env}"
  description = "Webserver security group"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = "${var.ports["http"]}"
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "bodyweight-routine-${var.env}"
  }
}

resource "aws_security_group" "ssh" {
  name        = "bodyweight-routine-ssh-${var.env}"
  description = "Allow ssh access for provisioning from specific networks"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = "${var.ports["ssh"]}"
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "bodyweight-routine-${var.env}"
  }
}

resource "aws_default_network_acl" "main" {
  default_network_acl_id = "${aws_vpc.main.default_network_acl_id}"

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "bodyweight-routine-${var.env}"
  }
}

output "subnet_ids" {
  value = {
    b = "${aws_subnet.b.id}"
    d = "${aws_subnet.d.id}"
  }
}

output "webserver_security_group_id" {
  value = "${aws_security_group.webserver.id}"
}

output "ssh_security_group_id" {
  value = "${aws_security_group.ssh.id}"
}
