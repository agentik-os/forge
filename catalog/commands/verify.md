# /verify - Quick Functional Verification

Fast verification that a page works: console errors, network failures, basic functionality.

**NOT for responsive testing** (use `/responsive` for that).
**NOT for full E2E** (use `/e2e` for that).

## Usage
```
/verify [url]
```

## What This Command Does

### 1. Console Check
- Navigate to URL
- Capture console errors
- Report any JS errors

### 2. Network Check
- Monitor network requests
- Report 4xx/5xx errors
- Check for failed resources

### 3. Basic Functionality
- Page loads without crash
- Main content visible
- No critical errors

### 4. Quick Interactions
- Test main CTA button if visible
- Test navigation menu
- Test one form if present

## Output
```
VERIFY RESULTS - [URL]
━━━━━━━━━━━━━━━━━━━━━━
Console Errors: 0 ✅
Network Errors: 0 ✅
Page Load: OK ✅
Main CTA: Works ✅
━━━━━━━━━━━━━━━━━━━━━━
VERDICT: ✅ PASS / ❌ FAIL
```

---

$ARGUMENTS

Execute quick verification:

1. Connect to Chrome (localhost:9222 or Playwright)
2. Navigate to URL
3. Check console for errors
4. Check network for failures
5. Click main visible button
6. Report pass/fail

**Keep it fast - 30 seconds max. For deep testing use /e2e.**
