# Fish shell completions for claude code
# https://github.com/scaryrawr/claude-code.fish

# Disable file completions by default
complete -c claude -f

# Main options
complete -c claude -s d -l debug -d "Enable debug mode with optional category filtering"
complete -c claude -l verbose -d "Override verbose mode setting from config"
complete -c claude -s p -l print -d "Print response and exit (useful for pipes)"
complete -c claude -l output-format -xa "text json stream-json" -d "Output format (only works with --print)"
complete -c claude -l json-schema -d "JSON Schema for structured output validation"
complete -c claude -l include-partial-messages -d "Include partial message chunks (with --print and --output-format=stream-json)"
complete -c claude -l input-format -xa "text stream-json" -d "Input format (only works with --print)"
complete -c claude -l mcp-debug -d "[DEPRECATED] Enable MCP debug mode"
complete -c claude -l dangerously-skip-permissions -d "Bypass all permission checks"
complete -c claude -l allow-dangerously-skip-permissions -d "Enable bypassing permission checks as an option"
complete -c claude -l max-budget-usd -d "Maximum dollar amount to spend on API calls"
complete -c claude -l replay-user-messages -d "Re-emit user messages from stdin (with stream-json)"
complete -c claude -l allowedTools -l allowed-tools -d "Comma or space-separated list of tool names to allow"
complete -c claude -l tools -d "Specify the list of available tools from built-in set"
complete -c claude -l disallowedTools -l disallowed-tools -d "Comma or space-separated list of tool names to deny"
complete -c claude -l mcp-config -d "Load MCP servers from JSON files or strings"
complete -c claude -l system-prompt -d "System prompt to use for the session"
complete -c claude -l append-system-prompt -d "Append a system prompt to the default system prompt"
complete -c claude -l permission-mode -xa "acceptEdits bypassPermissions default delegate dontAsk plan" -d "Permission mode to use for the session"
complete -c claude -s c -l continue -d "Continue the most recent conversation"
complete -c claude -s r -l resume -d "Resume a conversation by session ID or open interactive picker"
complete -c claude -l fork-session -d "When resuming, create a new session ID"
complete -c claude -l no-session-persistence -d "Disable session persistence"
complete -c claude -l model -d "Model for the current session"
complete -c claude -l agent -d "Agent for the current session"
complete -c claude -l betas -d "Beta headers to include in API requests"
complete -c claude -l fallback-model -d "Enable automatic fallback to specified model"
complete -c claude -l settings -d "Path to a settings JSON file or a JSON string"
complete -c claude -l add-dir -d "Additional directories to allow tool access to"
complete -c claude -l ide -d "Automatically connect to IDE on startup"
complete -c claude -l strict-mcp-config -d "Only use MCP servers from --mcp-config"
complete -c claude -l session-id -d "Use a specific session ID (must be a valid UUID)"
complete -c claude -l agents -d "JSON object defining custom agents"
complete -c claude -l setting-sources -d "Comma-separated list of setting sources to load"
complete -c claude -l plugin-dir -d "Load plugins from directories for this session only"
complete -c claude -l disable-slash-commands -d "Disable all slash commands"
complete -c claude -s v -l version -d "Output the version number"
complete -c claude -s h -l help -d "Display help for command"

# Main commands
complete -c claude -n __fish_use_subcommand -xa "mcp" -d "Configure and manage MCP servers"
complete -c claude -n __fish_use_subcommand -xa "plugin" -d "Manage Claude Code plugins"
complete -c claude -n __fish_use_subcommand -xa "setup-token" -d "Set up a long-lived authentication token"
complete -c claude -n __fish_use_subcommand -xa "doctor" -d "Check the health of your Claude Code auto-updater"
complete -c claude -n __fish_use_subcommand -xa "update" -d "Check for updates and install if available"
complete -c claude -n __fish_use_subcommand -xa "install" -d "Install Claude Code native build"

# MCP subcommands
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "serve" -d "Start the Claude Code MCP server"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "add" -d "Add an MCP server to Claude Code"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "remove" -d "Remove an MCP server"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "list" -d "List configured MCP servers"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "get" -d "Get details about an MCP server"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "add-json" -d "Add an MCP server with a JSON string"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "add-from-claude-desktop" -d "Import MCP servers from Claude Desktop"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "reset-project-choices" -d "Reset all approved and rejected project-scoped servers"

# MCP add options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -l transport -xa "http sse stdio" -d "Transport type for MCP server"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -l env -d "Environment variables for the server"

# MCP remove options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from remove" -l force -d "Force removal without confirmation"

# MCP add-json options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add-json" -l transport -xa "stdio sse" -d "Transport type for MCP server"

# MCP add-from-claude-desktop options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add-from-claude-desktop" -l force -d "Overwrite existing servers with same names"

# Plugin subcommands
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "validate" -d "Validate a plugin or marketplace manifest"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "marketplace" -d "Manage Claude Code marketplaces"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "install i" -d "Install a plugin from available marketplaces"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "uninstall remove" -d "Uninstall an installed plugin"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "enable" -d "Enable a disabled plugin"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "disable" -d "Disable an enabled plugin"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "update" -d "Update a plugin to the latest version"

# Plugin install/uninstall/enable/disable/update options
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from install i" -l global -d "Install plugin globally"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from uninstall remove" -l global -d "Uninstall plugin globally"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from enable" -l global -d "Enable plugin globally"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from disable" -l global -d "Disable plugin globally"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from update" -l global -d "Update plugin globally"

# Plugin marketplace subcommands
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace" -xa "add" -d "Add a marketplace from a URL, path, or GitHub repo"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace" -xa "list" -d "List all configured marketplaces"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace" -xa "remove rm" -d "Remove a configured marketplace"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace" -xa "update" -d "Update marketplace(s) from their source"

# Install command options
complete -c claude -n "__fish_seen_subcommand_from install" -l force -d "Force installation even if already installed"
complete -c claude -n "__fish_seen_subcommand_from install" -xa "stable latest" -d "Version target"
