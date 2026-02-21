variable "sia" {
  description = "The SIA (Service Instance Alias) for the deployment"
  type        = string
}

variable "irn" {
  description = "The IRN (Internal Resource Name) for the deployment"
  type        = string
}

variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The cloud region where resources will be deployed"
  type        = string
  default     = "europe-west1" 
}

variable "cluster_name" {
  description = "The Kubernetes cluster name"
  type        = string
}
