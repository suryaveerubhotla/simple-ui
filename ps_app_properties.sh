#!/bin/bash

# Function to escape special characters in keys and values
escape_special_characters() {
  echo "$1" | sed -e 's/[]\/$*.^[]/\\&/g'
}

# Display general help message
display_help() {
  echo "Usage: $0 [options] <properties-file>"
  echo ""
  echo "This script updates application.properties with data from a template file."
  echo "It supports three types of properties files:"
  echo "  1. DB_Primary_properties - For Primary DataSource configuration."
  echo "  2. DB_Secondary_properties - For Secondary DataSource configuration."
  echo "  3. application-template-properties - For other property configurations."
  echo ""
  echo "Options:"
  echo "  --help             Show this help message and exit."
  echo ""
  echo "Examples:"
  echo "  ./ps_app_properties.sh DB_Primary_properties                       # Update primary DataSource"
  echo "  ./ps_app_properties.sh DB_Secondary_properties                     # Update secondary DataSource"
  echo "  ./ps_app_properties.sh application-template-properties             # Update other properties"
  echo ""
  echo "Parameters for application-template-properties:"
  echo "---------------------------------------------------------"
  echo "The application-template-properties file can define one or more of the following parameters:"
  echo ""
  echo "Example variables for application-template-properties file:"
  echo "-------------------------------------------"
  echo "server.ssl.enabled=true                    # Enable or disable SSL (true/false)"
  echo "server.ssl.key-store-type=PKCS12          # Type of key store (e.g., PKCS12, JKS)"
  echo "server.ssl.key-store=/path/to/keystore.p12    # Path to the SSL key store file"
  echo "server.ssl.key-store-password=changeit        # Password for the key store"
  echo "server.port=8443                          # Port number for the server to listen on"
  echo "base.ui.url=https://example.com           # Base URL for the UI application"
  echo ""
  echo "Note: Ensure the file is properly formatted and accessible before using."
}

# Check for the --help option
if [[ "$1" == "--help" ]]; then
  display_help
  exit 0
fi

# Check if the properties file is provided
if [ -z "$1" ]; then
  echo "Error: No properties file provided."
  echo "Use --help for usage information."
  exit 1
fi

TEMPLATE_FILE=$1
TEMPLATE_FILE=$(basename "$TEMPLATE_FILE")  # Extract only the base name
PROPERTIES_FILE="/home/ubuntu/prime-square/application.properties"

# Validate input template file
if [[ "$TEMPLATE_FILE" != "DB_Primary_properties" && "$TEMPLATE_FILE" != "DB_Secondary_properties" && "$TEMPLATE_FILE" != "application-template-properties" ]]; then
  echo "Error: Invalid properties file."
  echo "Use --help for usage information."
  exit 1
fi

# Function to update Primary DataSource properties
update_primary_datasource() {
  source "$TEMPLATE_FILE"

  DB_PRIMARY_HOST=$(escape_special_characters "$DB_PRIMARY_HOST")
  DB_PRIMARY_PORT=$(escape_special_characters "$DB_PRIMARY_PORT")
  DB_PRIMARY_DATABASE=$(escape_special_characters "$DB_PRIMARY_DATABASE")
  DB_PRIMARY_USER=$(escape_special_characters "$DB_PRIMARY_USER")
  DB_PRIMARY_PASS=$(escape_special_characters "$DB_PRIMARY_PASS")

  sed -i -E "
  /^# Primary DataSource/,/^# Secondary DataSource/ {
    s#\\\$\\{DB_HOST:[^}]+\\}#\${DB_HOST:${DB_PRIMARY_HOST}}#g;
    s#\\\$\\{DB_PORT:[^}]+\\}#\${DB_PORT:${DB_PRIMARY_PORT}}#g;
    s#\\\$\\{DB_DATABASE:[^}]+\\}#\${DB_DATABASE:${DB_PRIMARY_DATABASE}}#g;
    s#\\\$\\{DB_USER:[^}]+\\}#\${DB_USER:${DB_PRIMARY_USER}}#g;
    s#\\\$\\{DB_PASS:[^}]+\\}#\${DB_PASS:${DB_PRIMARY_PASS}}#g;
  }
  " "$PROPERTIES_FILE"

  echo "Primary DataSource section in $PROPERTIES_FILE has been updated."
}

# Function to update Secondary DataSource properties
update_secondary_datasource() {
  source "$TEMPLATE_FILE"

  DB_SECONDARY_HOST=$(escape_special_characters "$DB_SECONDARY_HOST")
  DB_SECONDARY_PORT=$(escape_special_characters "$DB_SECONDARY_PORT")
  DB_SECONDARY_DATABASE=$(escape_special_characters "$DB_SECONDARY_DATABASE")
  DB_SECONDARY_USER=$(escape_special_characters "$DB_SECONDARY_USER")
  DB_SECONDARY_PASS=$(escape_special_characters "$DB_SECONDARY_PASS")
  DB_SECONDARY_DRIVER=$(escape_special_characters "$DB_SECONDARY_DRIVER")

  sed -i -E "
  /^# Secondary DataSource/,/^# End of DataSource/ {
    s#\\\$\\{DB_HOST:[^}]+\\}#\${DB_HOST:${DB_SECONDARY_HOST}}#g;
    s#\\\$\\{DB_PORT:[^}]+\\}#\${DB_PORT:${DB_SECONDARY_PORT}}#g;
    s#\\\$\\{DB_DATABASE:[^}]+\\}#\${DB_DATABASE:${DB_SECONDARY_DATABASE}}#g;
    s#\\\$\\{DB_USER:[^}]+\\}#\${DB_USER:${DB_SECONDARY_USER}}#g;
    s#\\\$\\{DB_PASS:[^}]+\\}#\${DB_PASS:${DB_SECONDARY_PASS}}#g;
  }
  " "$PROPERTIES_FILE"

  echo "Secondary DataSource section in $PROPERTIES_FILE has been updated."
}

# Function to update other properties
update_other_properties() {
  while IFS='=' read -r key value; do
    if [[ ! -z "$key" && ! "$key" =~ ^# ]]; then
      # Escape special characters in key and value
      escaped_key=$(escape_special_characters "$key")
      escaped_value=$(escape_special_characters "$value")
      # Replace the value in the properties file
      sed -i "s/\(\${${escaped_key}:\)[^}]*\}/\1${escaped_value}}/" "$PROPERTIES_FILE"
      sed -i "s/^\(${escaped_key}=\).*/\1${escaped_value}/" "$PROPERTIES_FILE"
    fi
  done < "$TEMPLATE_FILE"

  echo "Other properties in $PROPERTIES_FILE have been updated."
}

# Main logic to choose the update based on the input file
case "$TEMPLATE_FILE" in
  DB_Primary_properties)
    update_primary_datasource
    ;;
  DB_Secondary_properties)
    update_secondary_datasource
    ;;
  application-template-properties)
    update_other_properties
    ;;
  *)
    echo "Error: Invalid properties file."
    echo "Use --help for usage information."
    exit 1
    ;;
esac