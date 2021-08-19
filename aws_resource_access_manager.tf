###############################################################################
### RESOURCE ACCESS MANAGER (RAM)
###############################################################################

# RAM RESOURCE SHARE
resource "aws_ram_resource_share" "main" {
  name                      = "${var.name}-${terraform.workspace}-main"
  allow_external_principals = false
}

# RAM RESOURCE ASSOCIATION
resource "aws_ram_resource_association" "main" {
  resource_arn       = aws_ec2_transit_gateway.main.arn
  resource_share_arn = aws_ram_resource_share.main.arn
}

# RAM PRINCIPAL ASSOCIATION
resource "aws_ram_principal_association" "main" {
  principal          = var.principal_organization_arn
  resource_share_arn = aws_ram_resource_share.main.arn
}

#######################################
# OUTPUTS
#######################################

output "ram_resource_share_id" {
  description = "The ID of the RAM Resource Share"
  value       = [aws_ram_resource_share.main.id]
}

output "ram_resource_association_id" {
  description = "The ID of the RAM Resource Association"
  value       = [aws_ram_resource_association.main.id]
}

output "ram_principal_association_id" {
  description = "The ID of the RAM Principal Association"
  value       = [aws_ram_principal_association.main.id]
}
