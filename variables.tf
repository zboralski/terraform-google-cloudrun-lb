# variables.tf

variable "name" {
  description = "Load balancer name."
  type        = string
}

variable "location" {
  description = "Google location where resources are to be created."
  type        = string
}

variable "project" {
  description = "Google project ID."
  type        = string
}

variable "authorized_ip_ranges" {
  description = "List of authorized IP ranges"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "managed_ssl_certificate_domains" {
  description = "List of domains for managed SSL certificate"
  type        = list(string)
  default     = []
}

variable "service" {
  description = "Cloud Run service name."
  type        = string
}

variable "logging_enabled" {
  description = "Whether to enable logging for the load balancer."
  type        = bool
  default     = true
}

variable "logging_sample_rate" {
  description = "The percentage of requests to be logged, as a value between 0.0 and 1.0."
  type        = number
  default     = 1.0
}
variable "use_ssl" {
  description = "Use TLS"
  type    = bool
  default = true
}