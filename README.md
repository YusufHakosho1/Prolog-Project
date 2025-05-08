## Overview

This Friendly Family Tree Project is a Prolog-based CLI application that lets you define individuals and parent–child relationships, then explore derived relations such as `father/2`, `mother/2`, `grandparent/2`, `sibling/2`, and `ancestor/2`. It includes an interactive menu for listing relationships, checking arbitrary pairs, and printing an indented descendant tree for any person.

## Table of Contents

- [Features](#features)  
- [Prerequisites](#prerequisites)  
- [Installation](#installation)  
  - [Windows](#windows)  
  - [macOS](#macos)  
  - [Linux (Ubuntu & Common Distros)](#linux-ubuntu--common-distros)  
- [Visual Studio Code Setup](#visual-studio-code-setup)  
- [Usage](#usage)  
- [Key Commands](#key-commands)  
- [Additional Resources](#additional-resources)

## Features

- Define people, genders, and parent relationships in a single `family.pl` file  
- Automatically derive and query common relations: father, mother, grandparent, sibling, ancestor  
- Interactive text-menu interface for browsing and querying  
- Recursive tree-printer for visualizing descendants

## Prerequisites

- **SWI-Prolog** (v7.6 or later)  
- **Visual Studio Code** (optional, but recommended for editing and integrated queries)  
- Internet access to download installers and extensions

## Installation

### Windows

1. **Download SWI-Prolog**: Get the 64-bit self-installing executable from the [SWI-Prolog website](https://www.swi-prolog.org/Download.html).  
2. **Run the installer**: Follow the default prompts.  
3. **Verify installation**:
   ```bash
   swipl --version
   ```

### macOS

#### Homebrew (recommended)

1. Install Homebrew if you haven’t already:
   ```bash
   /bin/bash -c "$(curl -fsSL https://brew.sh)"
   ```
2. Install SWI-Prolog via Homebrew:
   ```bash
   brew install swi-prolog
   ```
3. Verify installation:
   ```bash
   swipl --version
   ```

#### MacPorts (alternative)

1. Install MacPorts from https://www.macports.org  
2. Install SWI-Prolog:
   ```bash
   sudo port install swi-prolog
   ```
3. Verify installation:
   ```bash
   swipl --version
   ```

### Linux (Ubuntu & Common Distros)

#### Using the SWI-Prolog PPA (Ubuntu)

1. Open a terminal.  
2. Add the stable PPA and update:
   ```bash
   sudo add-apt-repository ppa:swi-prolog/stable
   sudo apt-get update
   ```
3. Install SWI-Prolog:
   ```bash
   sudo apt-get install swi-prolog
   ```

#### Snap (any distro with snapd)

```bash
sudo snap install swi-prolog --classic
```

#### From Source (advanced)

```bash
git clone https://github.com/SWI-Prolog/swipl-devel.git
cd swipl-devel
mkdir build && cd build
cmake ..
make
sudo make install
```

## Visual Studio Code Setup

1. **Open the project folder** containing `family.pl` in VS Code.  
2. **Install a Prolog extension**:
   - **VSC-Prolog** by Arthur Wang  
   - **New-VSC-Prolog** by Amaury Rabouan  
3. (Optional) Add settings in `.vscode/settings.json`:
   ```json
   {
     "prolog.executablePath": "/usr/local/bin/swipl",
     "prolog.formatOnSave": true
   }
   ```

## Usage

1. **Load the program** in your terminal or VS Code integrated console:
   ```bash
   swipl -q -l family.pl
   ```
2. **Interact with the menu**:
   - **1–6**: List fathers, mothers, grandparents, siblings, ancestors, or all people  
   - **7**: Check a specific relationship  
   - **8**: Print the descendant tree of a named individual  
   - **9**: Exit
3. **Run custom queries** directly:
   ```prolog
   ?- father(john, bob).
   ?- grandparent(john, oliver).
   ?- sibling(bob, alice).
   ```

## Key Commands

| Shortcut       | Action                                   |
| -------------- | ---------------------------------------- |
| **F5**         | Start a Prolog session                   |
| **Ctrl+Alt+X** | Run the selected query in Prolog console |
| **Ctrl+Space** | Trigger code completion                  |
| **Alt+P**      | Format the current Prolog file           |

## Additional Resources

- [SWI-Prolog Official Manual](https://www.swi-prolog.org/pldoc/doc_for?object=manual)  
- [Learn Prolog Now!](http://www.learnprolognow.org/)  
- [VSC-Prolog Extension (Arthur Wang)](https://marketplace.visualstudio.com/items?itemName=arthurwang.vsc-prolog)  
- [New-VSC-Prolog Extension (Amaury Rabouan)](https://marketplace.visualstudio.com/items?itemName=AmauryRabouan.new-vsc-prolog)  