#!/usr/bin/env bash

set -oue pipefail 
# Part of an attempt to add Google Chrome in the usual way.
echo "Fixing google-chrome yum repo"
sed -i '/enabled/d' /etc/yum.repos.d/google-chrome.repo 
echo "enabled=1" >> /etc/yum.repos.d/google-chrome.repo

# We need to download and install the Google signing keys separately, we can't trust
# rpm-ostree to do it cleanly from the yum repo directly.
# Possibly related to https://github.com/rpm-software-management/rpm/issues/2577

echo "Downloading Google Signing Key"
curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/linux_signing_key.pub

rpm --import /tmp/linux_signing_key.pub
