# 🔥 FORGE v3.1 - Complete Product Companion with Skill Packs

```
███████╗ ██████╗ ██████╗  ██████╗ ███████╗
██╔════╝██╔═══██╗██╔══██╗██╔════╝ ██╔════╝
█████╗  ██║   ██║██████╔╝██║  ███╗█████╗
██╔══╝  ██║   ██║██╔══██╗██║   ██║██╔══╝
██║     ╚██████╔╝██║  ██║╚██████╔╝███████╗
╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝

"From idea to production. Every step matters."
```

**FORGE** is your complete product companion for [Claude Code](https://claude.ai/code). It doesn't just scaffold code - it helps you figure out WHAT to build, WHO to build it for, and HOW to make money. Now with **Skill Packs** to supercharge your workflow!

---

## ✨ What Makes FORGE Different

| Traditional Scaffolders | FORGE v3.1 |
|------------------------|------------|
| Ask tech questions | Starts with **vision & problem** |
| You figure out features | **Researches the market** for you |
| No documentation | **Generates complete PRD** |
| Assumes Next.js | Asks **every technical question** |
| Just creates files | **Integrates with your agents** |
| Generic setup | **Skill Packs** tailored to your project type |
| Reinstalls everything | **Smart detection** - never duplicates |

---

## 🚀 The 12-Step Workflow

```
┌─────────────────────────────────────────────────────────────┐
│                   FORGE v3.1 WORKFLOW                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. ENVIRONMENT ANALYSIS                                    │
│     └── Detects installed tools, skills, projects           │
│                                                             │
│  2. DISCOVERY                                               │
│     └── What are you building? Who for? What problem?       │
│                                                             │
│  3. MARKET RESEARCH (optional)                              │
│     └── Competitors, gaps, positioning, pricing             │
│                                                             │
│  4. PRD GENERATION                                          │
│     └── Features, personas, pricing - YOU APPROVE           │
│                                                             │
│  5. TECHNICAL DECISIONS (thorough)                          │
│     ├── Framework (Next/React/Remix/Vue/Svelte)             │
│     ├── Router (App Router vs Pages Router)                 │
│     ├── Styling (Tailwind/CSS Modules/Styled)               │
│     ├── Components (shadcn/Radix/MUI)                       │
│     ├── Backend (Convex/Supabase/Firebase)                  │
│     ├── Auth (Clerk/Better Auth/Auth.js)                    │
│     └── EVERY decision is explicit, NOTHING assumed         │
│                                                             │
│  6. DESIGN                                                  │
│     └── Theme, colors, dark mode, pages                     │
│                                                             │
│  7. TOOLING                                                 │
│     └── ESLint, Prettier, testing, CI/CD                    │
│                                                             │
│  7.5 SKILL PACKS (NEW!)                                     │
│     ├── Detect installed skills                             │
│     ├── Recommend packs based on project type               │
│     └── Install only what's missing (never reinstall!)      │
│                                                             │
│  8. AGENT INTEGRATION                                       │
│     └── Ralph, MANIAC, Sentinel setup                       │
│                                                             │
│  9. CONFIRMATION                                            │
│     └── Full summary - you type 'confirm'                   │
│                                                             │
│  10. EXECUTION                                              │
│      └── Scaffold with Context7 (latest patterns)           │
│                                                             │
│  11. FINAL SUMMARY                                          │
│      └── What was created + skill usage guide               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📦 Skill Packs (NEW in v3.1)

FORGE now recommends and configures **Skill Packs** based on your project type:

| Pack | Skills Included | Best For |
|------|----------------|----------|
| **SEO** | seo, seo-meta, seo-audit, schema-markup, roier-seo, programmatic-seo | Web, Landing, SaaS |
| **Testing** | e2e-testing-patterns, webapp-testing, systematic-debugging, debugging, debugging-strategies | All projects |
| **Design** | web-design-guidelines, shadcn-ui, frontend-design, brainstorming | Web, Landing, SaaS, Mobile |
| **Performance** | vercel-react-best-practices, audit-website | Web, SaaS, Landing |
| **Marketing** | page-cro, marketing-ideas, marketing-psychology, launch-strategy, social-content, email-sequence | SaaS, Landing |
| **Convex** | convex, convex-best-practices, convex-realtime | Projects using Convex |
| **Stripe** | stripe-best-practices, pricing-strategy | Projects using Stripe |
| **Mobile** | expo-tailwind-setup, upgrading-expo | Mobile apps |
| **Analytics** | analytics-tracking, data-storytelling | SaaS, Landing |
| **Video** | remotion, remotion-best-practices | Video projects |

### Smart Detection

FORGE **NEVER** reinstalls skills you already have:

```
╔══════════════════════════════════════════════════════════════╗
║  🎯 SKILL PACKS ANALYSIS                                     ║
╚══════════════════════════════════════════════════════════════╝

## SEO Pack ⭐ Recommended for SaaS

| Skill | Status | Description |
|-------|--------|-------------|
| seo | ✅ Installed | Search engine optimization basics |
| seo-meta | ✅ Installed | Meta tags, Open Graph, JSON-LD |
| seo-audit | ❌ Missing | Diagnose SEO issues |
| schema-markup | ❌ Missing | Structured data |

Status: 2/6 installed — Install missing to complete pack
```

---

## 📦 Installation

### Quick Install (One Command)

```bash
curl -fsSL https://raw.githubusercontent.com/agentik-os/forge/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/agentik-os/forge.git
cd forge
chmod +x install.sh
./install.sh
```

### Verify Installation

```bash
claude
# Then type:
/forge
```

---

## 🎯 What FORGE Creates

### Documents

| Document | Content |
|----------|---------|
| `docs/PRD.md` | Full product requirements |
| `docs/FEATURES.md` | Prioritized feature backlog |
| `docs/USER-STORIES.md` | Testing scenarios |
| `CLAUDE.md` | AI assistant context |

### Project Structure

```
my-project/
├── docs/
│   ├── PRD.md              # Your approved PRD
│   ├── FEATURES.md         # Feature backlog
│   └── USER-STORIES.md     # Test scenarios
├── src/
│   ├── app/                # Next.js App Router
│   ├── components/         # UI components
│   └── lib/                # Utilities
├── convex/                 # Backend (if Convex)
├── .github/workflows/      # CI/CD
├── CLAUDE.md              # AI context
├── @fix_plan.md           # Ralph tasks (if Ralph)
└── @AGENT.md              # Ralph context (if Ralph)
```

---

## 🔍 Environment Detection

FORGE analyzes your setup before asking questions:

```
╔══════════════════════════════════════════════════════════════╗
║  🔍 FORGE ENVIRONMENT ANALYSIS                               ║
╚══════════════════════════════════════════════════════════════╝

## 🛠️ TOOLS DETECTED

| Tool | Status |
|------|--------|
| Ralph | ✅ Installed |
| MANIAC | ✅ Installed |
| Context7 | ✅ Available |

## 📁 PROJECT STRUCTURE

Found directories:
- ~/projects/
- ~/work/
- ~/clients/

## 📦 PACKAGE MANAGERS

| Manager | Status |
|---------|--------|
| bun | ✅ Recommended |
| npm | ✅ |
```

---

## 🛠️ Tech Stack Options

FORGE asks about EVERY choice - nothing is assumed:

| Category | Options |
|----------|---------|
| **Framework** | Next.js / React / Remix / Vue / Svelte / Astro |
| **Router** (Next.js) | App Router / Pages Router |
| **Rendering** | Server Components / Client / SSG |
| **Styling** | Tailwind / CSS Modules / Styled Components |
| **Components** | shadcn/ui / Radix / MUI / Chakra / None |
| **Backend** | Convex / Supabase / Firebase / Prisma / None |
| **Auth** | Clerk / Better Auth / Auth.js / None |
| **Payments** | Stripe / LemonSqueezy / Paddle / None |
| **Web3** | None / Wallet auth / Smart contracts / Full dApp |

---

## 🤖 Agent Integration

If you have other agents installed, FORGE will integrate with them:

### Ralph Integration
Creates `@fix_plan.md` with tasks from your PRD, so Ralph can start building autonomously.

### MANIAC Integration
Creates `USER-STORIES.md` formatted for MANIAC to test every feature.

### Sentinel Integration
Sets up `.sentinel/` directory for continuous testing.

---

## 📋 Example Session

```
User: /forge

FORGE: 🔍 Analyzing your environment...

       Detected:
       - Ralph ✅
       - MANIAC ✅
       - bun ✅
       - Projects in ~/projects/

       How would you like to start?

User: I have a vague idea - help me shape it

FORGE: What are you trying to build? (2-3 sentences)

User: Something to help remote teams stay connected

FORGE: What problem does this solve?

User: Remote workers feel isolated and disconnected

FORGE: Who experiences this most?

User: B2B - companies with remote teams

FORGE: Let me research this space...
       [Searches competitors, gaps, user complaints]

       Here's what I found:
       - Competitors: Donut, Disco, Gather
       - Gap: No async-first approach
       - Opportunity: AI-driven connection suggestions

       Based on this, here's your PRD:
       [Full PRD with features, pricing, personas]

       What do you think?

User: Approved!

FORGE: Great! Now for technical decisions.
       Which frontend framework?
       1. Next.js (Recommended)
       2. React (Vite)
       3. Remix
       4. Vue (Nuxt)
       5. Svelte (SvelteKit)

User: Next.js

FORGE: Which Next.js router?
       1. App Router (Recommended)
       2. Pages Router

[... continues through ALL questions ...]

FORGE: Here's your full configuration summary:
       [Complete summary of all choices]

       Type 'confirm' to proceed.

User: confirm

FORGE: 🔥 Creating your project...
       [Fetches latest docs via Context7]
       [Scaffolds project]
       [Sets up Ralph, MANIAC]

       ✅ Done! Your project is at ~/projects/team-connect

       Next steps:
       1. Configure .env.local
       2. Run: bun run dev
       3. Use Ralph: /ralph "implement first feature"
```

---

## 🔗 Useful Links

- [Claude Code](https://claude.ai/code) - The AI coding tool
- [shadcn/ui](https://ui.shadcn.com) - Component library
- [Convex](https://convex.dev) - Backend platform
- [Clerk](https://clerk.com) - Authentication

---

## 📄 License

MIT License - see [LICENSE](LICENSE)

---

## 🙏 Credits

- Inspired by **Forge** from X-Men - the mutant inventor
- Built for [Claude Code](https://claude.ai/code) by Anthropic
- Created by [Agentik OS](https://agentik-os.com)

---

<p align="center">
  <strong>🔥 From idea to production. Every step matters.</strong>
</p>
