#!/usr/bin/env bash
# setup.sh — initialise PortGuard repo and push to GitHub
# usage: ./setup.sh <github-username> <repo-name>
# example: ./setup.sh stevenvandenheede portguard-demo

set -e

USERNAME="${1:-}"
REPONAME="${2:-portguard-demo}"

if [ -z "$USERNAME" ]; then
  echo "Usage: ./setup.sh <github-username> [repo-name]"
  echo "Example: ./setup.sh stevenvandenheede portguard-demo"
  exit 1
fi

echo "→ Initialising git repo for $USERNAME/$REPONAME"

# Check for git-lfs (videos are LFS-tracked by default)
if ! command -v git-lfs &> /dev/null; then
  echo ""
  echo "⚠  git-lfs is not installed."
  echo "   Either install it:  brew install git-lfs   (macOS)"
  echo "                       apt install git-lfs   (Ubuntu)"
  echo "   OR remove .gitattributes to commit videos directly:"
  echo "                       rm .gitattributes"
  echo ""
  read -p "Continue without LFS? (y/N) " -n 1 -r
  echo
  [[ ! $REPLY =~ ^[Yy]$ ]] && exit 1
else
  git lfs install
fi

git init
git branch -M main
git add .
git commit -m "PortGuard — initial commit"

echo ""
echo "✓ Local repo ready."
echo ""
echo "→ Next: create the empty repo on GitHub, then run:"
echo ""
echo "   git remote add origin https://github.com/$USERNAME/$REPONAME.git"
echo "   git push -u origin main"
echo ""
echo "→ Then enable Pages:"
echo "   https://github.com/$USERNAME/$REPONAME/settings/pages"
echo "   Source → GitHub Actions"
echo ""
echo "→ Site will be live at:"
echo "   https://$USERNAME.github.io/$REPONAME/"
