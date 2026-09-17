# Homebrew Tap for FortranGoingOnForty

Homebrew formulae for modern Fortran CLI tools and applications.

## Installation

```bash
brew tap FortranGoingOnForty/tap
```

## Available Formulas

| Formula | Description | Install |
|---------|-------------|---------|
| **armfortas** | Bespoke Fortran compiler for ARM64 and x86_64 | `brew install armfortas` |
| **facsimile** | Terminal text editor with VSCode-style keybindings | `brew install facsimile` |
| **ferp** | GNU grep clone written in Fortran | `brew install ferp` |
| **fit** | Terminal-based merge conflict resolver with three-pane TUI | `brew install fit` |
| **fortbite** | Calculator with arbitrary precision, complex numbers, and matrices | `brew install fortbite` |
| **fortress** | Command-line file explorer with cd-on-exit | `brew install fortress` |
| **fortsh** | Modern Unix shell with AST-based parsing | `brew install fortsh` |
| **fuss** | Tree utility for dirty git files | `brew install fuss` |
| **sniffert** | Terminal-based disk analyzer inspired by SpaceSniffer | `brew install sniffert` |

## Available Casks

| Cask | Description | Install |
|------|-------------|---------|
| **sniffly** | Fast, visual disk space analyzer with GTK4 GUI | `brew install --cask sniffly` |

## Quick Install Examples

```bash
# Install the tap first
brew tap FortranGoingOnForty/tap

# Then install any formula
brew install fortress
brew install facsimile
brew install fortsh
brew install armfortas

# Or install a cask
brew install --cask sniffly
```

## Requirements

Most formulas require:
- GCC (for gfortran)
- Some formulas have additional dependencies (fzf, pcre2, etc.) which Homebrew will install automatically

ARMFORTAS 0.1.x is a compiler preview for Apple Silicon macOS. It builds from
source with Rust and does not support Intel Macs.

## Links

- [FortranGoingOnForty Organization](https://github.com/FortranGoingOnForty)
