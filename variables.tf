variable "env" {
  type    = string
  default = "__env__"
}
variable "resource_group_prefix" {
  type    = string
  default = "__resource_group_prefix__"
}
variable "resource_location" {
  type    = string
  default = "__resource_location__"
}
variable "storage_account_tier" {
  type    = string
  default = "__storage_account_tier__"
}
variable "storage_account_replication_type" {
  type    = string
  default = "__storage_account_replication_type__"
}
variable "databricks_tier" {
  type    = string
  default = "__databricks_tier__"
}
variable "sql_admin_login" {
  type    = string
  default = "__sql_admin_login__"
}
variable "sql_admin_password" {
  type    = string
  default = "__sql_admin_login__"
}
