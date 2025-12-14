#!/bin/bash
# GitHub Push Helper Script
# MA615 Final Project

echo "============================================="
echo "GitHub Repository Setup"
echo "============================================="
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Error: Git repository not initialized"
    echo "Run: git init"
    exit 1
fi

echo "✓ Git repository detected"
echo ""

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "⚠ You have uncommitted changes"
    echo "Committing all changes..."
    git add -A
    git commit -m "Final updates before submission"
    echo "✓ Changes committed"
    echo ""
fi

# Prompt for GitHub details
echo "Enter your GitHub username:"
read github_username

echo ""
echo "Enter your repository name (e.g., MA615-Final-Hawaii-BigIsland):"
read repo_name

echo ""
echo "Your GitHub repository URL will be:"
echo "https://github.com/$github_username/$repo_name"
echo ""
echo "Press Enter to continue, or Ctrl+C to cancel"
read

# Add remote (remove existing if present)
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$github_username/$repo_name.git"

echo ""
echo "✓ Remote repository configured"
echo ""

# Push to GitHub
echo "Pushing to GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "============================================="
echo "✓ SUCCESS!"
echo "============================================="
echo ""
echo "Your repository is now available at:"
echo "https://github.com/$github_username/$repo_name"
echo ""
echo "Submit this URL to your instructor:"
echo "https://github.com/$github_username/$repo_name"
echo ""
