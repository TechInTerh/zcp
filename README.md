# ZCP

zcp is a more transparent version of cp. 
It has the same functionnality, but shows to the user the current status of the copy with a progress bar.

This plugin is under development, this is the alpha version.

## Installation

### Oh-my-zsh
Install via omz plugin manager 
```sh
git clone https://github.com/TechInTerh/zcp $ZSH_CUSTOM/plugins/
omz plugin enable zcp
```

## Usage

zcp should work such as cp.
```
zcp <source1> [source2...] target
```

## Current Features

For now, zcp reads all output of cp thanks to strace, calculate the remaining size to copy, and display the status with [tqdm](https://github.com/tqdm/tqdm).

## Planned Features
- Fix all corner case (missing input, no permission...)
- Same features for mv
- More informations displayed for the user (time estimation, current file copying...)
- Documentation, and optional arguments

For now, ZCP il slightly slower compared to cp.