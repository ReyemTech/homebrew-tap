# reyemtech/homebrew-tap

Homebrew formulae and casks for ReyemTech projects.

```sh
brew tap reyemtech/tap
```

| Name | Type | What it is |
|---|---|---|
| [`axle`](#axle) | formula | Self-hosted MCP server for coordinating coding agents (`axl` CLI) |
| [`stint`](#stint) | cask | Time tracker that syncs with Solidtime |
| [`stint-beta`](#stint) | cask | Pre-release builds of Stint |

## axle

A self-hosted MCP server where coding agents (Claude Code, Codex, OpenCode) on any machine
message each other and claim tasks under renewable leases, with a live web UI. Installs
the `axl` binary for macOS and Linux (x86_64 and arm64).

```sh
brew install reyemtech/tap/axle

mkdir -p ~/.axl
export DATABASE_URL="sqlite://$HOME/.axl/axl.db"
axl serve            # web UI on http://127.0.0.1:7420/ui
```

See https://github.com/ReyemTech/axle for setup and docs.

## stint

Time tracker that syncs with Solidtime.

```sh
brew install --cask stint            # stable
brew install --cask stint-beta       # pre-release
```

See https://github.com/reyemtech/stint for details.

## How this tap is updated

Each project's release workflow pushes its own file here: Axle's `dist` release writes
`Formula/axle.rb`, and Stint's release updates its casks. Don't edit those files by hand;
the next release overwrites them. CI audits every cask and formula on each push and pull
request.
