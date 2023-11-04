# string
variable "instamce" {
  description = "the is a ec2"
  type        = string
  default     = "t2.micro"
}

# number

variable "number_of_instance" {
  description = "number of instance"
  type        = number
  default     = 1
}

# bool

variable "eneable_elastic_ip" {
  description = "associated any public ip"
  type        = bool
  default     = false

}

# list variable

variable "user_name" {
  description = "the the example of list"
  type        = list(string)
  default     = ["sagar", "sagar1", "sagar2"]

}



# map variable
variable "project_enverment" {
  description = "the is a map variable"
  type        = map(string)
  default = {
    project     = "project1"
    environment = "dev"
  }

}
