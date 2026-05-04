# homebrew-pling

Homebrew tap for [Pling](https://plingpush.com) — connect this machine to your Pling app.

## Install

```sh
brew install jeramo/pling/pling
```

Then set your API token (find it in the Pling app under Settings → Hosts → Add agent). This also starts the service:

```sh
pling set-token <YOUR_TOKEN>
```

## CLI

```
pling serve              run the agent (foreground)
pling status             service state, version, config path
pling logs [-f]          recent agent logs (-f to follow)
pling start | stop | restart
pling set-token <token>  update token and restart
pling config [edit]      print path or open in $EDITOR
pling open               open the local web UI
pling uninstall          remove agent, config, and service
pling version
```

## Upgrade

```sh
brew upgrade pling
brew services restart pling
```
