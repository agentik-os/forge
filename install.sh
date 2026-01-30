#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
# FORGE v3.1 - Installation Script
# Complete Product Companion for Claude Code
# ═══════════════════════════════════════════════════════════════════════════════

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color
BOLD='\033[1m'
DIM='\033[2m'

# Configuration
CLAUDE_DIR="$HOME/.claude"
REPO_URL="https://raw.githubusercontent.com/agentik-os/forge/main"

# Selected items for installation
SELECTED_AGENTS=()
SELECTED_COMMANDS=()
INSTALL_ALL_BUNDLE=""

# ═══════════════════════════════════════════════════════════════════════════════
# Helper Functions
# ═══════════════════════════════════════════════════════════════════════════════

print_banner() {
    echo ""
    echo -e "${CYAN}"
    echo "███████╗ ██████╗ ██████╗  ██████╗ ███████╗"
    echo "██╔════╝██╔═══██╗██╔══██╗██╔════╝ ██╔════╝"
    echo "█████╗  ██║   ██║██████╔╝██║  ███╗█████╗  "
    echo "██╔══╝  ██║   ██║██╔══██╗██║   ██║██╔══╝  "
    echo "██║     ╚██████╔╝██║  ██║╚██████╔╝███████╗"
    echo "╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝"
    echo -e "${NC}"
    echo -e "${BOLD}FORGE v3.1 - Complete Product Companion${NC}"
    echo -e "${YELLOW}\"From idea to production. Every step matters.\"${NC}"
    echo ""
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# ═══════════════════════════════════════════════════════════════════════════════
# Environment Detection
# ═══════════════════════════════════════════════════════════════════════════════

detect_environment() {
    echo ""
    echo -e "${BOLD}🔍 Detecting Environment...${NC}"
    echo ""

    # Check Claude Code
    if command -v claude &> /dev/null; then
        log_success "Claude Code detected"
        CLAUDE_INSTALLED=true
    else
        log_warning "Claude Code not found - install from claude.ai/code"
        CLAUDE_INSTALLED=false
    fi

    # Check package managers
    echo ""
    echo -e "${BOLD}📦 Package Managers:${NC}"

    if command -v bun &> /dev/null; then
        BUN_VERSION=$(bun --version 2>/dev/null || echo "unknown")
        log_success "bun $BUN_VERSION (Recommended)"
        PACKAGE_MANAGER="bun"
    else
        log_warning "bun not found"
    fi

    if command -v npm &> /dev/null; then
        NPM_VERSION=$(npm --version 2>/dev/null || echo "unknown")
        log_success "npm $NPM_VERSION"
        if [ -z "$PACKAGE_MANAGER" ]; then
            PACKAGE_MANAGER="npm"
        fi
    fi

    if command -v yarn &> /dev/null; then
        YARN_VERSION=$(yarn --version 2>/dev/null || echo "unknown")
        log_success "yarn $YARN_VERSION"
    fi

    if command -v pnpm &> /dev/null; then
        PNPM_VERSION=$(pnpm --version 2>/dev/null || echo "unknown")
        log_success "pnpm $PNPM_VERSION"
    fi

    # Check existing Claude Code setup
    echo ""
    echo -e "${BOLD}🛠️ Existing Claude Code Setup:${NC}"

    if [ -d "$CLAUDE_DIR" ]; then
        log_success "~/.claude/ directory exists"

        # Check for existing agents
        if [ -d "$CLAUDE_DIR/agents" ]; then
            AGENT_COUNT=$(ls -1 "$CLAUDE_DIR/agents"/*.md 2>/dev/null | wc -l || echo "0")
            log_info "Found $AGENT_COUNT agent(s) in ~/.claude/agents/"
        fi

        # Check for existing commands
        if [ -d "$CLAUDE_DIR/commands" ]; then
            CMD_COUNT=$(ls -1 "$CLAUDE_DIR/commands"/*.md 2>/dev/null | wc -l || echo "0")
            log_info "Found $CMD_COUNT command(s) in ~/.claude/commands/"
        fi
    else
        log_warning "~/.claude/ not found - will create"
    fi

    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# Catalog Functions
# ═══════════════════════════════════════════════════════════════════════════════

check_if_installed() {
    local item_type="$1"
    local item_id="$2"

    if [ "$item_type" = "agent" ]; then
        if [ -f "$CLAUDE_DIR/agents/${item_id}.md" ]; then
            return 0
        fi
    elif [ "$item_type" = "command" ]; then
        if [ -f "$CLAUDE_DIR/commands/${item_id}.md" ]; then
            return 0
        fi
    fi
    return 1
}

show_catalog_menu() {
    echo ""
    echo -e "${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║  🎯 FORGE CATALOG - Optional Add-ons                         ║${NC}"
    echo -e "${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${DIM}FORGE comes with the core command. You can also install additional${NC}"
    echo -e "${DIM}agents and commands to enhance your Claude Code experience.${NC}"
    echo ""
    echo -e "  ${CYAN}1)${NC} ${BOLD}Starter Bundle${NC} - Essential agents for any project"
    echo -e "     ${DIM}Includes: code-reviewer, debugger, typescript-pro${NC}"
    echo ""
    echo -e "  ${CYAN}2)${NC} ${BOLD}Fullstack Bundle${NC} - Complete web development setup"
    echo -e "     ${DIM}Includes: nextjs-developer, react-specialist, shadcn-ui-expert, + testing${NC}"
    echo ""
    echo -e "  ${CYAN}3)${NC} ${BOLD}SaaS Bundle${NC} - Everything for building SaaS products"
    echo -e "     ${DIM}Includes: convex-expert, stripe-expert, clerk-expert, + deployment${NC}"
    echo ""
    echo -e "  ${CYAN}4)${NC} ${BOLD}Mobile Bundle${NC} - React Native / Expo development"
    echo -e "     ${DIM}Includes: mobile-developer, react-specialist, + testing${NC}"
    echo ""
    echo -e "  ${CYAN}5)${NC} ${BOLD}Custom Selection${NC} - Choose individual agents and commands"
    echo ""
    echo -e "  ${CYAN}6)${NC} ${BOLD}Skip${NC} - Install FORGE only (you can add more later)"
    echo ""
    read -p "Choose an option [1-6]: " catalog_choice

    case $catalog_choice in
        1) select_bundle "starter" ;;
        2) select_bundle "fullstack" ;;
        3) select_bundle "saas" ;;
        4) select_bundle "mobile" ;;
        5) custom_selection ;;
        6) log_info "Skipping catalog add-ons..." ;;
        *) log_warning "Invalid choice, skipping catalog..." ;;
    esac
}

select_bundle() {
    local bundle="$1"
    INSTALL_ALL_BUNDLE="$bundle"

    case $bundle in
        "starter")
            SELECTED_AGENTS=("code-reviewer" "debugger" "typescript-pro")
            SELECTED_COMMANDS=("verify")
            ;;
        "fullstack")
            SELECTED_AGENTS=("nextjs-developer" "react-specialist" "typescript-pro" "code-reviewer" "debugger" "test-automator" "shadcn-ui-expert")
            SELECTED_COMMANDS=("verify" "responsive")
            ;;
        "saas")
            SELECTED_AGENTS=("nextjs-developer" "convex-expert" "stripe-expert" "clerk-expert" "code-reviewer" "debugger" "deployment-engineer")
            SELECTED_COMMANDS=("verify" "responsive")
            ;;
        "mobile")
            SELECTED_AGENTS=("mobile-developer" "react-specialist" "typescript-pro" "debugger" "test-automator")
            SELECTED_COMMANDS=("verify")
            ;;
    esac

    echo ""
    log_success "Selected ${bundle} bundle"
    echo -e "   ${DIM}Agents: ${SELECTED_AGENTS[*]}${NC}"
    echo -e "   ${DIM}Commands: ${SELECTED_COMMANDS[*]}${NC}"
}

custom_selection() {
    echo ""
    echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}  📦 AVAILABLE AGENTS${NC}"
    echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    # Development Agents
    echo -e "${MAGENTA}Development:${NC}"
    show_agent_option "nextjs-developer" "Next.js Developer" "App Router, Server Components, React Compiler"
    show_agent_option "react-specialist" "React Specialist" "Hooks, patterns, performance optimization"
    show_agent_option "typescript-pro" "TypeScript Pro" "Type-safe code, generics, advanced patterns"
    show_agent_option "mobile-developer" "Mobile Developer" "React Native and Expo expert"
    echo ""

    # Backend Agents
    echo -e "${MAGENTA}Backend:${NC}"
    show_agent_option "convex-expert" "Convex Expert" "Schema, queries, mutations, real-time"
    show_agent_option "stripe-expert" "Stripe Expert" "Payments, subscriptions, webhooks"
    show_agent_option "clerk-expert" "Clerk Expert" "Auth, user management, organizations"
    echo ""

    # Quality Agents
    echo -e "${MAGENTA}Quality:${NC}"
    show_agent_option "code-reviewer" "Code Reviewer" "Quality, security, best practices"
    show_agent_option "debugger" "Debugger" "Root cause analysis, problem-solving"
    show_agent_option "test-automator" "Test Automator" "Unit, integration, E2E tests"
    echo ""

    # DevOps Agents
    echo -e "${MAGENTA}DevOps:${NC}"
    show_agent_option "deployment-engineer" "Deployment Engineer" "CI/CD, Docker, cloud deployment"
    show_agent_option "git-workflow-manager" "Git Workflow Manager" "Branching, PR workflows, releases"
    echo ""

    # UI Agents
    echo -e "${MAGENTA}UI/Design:${NC}"
    show_agent_option "shadcn-ui-expert" "shadcn/ui Expert" "Components, theming, accessibility"
    show_agent_option "documentation-engineer" "Documentation Engineer" "API docs, guides, READMEs"
    echo ""

    echo -e "${DIM}Enter agent IDs separated by spaces (e.g., 'nextjs-developer code-reviewer'):${NC}"
    read -p "> " agent_input

    if [ -n "$agent_input" ]; then
        IFS=' ' read -ra SELECTED_AGENTS <<< "$agent_input"
    fi

    echo ""
    echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}  📋 AVAILABLE COMMANDS${NC}"
    echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    show_command_option "verify" "/verify" "Quick verification - console, network, screenshots"
    show_command_option "responsive" "/responsive" "Test responsive design across breakpoints"
    echo ""

    echo -e "${DIM}Enter command IDs separated by spaces (e.g., 'verify responsive'):${NC}"
    read -p "> " command_input

    if [ -n "$command_input" ]; then
        IFS=' ' read -ra SELECTED_COMMANDS <<< "$command_input"
    fi

    echo ""
    if [ ${#SELECTED_AGENTS[@]} -gt 0 ] || [ ${#SELECTED_COMMANDS[@]} -gt 0 ]; then
        log_success "Custom selection complete"
        [ ${#SELECTED_AGENTS[@]} -gt 0 ] && echo -e "   ${DIM}Agents: ${SELECTED_AGENTS[*]}${NC}"
        [ ${#SELECTED_COMMANDS[@]} -gt 0 ] && echo -e "   ${DIM}Commands: ${SELECTED_COMMANDS[*]}${NC}"
    else
        log_info "No add-ons selected"
    fi
}

show_agent_option() {
    local id="$1"
    local name="$2"
    local desc="$3"

    if check_if_installed "agent" "$id"; then
        echo -e "   ${GREEN}✓${NC} ${DIM}${id}${NC} - ${name} ${GREEN}(installed)${NC}"
    else
        echo -e "   ${CYAN}○${NC} ${BOLD}${id}${NC} - ${name}"
        echo -e "     ${DIM}${desc}${NC}"
    fi
}

show_command_option() {
    local id="$1"
    local name="$2"
    local desc="$3"

    if check_if_installed "command" "$id"; then
        echo -e "   ${GREEN}✓${NC} ${DIM}${id}${NC} - ${name} ${GREEN}(installed)${NC}"
    else
        echo -e "   ${CYAN}○${NC} ${BOLD}${id}${NC} - ${name}"
        echo -e "     ${DIM}${desc}${NC}"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# Installation Functions
# ═══════════════════════════════════════════════════════════════════════════════

create_directories() {
    log_info "Creating directories..."

    mkdir -p "$CLAUDE_DIR/agents"
    mkdir -p "$CLAUDE_DIR/commands"
    mkdir -p "$CLAUDE_DIR/templates/themes"

    log_success "Directories created"
}

download_file() {
    local url="$1"
    local dest="$2"

    if command -v curl &> /dev/null; then
        curl -fsSL "$url" -o "$dest" 2>/dev/null
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$dest" 2>/dev/null
    else
        log_error "Neither curl nor wget found. Please install one."
        exit 1
    fi
}

install_forge() {
    log_info "Installing FORGE v3.1 core..."
    echo ""

    # Download command definition (main FORGE command)
    log_info "Downloading FORGE command..."
    download_file "$REPO_URL/commands/forge.md" "$CLAUDE_DIR/commands/forge.md"
    log_success "Command installed: ~/.claude/commands/forge.md"

    # Download themes
    log_info "Downloading theme presets..."
    download_file "$REPO_URL/templates/themes/minimal-light.css" "$CLAUDE_DIR/templates/themes/minimal-light.css"
    download_file "$REPO_URL/templates/themes/dark-techy.css" "$CLAUDE_DIR/templates/themes/dark-techy.css"
    download_file "$REPO_URL/templates/themes/vibrant-purple.css" "$CLAUDE_DIR/templates/themes/vibrant-purple.css"
    log_success "Themes installed: ~/.claude/templates/themes/"

    echo ""
}

install_selected_items() {
    local installed_agents=0
    local installed_commands=0
    local skipped=0

    # Install selected agents
    if [ ${#SELECTED_AGENTS[@]} -gt 0 ]; then
        echo ""
        log_info "Installing selected agents..."

        for agent in "${SELECTED_AGENTS[@]}"; do
            if check_if_installed "agent" "$agent"; then
                echo -e "   ${DIM}Skipping ${agent} (already installed)${NC}"
                ((skipped++))
            else
                if download_file "$REPO_URL/catalog/agents/${agent}.md" "$CLAUDE_DIR/agents/${agent}.md"; then
                    log_success "Installed: ${agent}"
                    ((installed_agents++))
                else
                    log_warning "Failed to download: ${agent}"
                fi
            fi
        done
    fi

    # Install selected commands
    if [ ${#SELECTED_COMMANDS[@]} -gt 0 ]; then
        echo ""
        log_info "Installing selected commands..."

        for cmd in "${SELECTED_COMMANDS[@]}"; do
            if check_if_installed "command" "$cmd"; then
                echo -e "   ${DIM}Skipping ${cmd} (already installed)${NC}"
                ((skipped++))
            else
                if download_file "$REPO_URL/catalog/commands/${cmd}.md" "$CLAUDE_DIR/commands/${cmd}.md"; then
                    log_success "Installed: /${cmd}"
                    ((installed_commands++))
                else
                    log_warning "Failed to download: ${cmd}"
                fi
            fi
        done
    fi

    if [ $installed_agents -gt 0 ] || [ $installed_commands -gt 0 ]; then
        echo ""
        log_success "Installed ${installed_agents} agent(s), ${installed_commands} command(s)"
        [ $skipped -gt 0 ] && echo -e "   ${DIM}Skipped ${skipped} item(s) (already installed)${NC}"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# Post-Installation Summary
# ═══════════════════════════════════════════════════════════════════════════════

print_summary() {
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  ✅ FORGE v3.1 INSTALLED SUCCESSFULLY${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${BOLD}📁 Core Files Installed:${NC}"
    echo "   ~/.claude/commands/forge.md"
    echo "   ~/.claude/templates/themes/minimal-light.css"
    echo "   ~/.claude/templates/themes/dark-techy.css"
    echo "   ~/.claude/templates/themes/vibrant-purple.css"
    echo ""

    if [ ${#SELECTED_AGENTS[@]} -gt 0 ]; then
        echo -e "${BOLD}🤖 Agents Installed:${NC}"
        for agent in "${SELECTED_AGENTS[@]}"; do
            if [ -f "$CLAUDE_DIR/agents/${agent}.md" ]; then
                echo -e "   ${GREEN}✓${NC} ${agent}"
            fi
        done
        echo ""
    fi

    if [ ${#SELECTED_COMMANDS[@]} -gt 0 ]; then
        echo -e "${BOLD}📋 Commands Installed:${NC}"
        for cmd in "${SELECTED_COMMANDS[@]}"; do
            if [ -f "$CLAUDE_DIR/commands/${cmd}.md" ]; then
                echo -e "   ${GREEN}✓${NC} /${cmd}"
            fi
        done
        echo ""
    fi

    echo -e "${BOLD}🚀 Usage:${NC}"
    echo ""
    echo "   1. Start Claude Code:"
    echo -e "      ${CYAN}claude${NC}"
    echo ""
    echo "   2. Run FORGE:"
    echo -e "      ${CYAN}/forge${NC}"
    echo ""
    echo "   3. FORGE will:"
    echo "      → Analyze your environment"
    echo "      → Ask about your vision"
    echo "      → Research the market (optional)"
    echo "      → Generate a PRD"
    echo "      → Ask EVERY technical question"
    echo "      → Recommend Skill Packs"
    echo "      → Scaffold your project"
    echo ""

    echo -e "${BOLD}📚 What FORGE Creates:${NC}"
    echo "   • docs/PRD.md - Product requirements"
    echo "   • docs/FEATURES.md - Feature backlog"
    echo "   • docs/USER-STORIES.md - Test scenarios"
    echo "   • CLAUDE.md - AI context"
    echo "   • Full project structure"
    echo ""

    echo -e "${YELLOW}💡 Tip: FORGE asks EVERY question - nothing is assumed!${NC}"
    echo ""

    if [ ${#SELECTED_AGENTS[@]} -eq 0 ] && [ ${#SELECTED_COMMANDS[@]} -eq 0 ]; then
        echo -e "${DIM}Want more? Re-run the installer anytime to add agents and commands.${NC}"
        echo ""
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# Main
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    print_banner
    detect_environment

    echo -e "${BOLD}Ready to install FORGE v3.1?${NC}"
    echo ""
    read -p "Press Enter to continue or Ctrl+C to cancel..."
    echo ""

    create_directories
    install_forge

    # Show catalog menu for optional add-ons
    show_catalog_menu

    # Install selected items
    install_selected_items

    print_summary
}

# Run main function
main "$@"
