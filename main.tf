components=["frontend","catalogue","cart","user","shipping","payment","dispatch"]

resource "aws_instance" "instance" {
  count = length(var.components)
  ami = "ami-0d035b0fa9820ac92"
  vpc_security_group_ids = [ "sg-00c013ec026e3f8e2" ]
  instance_type = "t3.micro"
  tags = {
    Name = element(var.components,count.index)
  }

}

resource "aws_route53_record" "record" {
  count    = length(var.components)
  name    = var.components[count.index]
  zone_id = "Z047712533ZBGAR3UXSLX"
  type = "A"
  records = [aws_instance.instance[count.index].private_ip]
  ttl = 3
}