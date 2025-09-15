#!/bin/bash
set -euo pipefail

openssl genrsa -out origin.key 4096
openssl req -new -key origin.key -out origin.csr -subj "/CN=*.timmos.com.au"
chmod 0600 origin.key origin.csr
