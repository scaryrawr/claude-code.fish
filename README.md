# claude-code.fish

Fish shell completions for [Claude Code](https://docs.claude.ai/en/docs/claude-code).

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install scaryrawr/claude-code.fish
```

## Features

Provides intelligent completions for:
- All `claude` command options and flags
- Subcommands: `mcp`, `plugin`, `setup-token`, `doctor`, `update`, `install`
- MCP server management commands
- Plugin management and marketplace commands
- Model names, permission modes, and output formats

## Usage

Just type `claude` and press <kbd>Tab</kbd> to see available options and commands:

```fish
claude <Tab>
claude mcp <Tab>
claude plugin <Tab>
claude --output-format <Tab>
```

## License

MIT
