# Fish shell completions for claude code
# https://github.com/scaryrawr/claude-code.fish

# Disable file completions by default
complete -c claude -f

# Helper functions for dynamic completions
function __claude_installed_plugins
    set -l json (claude plugin list --json 2>/dev/null | string join ' ')
    test -n "$json"; or return
    set -l json (string replace -ra '\}\s*,\s*\{' '}\n{' -- $json)
    for chunk in (string split \n -- $json)
        set -l id (string match -r '"id"\s*:\s*"([^"]*)"' -- $chunk)[2]
        if test -n "$id"
            echo $id
        end
    end
end

function __claude_enabled_plugins
    set -l json (claude plugin list --json 2>/dev/null | string join ' ')
    test -n "$json"; or return
    set -l json (string replace -ra '\}\s*,\s*\{' '}\n{' -- $json)
    for chunk in (string split \n -- $json)
        set -l id (string match -r '"id"\s*:\s*"([^"]*)"' -- $chunk)[2]
        set -l enabled (string match -r '"enabled"\s*:\s*(true|false)' -- $chunk)[2]
        if test -n "$id" -a "$enabled" = true
            echo $id
        end
    end
end

function __claude_disabled_plugins
    set -l json (claude plugin list --json 2>/dev/null | string join ' ')
    test -n "$json"; or return
    set -l json (string replace -ra '\}\s*,\s*\{' '}\n{' -- $json)
    for chunk in (string split \n -- $json)
        set -l id (string match -r '"id"\s*:\s*"([^"]*)"' -- $chunk)[2]
        set -l enabled (string match -r '"enabled"\s*:\s*(true|false)' -- $chunk)[2]
        if test -n "$id" -a "$enabled" = false
            echo $id
        end
    end
end

function __claude_available_plugins
    set -l json (claude plugin list --json --available 2>/dev/null | string join ' ')
    test -n "$json"; or return
    set -l available (string match -r '"available"\s*:\s*\[(.*)' -- $json)[2]
    test -n "$available"; or return
    set -l available (string replace -ra '\}\s*,\s*\{' '}\n{' -- $available)
    for chunk in (string split \n -- $available)
        set -l id (string match -r '"pluginId"\s*:\s*"([^"]*)"' -- $chunk)[2]
        set -l desc (string match -r '"description"\s*:\s*"([^"]*)"' -- $chunk)[2]
        if test -n "$id"
            echo -e "$id\t$desc"
        end
    end
end

function __claude_marketplace_names
    set -l json (claude plugin marketplace list --json 2>/dev/null | string join ' ')
    test -n "$json"; or return
    set -l json (string replace -ra '\}\s*,\s*\{' '}\n{' -- $json)
    for chunk in (string split \n -- $json)
        set -l name (string match -r '"name"\s*:\s*"([^"]*)"' -- $chunk)[2]
        set -l source (string match -r '"source"\s*:\s*"([^"]*)"' -- $chunk)[2]
        if test -n "$name"
            echo -e "$name\t$source"
        end
    end
end

# Main options
complete -c claude -l add-dir -d "Additional directories to allow tool access to"
complete -c claude -l agent -d "Agent for the current session"
complete -c claude -l agents -d "JSON object defining custom agents"
complete -c claude -l allow-dangerously-skip-permissions -d "Enable bypassing permission checks as an option"
complete -c claude -l allowedTools -l allowed-tools -d "Comma or space-separated list of tool names to allow"
complete -c claude -l append-system-prompt -d "Append a system prompt to the default system prompt"
complete -c claude -l betas -d "Beta headers to include in API requests"
complete -c claude -l chrome -d "Enable Claude in Chrome integration"
complete -c claude -s c -l continue -d "Continue the most recent conversation"
complete -c claude -l dangerously-skip-permissions -d "Bypass all permission checks"
complete -c claude -s d -l debug -d "Enable debug mode with optional category filtering"
complete -c claude -l debug-file -d "Write debug logs to a specific file path"
complete -c claude -l disable-slash-commands -d "Disable all skills"
complete -c claude -l disallowedTools -l disallowed-tools -d "Comma or space-separated list of tool names to deny"
complete -c claude -l fallback-model -d "Enable automatic fallback to specified model"
complete -c claude -l file -d "File resources to download at startup"
complete -c claude -l fork-session -d "When resuming, create a new session ID"
complete -c claude -l from-pr -d "Resume a session linked to a PR by PR number/URL"
complete -c claude -s h -l help -d "Display help for command"
complete -c claude -l ide -d "Automatically connect to IDE on startup"
complete -c claude -l include-partial-messages -d "Include partial message chunks (with --print and --output-format=stream-json)"
complete -c claude -l input-format -xa "text stream-json" -d "Input format (only works with --print)"
complete -c claude -l json-schema -d "JSON Schema for structured output validation"
complete -c claude -l max-budget-usd -d "Maximum dollar amount to spend on API calls"
complete -c claude -l mcp-config -d "Load MCP servers from JSON files or strings"
complete -c claude -l mcp-debug -d "[DEPRECATED] Enable MCP debug mode"
complete -c claude -l model -d "Model for the current session"
complete -c claude -l no-chrome -d "Disable Claude in Chrome integration"
complete -c claude -l no-session-persistence -d "Disable session persistence"
complete -c claude -l output-format -xa "text json stream-json" -d "Output format (only works with --print)"
complete -c claude -l permission-mode -xa "acceptEdits bypassPermissions default delegate dontAsk plan" -d "Permission mode to use for the session"
complete -c claude -l plugin-dir -d "Load plugins from directories for this session only"
complete -c claude -s p -l print -d "Print response and exit (useful for pipes)"
complete -c claude -l replay-user-messages -d "Re-emit user messages from stdin (with stream-json)"
complete -c claude -s r -l resume -d "Resume a conversation by session ID or open interactive picker"
complete -c claude -l session-id -d "Use a specific session ID (must be a valid UUID)"
complete -c claude -l setting-sources -d "Comma-separated list of setting sources to load"
complete -c claude -l settings -d "Path to a settings JSON file or a JSON string"
complete -c claude -l strict-mcp-config -d "Only use MCP servers from --mcp-config"
complete -c claude -l system-prompt -d "System prompt to use for the session"
complete -c claude -l tools -d "Specify the list of available tools from built-in set"
complete -c claude -l verbose -d "Override verbose mode setting from config"
complete -c claude -s v -l version -d "Output the version number"

