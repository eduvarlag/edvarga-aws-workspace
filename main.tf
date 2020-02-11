resource "aws_instance" "${tfCodeId}" { 
  ami                     = "ami-40d28157" 
  instance_type           = "t2.micro" 
}
