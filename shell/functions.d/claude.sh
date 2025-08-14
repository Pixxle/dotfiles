install_mcp() {
    echo "Installing Claude..."
    # Add your installation commands here
    /Users/dennis/.claude/local/claude mcp add context7 -- npx -y @upstash/context7-mcp
    /Users/dennis/.claude/local/claude mcp add sequential-thinking npx -- -y @modelcontextprotocol/server-sequential-thinking
    /Users/dennis/.claude/local/claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project $(pwd)
    /Users/dennis/.claude/local/claude mcp add puppeteer-mcp-server -- npx -y @puppeteer-mcp-server
    echo "Claude installed successfully."
}

alias claude-yolo='claude --dangerously-skip-permissions'
