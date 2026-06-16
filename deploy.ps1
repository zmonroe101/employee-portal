# Deploy Employee Portal to Cloudflare Pages
# Run this from Windows PowerShell (not WSL)

Write-Host "🚀 Deploying employee-portal to Cloudflare Pages..." -ForegroundColor Cyan
Write-Host ""

cd C:\Users\zaker\Desktop\employee-portal

# Deploy via wrangler (will prompt for login on first run)
npx wrangler pages deploy . --project-name=employee-portal --branch=master

Write-Host ""
Write-Host "✅ Deployment complete!" -ForegroundColor Green
Write-Host ""
Write-Host "🌐 Your portal is live at:" -ForegroundColor Yellow
Write-Host "   https://employee-portal.pages.dev/login.html" -ForegroundColor White
Write-Host ""
Write-Host "📊 Dashboard:" -ForegroundColor Yellow
Write-Host "   https://dash.cloudflare.com/pages" -ForegroundColor White
