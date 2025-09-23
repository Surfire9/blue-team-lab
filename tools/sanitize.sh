#!/usr/bin/env bash
# Sanitize repo content before publishing (Linux/WSL).
# - Scans for secrets/IPs/emails
# - Strips image metadata
# - (Optional) creates sanitized log samples

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YEL='\033[1;33m'; NC='\033[0m'

echo -e "${YEL}==> Checking dependencies...${NC}"
need() { command -v "$1" >/dev/null 2>&1 || { echo -e "${RED}Missing: $1${NC}"; MISSING=1; }; }
MISSING=0
need git
need exiftool || true          # optional but recommended
need mogrify  || true          # from ImageMagick, optional
[ "${MISSING}" -eq 0 ] || echo -e "${YEL}Install missing tools: sudo apt update && sudo apt install -y exiftool imagemagick${NC}"

echo -e "${YEL}==> Scanning for sensitive patterns...${NC}"

# 1) Obvious secrets / keys
echo -e "${YEL}[secrets]${NC}"
git grep -n -I -E "(password|passwd|secret|token|apikey|authorization|bearer|PRIVATE KEY|BEGIN RSA|BEGIN OPENSSH|-----BEGIN)" || echo "  (none found)"

# 2) Private IP ranges often seen in labs
echo -e "${YEL}[private IPs]${NC}"
git grep -n -I -E "(^|[^0-9])10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || echo "  (none found)"
git grep -n -I -E "(^|[^0-9])192\.168\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)"      || echo "  (none found)"
git grep -n -I -E "(^|[^0-9])172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || echo "  (none found)"

# 3) Emails / domains (broad patterns)
echo -e "${YEL}[emails/domains]${NC}"
git grep -n -I -E "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" || echo "  (none found)"
git grep -n -I -E "([a-z0-9-]+\.)+[a-z]{2,}"                        || echo "  (none found)"

# 4) Strip EXIF/metadata from screenshots (PNG/JPG)
if command -v exiftool >/dev/null 2>&1; then
  echo -e "${YEL}==> Stripping image metadata (PNG/JPG) in ./screenshots and subfolders...${NC}"
  find . -type d -name screenshots -print0 | while IFS= read -r -d '' dir; do
    find "$dir" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) -print0 \
      | xargs -0 -r exiftool -overwrite_original -all= >/dev/null 2>&1 || true
    if command -v mogrify >/dev/null 2>&1; then
      # Optionally re-strip & shrink very large images (>1600x1200)
      find "$dir" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) -size +2M -print0 \
        | xargs -0 -r mogrify -strip -resize 1600x1200\> || true
    fi
  done
else
  echo -e "${RED}exiftool not found; skipping image metadata stripping.${NC}"
fi

echo -e "${GREEN}==> Sanitize scan complete. Review any matches above before pushing.${NC}"
echo -e "${YEL}Tip:${NC} Replace sensitive values with placeholders like <lab-ip>, <user>, <host-1>."
