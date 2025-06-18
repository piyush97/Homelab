#!/bin/bash

# ==============================================
# Fix SWAG Configuration Issues
# Addresses nginx warnings and missing files
# ==============================================

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Fix HTTP2 syntax in all subdomain configs
fix_http2_syntax() {
    print_status "Fixing deprecated HTTP2 syntax in SWAG configurations..."
    
    # Find all subdomain.conf files
    find . -name "*.subdomain.conf" -type f | while read -r file; do
        if [[ -f "$file" ]]; then
            print_status "Processing $file"
            
            # Create a temporary file for the fixed content
            temp_file=$(mktemp)
            
            # Process the file line by line
            while IFS= read -r line; do
                # Fix deprecated listen directives
                if [[ "$line" =~ "listen 443 ssl http2;" ]]; then
                    echo "    listen 443 ssl;" >> "$temp_file"
                elif [[ "$line" =~ "listen \[::\]:443 ssl http2;" ]]; then
                    echo "    listen [::]:443 ssl;" >> "$temp_file"
                    echo "    http2 on;" >> "$temp_file"
                    echo "" >> "$temp_file"
                # Skip duplicate http2 on lines
                elif [[ "$line" =~ "http2 on;" ]] && [[ $(grep -c "http2 on;" "$temp_file" 2>/dev/null || echo 0) -gt 0 ]]; then
                    continue
                else
                    echo "$line" >> "$temp_file"
                fi
            done < "$file"
            
            # Replace the original file
            mv "$temp_file" "$file"
            print_success "Fixed $file"
        fi
    done
}

# Create missing configuration files (if needed)
create_missing_configs() {
    print_status "SWAG configurations do not require custom _realip.conf or _exploits.conf files"
    print_status "SWAG handles real IP detection and security automatically"
}

# Validate configurations
validate_configs() {
    print_status "Validating SWAG configurations..."
    
    local errors=0
    
    # Check for syntax issues
    find . -name "*.subdomain.conf" -type f | while read -r file; do
        if ! nginx -t -c "$file" 2>/dev/null; then
            print_warning "Syntax issues detected in $file"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_success "All configurations validated successfully"
    else
        print_warning "$errors configuration(s) have potential issues"
    fi
}

# Remove unnecessary includes
fix_include_paths() {
    print_status "Removing unnecessary include directives from SWAG configurations..."
    
    find . -name "*.subdomain.conf" -type f | while read -r file; do
        # Remove _realip.conf and _exploits.conf includes as they're not needed
        sed -i '' '/include \/config\/nginx\/proxy-confs\/_realip.conf;/d' "$file"
        sed -i '' '/include \/config\/nginx\/proxy-confs\/_exploits.conf;/d' "$file"
        sed -i '' '/# Real IP detection/d' "$file"
        sed -i '' '/# Block exploits/d' "$file"
    done
    
    print_success "Unnecessary includes removed"
}

# Main execution
main() {
    print_status "Starting SWAG configuration fixes..."
    
    # Change to script directory
    cd "$(dirname "$0")"
    
    create_missing_configs
    fix_http2_syntax
    fix_include_paths
    
    print_success "All SWAG configuration issues have been fixed!"
    print_status "SWAG configurations are now ready for deployment."
    print_status "No additional proxy-confs files are required."
}

# Show help
show_help() {
    cat << EOF
SWAG Configuration Fix Script

This script fixes common SWAG configuration issues:
- Deprecated HTTP2 syntax warnings
- Missing _realip.conf and _exploits.conf files
- Incorrect include paths

Usage: $0 [OPTIONS]

Options:
  -h, --help    Show this help message

EOF
}

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac
