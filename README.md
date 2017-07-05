# keycloak-mssql

Docker Image for [Keycloak](http://www.keycloak.org/) with a MSSQL Backend.

## Configuration

Set set the following environment variables to configure Keycloak:

* `MSSQL_HOST` **mandatory**
* `MSSQL_DATABASE` (default: `keycloak`)
* `MSSQL_PORT` (default: `1433`)
* `MSSQL_USER` (default: `keycloak`)
* `MSSQL_PASSWORD` (default: `password`)
* `MSSQL_PROPS` _optional_
