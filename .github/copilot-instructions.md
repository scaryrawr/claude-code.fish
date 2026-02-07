# Copilot Instructions

Fish shell completions for [Claude Code](https://docs.claude.ai/en/docs/claude-code).

## Architecture

Single-file completion script at `completions/claude.fish`. Fish automatically loads completions from this directory when installed via Fisher. There are no build steps, dependencies, or test suites.

## Fish Completion Patterns

- `complete -c claude -f` must remain the first line (disables file completions)
- `complete -c claude -n __fish_use_subcommand` for top-level subcommands
- `complete -c claude -n "__fish_seen_subcommand_from <cmd>"` for nested subcommands
- Use `-xa` for exclusive completion values (e.g., `-xa "text json stream-json"`)
- Use `-s` for short flags and `-l` for long flags
- Use `-d` for descriptions — should match the CLI help text

## Testing Changes

```fish
source completions/claude.fish
complete -C "claude "
complete -C "claude mcp "
complete -C "claude --output-format "
```

## Adding New Completions

1. Run `claude --help` and `claude <subcommand> --help` to get current CLI options
2. Compare help output against existing completions to find additions, removals, or changed descriptions
3. Follow existing patterns: top-level flags, subcommands (`__fish_use_subcommand`), nested subcommands (`__fish_seen_subcommand_from`), and subcommand-specific flags
4. Group related completions together with section comments
5. See `.github/skills/update-completions/SKILL.md` for the full update procedure and list of all help commands to check