# Main commands
complete -c claude -n __fish_use_subcommand -xa "doctor" -d "Check the health of your Claude Code auto-updater"
complete -c claude -n __fish_use_subcommand -xa "install" -d "Install Claude Code native build"
complete -c claude -n __fish_use_subcommand -xa "mcp" -d "Configure and manage MCP servers"
complete -c claude -n __fish_use_subcommand -xa "plugin" -d "Manage Claude Code plugins"
complete -c claude -n __fish_use_subcommand -xa "setup-token" -d "Set up a long-lived authentication token"
complete -c claude -n __fish_use_subcommand -xa "update upgrade" -d "Check for updates and install if available"

# MCP subcommands
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "add" -d "Add an MCP server to Claude Code"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "add-from-claude-desktop" -d "Import MCP servers from Claude Desktop"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "add-json" -d "Add an MCP server with a JSON string"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "get" -d "Get details about an MCP server"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "list" -d "List configured MCP servers"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "remove" -d "Remove an MCP server"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "reset-project-choices" -d "Reset all approved and rejected project-scoped servers"
complete -c claude -n "__fish_seen_subcommand_from mcp" -xa "serve" -d "Start the Claude Code MCP server"

# MCP add options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -l callback-port -d "Fixed port for OAuth callback"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -l client-id -d "OAuth client ID for HTTP/SSE servers"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -l client-secret -d "Prompt for OAuth client secret"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -s e -l env -d "Set environment variables (e.g. -e KEY=value)"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -s H -l header -d "Set WebSocket headers"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -s s -l scope -xa "local user project" -d "Configuration scope"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add" -s t -l transport -xa "stdio sse http" -d "Transport type for MCP server"

# MCP remove options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from remove" -s s -l scope -xa "local user project" -d "Configuration scope"

# MCP add-json options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add-json" -l client-secret -d "Prompt for OAuth client secret"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add-json" -s s -l scope -xa "local user project" -d "Configuration scope"

# MCP add-from-claude-desktop options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from add-from-claude-desktop" -s s -l scope -xa "local user project" -d "Configuration scope"

# MCP serve options
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from serve" -s d -l debug -d "Enable debug mode"
complete -c claude -n "__fish_seen_subcommand_from mcp; and __fish_seen_subcommand_from serve" -l verbose -d "Override verbose mode setting from config"

# Plugin subcommands
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "disable" -d "Disable an enabled plugin"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "enable" -d "Enable a disabled plugin"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "install i" -d "Install a plugin from available marketplaces"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "list" -d "List installed plugins"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "marketplace" -d "Manage Claude Code marketplaces"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "uninstall remove" -d "Uninstall an installed plugin"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "update" -d "Update a plugin to the latest version"
complete -c claude -n "__fish_seen_subcommand_from plugin" -xa "validate" -d "Validate a plugin or marketplace manifest"

# Plugin install options
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from install i" -s s -l scope -xa "user project local" -d "Installation scope"
# Plugin install dynamic completions (available plugins)
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from install i" -xa "(__claude_available_plugins)"

# Plugin uninstall options
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from uninstall remove" -s s -l scope -xa "user project local" -d "Uninstall from scope"
# Plugin uninstall dynamic completions (installed plugins)
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from uninstall remove" -xa "(__claude_installed_plugins)"

# Plugin enable options
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from enable" -s s -l scope -xa "user project local" -d "Installation scope"
# Plugin enable dynamic completions (disabled plugins)
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from enable" -xa "(__claude_disabled_plugins)"

# Plugin disable options
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from disable" -s a -l all -d "Disable all enabled plugins"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from disable" -s s -l scope -xa "user project local" -d "Installation scope"
# Plugin disable dynamic completions (enabled plugins)
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from disable" -xa "(__claude_enabled_plugins)"

# Plugin update options
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from update" -s s -l scope -xa "user project local managed" -d "Installation scope"
# Plugin update dynamic completions (installed plugins)
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from update" -xa "(__claude_installed_plugins)"

# Plugin marketplace subcommands
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace" -xa "add" -d "Add a marketplace from a URL, path, or GitHub repo"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace" -xa "list" -d "List all configured marketplaces"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace" -xa "remove rm" -d "Remove a configured marketplace"
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace" -xa "update" -d "Update marketplace(s) from their source"

# Plugin marketplace remove dynamic completions
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace; and __fish_seen_subcommand_from remove rm" -xa "(__claude_marketplace_names)"
# Plugin marketplace update dynamic completions
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace; and __fish_seen_subcommand_from update" -xa "(__claude_marketplace_names)"

# Plugin marketplace list options
complete -c claude -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from marketplace; and __fish_seen_subcommand_from list" -l json -d "Output as JSON"

# Install command options
complete -c claude -n "__fish_seen_subcommand_from install" -l force -d "Force installation even if already installed"
complete -c claude -n "__fish_seen_subcommand_from install" -xa "stable latest" -d "Version target"
