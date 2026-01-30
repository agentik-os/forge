# /responsive - Responsive Design Testing

Test responsive design across multiple viewports. **Screenshots only, no interactions.**

## Usage
```
/responsive [url]
```

## Viewports Tested
| Device | Width | Height |
|--------|-------|--------|
| Desktop | 1440px | 900px |
| Tablet | 768px | 1024px |
| Mobile | 375px | 812px |

## What This Command Does
1. Navigate to URL
2. Take screenshot at each viewport
3. Report any layout issues

**For functional testing, use `/verify` or `/e2e` instead.**

---

$ARGUMENTS

Execute responsive screenshot test:

1. Connect to Chrome via tunnel (localhost:9222)
2. Navigate to provided URL
3. For each viewport (desktop, tablet, mobile):
   - Resize browser
   - Take screenshot
   - Note any overflow or layout issues
4. Save screenshots to temp directory
5. Report summary

**Keep it simple - just viewports and screenshots. No interactions.**
