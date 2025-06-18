#!/bin/bash

# ==============================================
# Final SWAG Configuration Cleanup
# Removes duplicates and fixes formatting
# ==============================================

print_status() {
    echo "[INFO] $1"
}

print_success() {
    echo "[SUCCESS] $1"
}

# Clean up duplicate lines and fix formatting
cleanup_duplicates() {
    print_status "Cleaning up duplicate lines and fixing formatting..."
    
    find . -name "*.subdomain.conf" -type f | while read -r file; do
        print_status "Cleaning $file"
        
        # Create temporary file
        temp_file=$(mktemp)
        
        # Remove duplicate http2 on lines and fix formatting
        awk '
        /http2 on;/ {
            if (!seen_http2) {
                print "    http2 on;"
                print ""
                seen_http2 = 1
            }
            next
        }
        /# Block exploits/ {
            if (!seen_exploits) {
                print "    # Block exploits"
                seen_exploits = 1
            }
            next
        }
        /# Real IP detection/ {
            if (!seen_realip) {
                print "    # Real IP detection"
                seen_realip = 1
            }
            next
        }
        { print }
        ' "$file" > "$temp_file"
        
        # Replace original file
        mv "$temp_file" "$file"
        print_success "Cleaned $file"
    done
}

# Main execution
main() {
    print_status "Starting final SWAG configuration cleanup..."
    
    # Change to script directory
    cd "$(dirname "$0")"
    
    cleanup_duplicates
    
    print_success "Final cleanup completed!"
    print_status "All SWAG configurations are now ready for deployment."
}

main "$@"
