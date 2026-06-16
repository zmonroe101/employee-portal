#!/bin/bash
# Verification script for login.html fixes

echo "==================================="
echo "Login Page Fix Verification"
echo "==================================="
echo ""

# Check if files exist
echo "1. Checking files exist..."
if [ -f "login.html" ]; then
    echo "   ✅ login.html exists"
else
    echo "   ❌ login.html NOT found"
    exit 1
fi

if [ -f "test-login.html" ]; then
    echo "   ✅ test-login.html exists"
else
    echo "   ❌ test-login.html NOT found"
fi

if [ -f "LOGIN_FIX_SUMMARY.md" ]; then
    echo "   ✅ LOGIN_FIX_SUMMARY.md exists"
else
    echo "   ❌ LOGIN_FIX_SUMMARY.md NOT found"
fi

echo ""

# Check Supabase key length
echo "2. Checking Supabase configuration..."
KEY_LENGTH=$(grep "SUPABASE_ANON_KEY" login.html | grep -o "eyJ[^']*" | head -1 | wc -c)
if [ "$KEY_LENGTH" -gt 100 ]; then
    echo "   ✅ Supabase anon key appears valid (${KEY_LENGTH} chars)"
else
    echo "   ⚠️  Supabase anon key may be placeholder (${KEY_LENGTH} chars)"
fi

# Check for window.supabase.createClient
echo ""
echo "3. Checking Supabase client initialization..."
if grep -q "window.supabase.createClient" login.html; then
    echo "   ✅ Using correct window.supabase.createClient()"
else
    echo "   ❌ window.supabase.createClient NOT found"
fi

# Check for error display functions
echo ""
echo "4. Checking error display mechanism..."
if grep -q "function showError" login.html; then
    echo "   ✅ showError() function exists"
else
    echo "   ❌ showError() function NOT found"
fi

if grep -q "errorMessage.classList.add('show')" login.html; then
    echo "   ✅ Error display adds 'show' class"
else
    echo "   ❌ Error display missing 'show' class logic"
fi

# Check for error message div
if grep -q 'id="errorMessage"' login.html; then
    echo "   ✅ Error message div exists"
else
    echo "   ❌ Error message div NOT found"
fi

# Check for preventDefault
echo ""
echo "5. Checking form submission handling..."
if grep -q "e.preventDefault()" login.html; then
    echo "   ✅ preventDefault() found"
else
    echo "   ❌ preventDefault() NOT found"
fi

if grep -q "e.stopPropagation()" login.html; then
    echo "   ✅ stopPropagation() found (extra safety)"
else
    echo "   ⚠️  stopPropagation() not found (optional)"
fi

# Check for initialization function
echo ""
echo "6. Checking initialization..."
if grep -q "async function initializeApp" login.html; then
    echo "   ✅ initializeApp() function exists"
else
    echo "   ⚠️  initializeApp() function not found"
fi

# Check for console logging
echo ""
echo "7. Checking debug logging..."
LOG_COUNT=$(grep -c "console.log" login.html)
if [ "$LOG_COUNT" -gt 3 ]; then
    echo "   ✅ Debug logging added ($LOG_COUNT instances)"
else
    echo "   ⚠️  Limited debug logging ($LOG_COUNT instances)"
fi

# Check for user-friendly error messages
echo ""
echo "8. Checking error messages..."
if grep -q "Invalid email or password" login.html; then
    echo "   ✅ User-friendly credential error message"
else
    echo "   ⚠️  Generic error messages only"
fi

if grep -q "Email not confirmed" login.html; then
    echo "   ✅ Email confirmation error message"
else
    echo "   ⚠️  Email confirmation error not handled"
fi

if grep -q "Network error" login.html; then
    echo "   ✅ Network error message"
else
    echo "   ⚠️  Network error not handled"
fi

# Check localStorage usage
echo ""
echo "9. Checking localStorage implementation..."
STORAGE_COUNT=$(grep -c "localStorage.setItem" login.html)
if [ "$STORAGE_COUNT" -ge 5 ]; then
    echo "   ✅ User data stored in localStorage ($STORAGE_COUNT items)"
else
    echo "   ⚠️  Limited localStorage usage ($STORAGE_COUNT items)"
fi

if grep -q "localStorage.setItem('user_id'" login.html; then
    echo "   ✅ user_id stored (was missing before)"
else
    echo "   ❌ user_id NOT stored in localStorage"
fi

echo ""
echo "==================================="
echo "Verification Complete"
echo "==================================="
echo ""
echo "Next steps:"
echo "1. Open login.html in a web browser"
echo "2. Open browser DevTools (F12) → Console"
echo "3. Try logging in with test credentials"
echo "4. Verify error messages display correctly"
echo "5. Open test-login.html to verify SDK loading"
echo ""
echo "Test credentials (from README.md):"
echo "Email: zmonroe@heinepropane.com"
echo "Password: (must be set in Supabase dashboard)"
echo ""
