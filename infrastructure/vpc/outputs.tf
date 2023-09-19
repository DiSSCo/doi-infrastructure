output "doi_database_subnet_group" {
  value       = module.doi-database-vpc.database_subnet_group
  description = "Subnet of the database"
}

output "doi_server_subnet_group" {
  value       = module.doi-server-vpc.private_subnets
  description = "Private subnet of the DOI Server"
}

output "doi_database_security_group" {
  value       = aws_security_group.doi-database-sg.id
  description = "Security group of the database"
}

output "doi_server_security_group" {
  value       = aws_security_group.doi-server-sg.id
  description = "Security group of the DOI server"
}
