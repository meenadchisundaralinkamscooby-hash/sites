#!/bin/bash
# Publish the proposal pages to GitHub Pages.
# Run AFTER: ~/.local/bin/gh auth login
set -e
export PATH="$HOME/.local/bin:$PATH"
REPO=sites

gh repo view "$REPO" >/dev/null 2>&1 || \
  gh repo create "$REPO" --public -d "One-page proposals for GTA businesses with broken websites"

git add -A
git commit -qm "Publish proposal pages" || true
git push -u origin main

# Enable Pages (no-op if already enabled)
gh api -X POST "repos/{owner}/$REPO/pages" -f "source[branch]=main" -f "source[path]=/" 2>/dev/null || true

echo "Live shortly at: https://$(gh api user -q .login).github.io/$REPO/"
