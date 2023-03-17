# outputs.tf is used to define the outputs that will be returned by the module.

output "address" {
  value       = google_compute_global_address.service-lb-ip.address
  description = "The IP address of the Cloud Run load balancer."
}
