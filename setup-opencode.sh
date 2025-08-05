 #!/bin/bash

# Agent OS opencode Setup Script
# This script installs Agent OS commands for opencode

set -e  # Exit on error

echo "🚀 Agent OS opencode Setup"
echo "============================="
echo ""

# Check if Agent OS base installation is present
if [ ! -d "$HOME/.agent-os/instructions" ] || [ ! -d "$HOME/.agent-os/standards" ]; then
    echo "⚠️  Agent OS base installation not found!"
    echo ""
    echo "Please install the Agent OS base installation first:"
    echo ""
    echo "Option 1 - Automatic installation:"
    echo "  curl -sSL https://raw.githubusercontent.com/buildermethods/agent-os/main/setup.sh | bash"
    echo ""
    echo "Option 2 - Manual installation:"
    echo "  Follow instructions at https://buildermethods.com/agent-os"
    echo ""
    exit 1
fi

# Base URL for raw GitHub content
BASE_URL="https://raw.githubusercontent.com/buildermethods/agent-os/main"

# Create directories
echo "📁 Creating directories..."
mkdir -p "$HOME/.config/opencode/agent"

# Download command files for opencode
echo ""
echo "📥 Downloading opencode config file to ~/."

if [ -f "./opencode.json" ]; then
    echo "  ⚠️  ./opencode.json already exists - skipping"
else
    curl -s -o "./opencode.json" "${BASE_URL}/opencode/opencode.json"
    echo "  ✓ ./opencode.json"
fi

# Download AGENT.md 
echo ""
echo "📥 Downloading opencode rules to ./"

if [ -f "./AGENTS.md" ]; then
    echo "  ⚠️  ~/AGENTS.md already exists - skipping"
else
    curl -s -o "./AGENTS.md" "${BASE_URL}/opencode/user/AGENTS.md"
    echo "  ✓ ./AGENTS.md"
fi

# Download opencode agents
echo ""
echo "📥 Downloading opencode agents to ~/.config/opencode/agent/"

# List of agent files to download
agents=("test-runner" "context-fetcher" "git-workflow" "file-creator")

for agent in "${agents[@]}"; do
    if [ -f "$HOME/.config/opencode/agent/${agent}.md" ]; then
        echo "  ⚠️  ~/.config/opencode/agent/${agent}.md already exists - skipping"
    else
        curl -s -o "$HOME/.config/opencode/agent/${agent}.md" "${BASE_URL}/opencode/agents/${agent}.md"
        echo "  ✓ ~/.config/opencode/agent/${agent}.md"
    fi
done

echo ""
echo "✅ Agent OS opencode installation complete!"
echo ""
echo "📍 Files installed to:"
echo "   ~/.config/opencode/agents/  - opencode specialized subagents"
echo "   ./opencode.json             - opencode configuration"
echo "   ./AGENTS.md                 - opencode rules
echo ""
echo "Next steps:"
echo ""
echo "Initiate Agent OS in a new product's codebase with:"
echo "  /plan-product"
echo ""
echo "Initiate Agent OS in an existing product's codebase with:"
echo "  /analyze-product"
echo ""
echo "Initiate a new feature with:"
echo "  /create-spec (or simply ask 'what's next?')"
echo ""
echo "Build and ship code with:"
echo "  /execute-task"
echo ""
echo "Learn more at https://buildermethods.com/agent-os"
echo ""
