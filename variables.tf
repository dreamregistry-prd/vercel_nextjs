
variable "dream_env" {
  description = "dream app environment variables to set"
  type    = map(string)
  default = {}
}

variable "dream_project_dir" {
  description = "root directory of the project sources"
  type = string
}