###############################################################################
### TRANSIT GATEWAY (TGW)
###############################################################################

# TRANSIT GATEWAY
resource "aws_ec2_transit_gateway" "main" {
  description                     = var.description
  amazon_side_asn                 = var.amazon_side_asn
  default_route_table_association = var.enable_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.enable_default_route_table_propagation ? "enable" : "disable"
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments ? "enable" : "disable"
  vpn_ecmp_support                = var.enable_vpn_ecmp_support ? "enable" : "disable"
  dns_support                     = var.enable_dns_support ? "enable" : "disable"

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-tgw",
        var.name,
      )
    },
    var.tags,
  )
}

# TRANSIT GATEWAY VPC ATTACHMENT
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = var.vpc_id
}

# TRANSIT GATEWAY TRAFFIC CIDR ROUTES
resource "aws_route" "main" {
  for_each = toset(var.gateway_traffic_cidrs)

  route_table_id         = var.route_table_id
  destination_cidr_block = each.value
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
}

#######################################
# OUTPUTS
#######################################

output "tgw_id" {
  description = "The ID of the Transit Gateway"
  value       = [aws_ec2_transit_gateway.main.id]
}

output "tgw_arn" {
  description = "The ARN of the Transit Gateway"
  value       = [aws_ec2_transit_gateway.main.arn]
}

output "tgw_owner_id" {
  description = "The Owner ID of the Transit Gateway"
  value       = [aws_ec2_transit_gateway.main.owner_id]
}

output "association_default_route_table_id" {
  description = "The ID of the Transit Gateway Association Default Route Table"
  value       = [aws_ec2_transit_gateway.main.association_default_route_table_id]
}

output "propagation_default_route_table_id" {
  description = "The ID of the Transit Gateway Propagation Default Route Table"
  value       = [aws_ec2_transit_gateway.main.propagation_default_route_table_id]
}
