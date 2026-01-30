#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
# FORGE v3.0 - Installation Script
# Complete Product Companion for Claude Code
# ═══════════════════════════════════════════════════════════════════════════════

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Configuration
CLAUDE_DIR="$HOME/.claude"
REPO_URL="https://raw.githubusercontent.com/agentik-os/forge/main"

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
    echo -e "${BOLD}FORGE v3.0 - Complete Product Companion${NC}"
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

            # List specific agents
            if [ -f "$CLAUDE_DIR/agents/ralph.md" ] || [ -f "$CLAUDE_DIR/commands/ralph.md" ]; then
                log_success "  → Ralph (autonomous development)"
                RALPH_INSTALLED=true
            fi

            if [ -f "$CLAUDE_DIR/agents/maniac.md" ] || [ -f "$CLAUDE_DIR/commands/maniac.md" ]; then
                log_success "  → MANIAC (deep testing)"
                MANIAC_INSTALLED=true
            fi

            if [ -f "$CLAUDE_DIR/agents/sentinel.md" ] || [ -f "$CLAUDE_DIR/commands/sentinel.md" ]; then
                log_success "  → Sentinel (continuous testing)"
                SENTINEL_INSTALLED=true
            fi

            if [ -f "$CLAUDE_DIR/agents/bmad.md" ] || [ -f "$CLAUDE_DIR/commands/bmad.md" ]; then
                log_success "  → BMAD (agile workflows)"
                BMAD_INSTALLED=true
            fi
        fi

        # Check for existing commands
        if [ -d "$CLAUDE_DIR/commands" ]; then
            CMD_COUNT=$(ls -1 "$CLAUDE_DIR/commands"/*.md 2>/dev/null | wc -l || echo "0")
            log_info "Found $CMD_COUNT command(s) in ~/.claude/commands/"
        fi

        # Check for templates
        if [ -d "$CLAUDE_DIR/templates" ]; then
            log_success "Templates directory exists"
        fi
    else
        log_warning "~/.claude/ not found - will create"
    fi

    # Detect project structure
    echo ""
    echo -e "${BOLD}📁 Project Directories:${NC}"

    # Common project locations
    for dir in "$HOME/projects" "$HOME/work" "$HOME/clients" "$HOME/VibeCoding" "$HOME/code" "$HOME/dev"; do
        if [ -d "$dir" ]; then
            PROJECT_COUNT=$(ls -d "$dir"/*/ 2>/dev/null | wc -l || echo "0")
            log_success "$dir ($PROJECT_COUNT projects)"
        fi
    done

    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# Installation
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
        curl -fsSL "$url" -o "$dest"
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$dest"
    else
        log_error "Neither curl nor wget found. Please install one."
        exit 1
    fi
}

install_forge() {
    log_info "Installing FORGE v3.0..."
    echo ""

    # Download agent definition
    log_info "Downloading agent definition..."
    download_file "$REPO_URL/agents/forge.md" "$CLAUDE_DIR/agents/forge.md"
    log_success "Agent installed: ~/.claude/agents/forge.md"

    # Download command definition
    log_info "Downloading command definition..."
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

# ═══════════════════════════════════════════════════════════════════════════════
# Post-Installation Summary
# ═══════════════════════════════════════════════════════════════════════════════

print_summary() {
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  ✅ FORGE v3.0 INSTALLED SUCCESSFULLY${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${BOLD}📁 Files Installed:${NC}"
    echo "   ~/.claude/agents/forge.md"
    echo "   ~/.claude/commands/forge.md"
    echo "   ~/.claude/templates/themes/minimal-light.css"
    echo "   ~/.claude/templates/themes/dark-techy.css"
    echo "   ~/.claude/templates/themes/vibrant-purple.css"
    echo ""

    echo -e "${BOLD}🤖 Agent Integration:${NC}"
    if [ "$RALPH_INSTALLED" = true ]; then
        echo -e "   ${GREEN}✓${NC} Ralph - FORGE will create @fix_plan.md for autonomous dev"
    else
        echo -e "   ${YELLOW}○${NC} Ralph - Not installed (optional)"
    fi

    if [ "$MANIAC_INSTALLED" = true ]; then
        echo -e "   ${GREEN}✓${NC} MANIAC - FORGE will create USER-STORIES.md for testing"
    else
        echo -e "   ${YELLOW}○${NC} MANIAC - Not installed (optional)"
    fi

    if [ "$SENTINEL_INSTALLED" = true ]; then
        echo -e "   ${GREEN}✓${NC} Sentinel - FORGE will set up .sentinel/ directory"
    else
        echo -e "   ${YELLOW}○${NC} Sentinel - Not installed (optional)"
    fi
    echo ""

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
}

# ═══════════════════════════════════════════════════════════════════════════════
# Main
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    print_banner
    detect_environment

    echo -e "${BOLD}Ready to install FORGE v3.0?${NC}"
    echo ""
    read -p "Press Enter to continue or Ctrl+C to cancel..."
    echo ""

    create_directories
    install_forge
    print_summary
}

# Run main function
main "$@"
