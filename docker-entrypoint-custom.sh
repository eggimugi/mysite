#!/bin/bash
# Disable all MPM first
a2dismod mpm_event mpm_worker mpm_prefork 2>/dev/null || true
# Enable prefork only
a2enmod mpm_prefork
# Run Apache
exec apache2-foreground
