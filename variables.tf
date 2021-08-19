################################################################################
### MODULE
################################################################################

variable "name" {
  description = "(Required) Name to be used on all the resources provisioned by this module as identifier"
  type        = string
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources deployed by this module"
  type        = map(string)
  default     = {}
}

################################################################################
### TRANSIT GATEWAY (TGW)
################################################################################

variable "amazon_side_asn" {
  description = "(Optional) Private Autonomous System Number (ASN) for the Amazon Side of a BGP Session. Useful for data lookups when declaring a transit gateway attachment."
  default     = 65000
}

variable "description" {
  description = "(Optional) Description for the transit gateway."
  type        = string
  default     = ""
}

variable "enable_auto_accept_shared_attachments" {
  description = "(Optional) Should be true to enable automatic accept cross-account attachments."
  type        = bool
  default     = true
}

variable "enable_default_route_table_association" {
  description = "(Optional) Should be true to enable resource attachments to be automatically associated with the default association route table."
  type        = bool
  default     = true
}

variable "enable_default_route_table_propagation" {
  description = "(Optional) Should be true to enable resource attachments to automatically propagate routes to the default propagation route table."
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "(Optional) Should be true to enable DNS support."
  type        = bool
  default     = true
}

variable "enable_vpn_ecmp_support" {
  description = "(Optional) Should be true to enable VPN Equal Cost Multipath Protocol support."
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "(Required) VPC ID for Transit Gateway VPC Attachment."
  type = string
}

variable "subnet_ids" {
  description = "(Required) List of Subnet IDs for Transit Gateway VPC Attachment"
  type = list(string)
}

variable "route_table_id" {
  description = "(Required) Route Table ID for Transit Gateway Traffic CIDR Routes"
  type = string
}

variable "gateway_traffic_cidrs" {
  description = "(Optional) List of Transit Gateway Traffic CIDR Routes"
  type = list(string)
  default = ["10.0.0.0/8"]
}

################################################################################
### RESOURCE ACCESS MANAGER (RAM)
################################################################################

variable "allow_external_principals" {
  description = "(Optional) Indicates whether principals outside your organization can be associated with a resource share."
  type        = bool
  default     = false
}

variable "principal_organization_arn" {
  description = "(Required) Principal Organization ARN to enable RAM Sharing with AWS Organizations."
  type        = string
}
