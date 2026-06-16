#!/bin/bash
# Cloudflare Pages Project Creator via API
# This script creates a Pages project connected to a GitHub repo

set -e

echo "🚀 Creating Cloudflare Pages Project: employee-portal"
echo ""

# You need to set these:
CLOUDFLARE_API_TOKEN="${CLOUDFLARE_API_TOKEN:-YOUR_API_TOKEN_HERE}"
CLOUDFLARE_ACCOUNT_ID="f5769183a7f3765bf23f3936298b7334"
PROJECT_NAME="employee-portal"
GITHUB_REPO="zmonroe101/employee-portal"
PRODUCTION_BRANCH="master"

if [ "$CLOUDFLARE_API_TOKEN" = "YOUR_API_TOKEN_HERE" ]; then
  echo "❌ ERROR: CLOUDFLARE_API_TOKEN not set!"
  echo ""
  echo "To get your API token:"
  echo "1. Go to: https://dash.cloudflare.com/profile/api-tokens"
  echo "2. Click 'Create Token'"
  echo "3. Use template: 'Edit Cloudflare Workers'"
  echo "4. Add Permissions: Account > Cloudflare Pages > Edit"
  echo "5. Continue to summary → Create Token"
  echo "6. Copy the token"
  echo ""
  echo "Then run:"
  echo "  export CLOUDFLARE_API_TOKEN='your-token-here'"
  echo "  bash $0"
  exit 1
fi

echo "📦 Creating Pages project..."

RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/pages/projects" \
  -H "Authorization: Bearer ${CLOUDFLARE_API_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "{
    \"name\": \"${PROJECT_NAME}\",
    \"production_branch\": \"${PRODUCTION_BRANCH}\",
    \"source\": {
      \"type\": \"github\",
      \"config\": {
        \"owner\": \"zmonroe101\",
        \"repo_name\": \"employee-portal\",
        \"production_branch\": \"${PRODUCTION_BRANCH}\",
        \"deployments_enabled\": true,
        \"pr_comments_enabled\": true
      }
    },
    \"build_config\": {
      \"build_command\": \"\",
      \"destination_dir\": \"/\",
      \"root_dir\": \"/\"
    }
  }")

echo "$RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE"

if echo "$RESPONSE" | grep -q '"success":true'; then
  echo ""
  echo "✅ SUCCESS! Pages project created!"
  echo ""
  echo "🌐 Your site will be available at:"
  echo "   https://employee-portal.pages.dev/login.html"
  echo ""
  echo "⏳ First deployment will take ~2 minutes..."
  echo ""
  echo "Check status at:"
  echo "   https://dash.cloudflare.com/f5769183a7f3765bf23f3936298b7334/pages/view/employee-portal"
else
  echo ""
  echo "❌ ERROR: Failed to create project"
  echo ""
  echo "Response above shows the error. Common issues:"
  echo "  - Project already exists"
  echo "  - API token lacks permissions"
  echo "  - GitHub repo not accessible"
fi
