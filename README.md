syspy
=====

Captures TDS (Sybase / MSSQL) packages directly from a network interface.

Currently, only TDS_LANGUAGE (Query Statements) and their TDS_PARAMFMT/2 TDS_PARAMS are parsed.

There are still many data types missing.

Also replaces parameters from prepared statements (e.g. @sql9_object_id is going to be replaced by the corresponding value from TDS_PARAMS).

Usage:
sudo syspy <interface> <destination_ip> <destination_port>

Example:
sudo syspy eth0 192.168.1.6 2048
