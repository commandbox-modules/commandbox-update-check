This module can check for new versions of the CLI and system modules every time you start the CLI in interactive mode.  An outbound internet connection is required for it to work.  

## Installation

Install the module like so:

```bash
install commandbox-update-check
```

# Configuration

You can turn module check on and off with the `enable` flag.  If you want to follow the bleeding edge version of CommandBox, set the `latest` flag.  

```bash
config set modules.commandbox-update-check.enable=false
config set modules.commandbox-update-check.latest=true
```

You can turn the CLI check specifically on and off with the `CLIcheck` flag and you can turn the system modules check on and off with the `systemModulesCheck` flag.    

```bash
config set modules.commandbox-update-check.CLIcheck=false
config set modules.commandbox-update-check.systemModulesCheck=false
```

## Usage

To use this module, simply start up your CommandBox shell in interactive mode and look for messages before the startup banner.