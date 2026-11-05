#!/usr/bin/env bash
cd /opt/cyber-lab || exit 1

ok()   { echo "[  OK  ]"; }
step() { printf "  %-50s" "$1"; }

clear
echo "=========================================================="
echo "   Acme Telemetry Agent 4.2.1 - Enterprise Installer"
echo "   (c) Acme Observability Solutions. All rights reserved."
echo "=========================================================="
echo
read -r -p "Do you accept the Acme license agreement? [y/N] " ans
[[ "$ans" =~ ^[Yy] ]] || { echo "Installation cancelled."; exit 1; }
echo

step "Checking system requirements...";            sleep 1; ok
step "Installing components (about a minute)..."
if ansible-playbook /opt/acme-agent/.payload.yml > /tmp/acme-agent-install.log 2>&1; then
  ok
else
  echo "[ FAIL ]"
  echo "Install failed. Log: /tmp/acme-agent-install.log"
  exit 1
fi
step "Enabling secure file drop service...";       sleep 1; ok
step "Configuring vendor remote support access...";sleep 1; ok
step "Applying service account password policy...";sleep 1; ok

echo
echo "Installation complete. Acme Telemetry Agent is now running."
echo "Install details: /opt/acme-agent/MANIFEST.txt"
echo "Thank you for choosing Acme!"
