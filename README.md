# starttig

starttig is Vim plug-in to support starting [Tig](http://jonas.nitro.dk/tig/) from Vim. it's enable options/refs input completion and suppress hit-enter prompt.

## Requirements

* Vim
* Tig

## Installation

### Installation with Vim package management(Vim 8 on linux)

```bash
# ie.
mkdir -p ~/.vim/pack/git-plugins/start
git clone https://github.com/hankei6km/starttig.vim.git ~/.vim/pack/git-plugins/start/stattig.vim
```

Generating Vim help files.

```bash
# ie.
vim "+silent! helptags ALL" +qall
```

### Installation with [Vundle](https://github.com/VundleVim/Vundle.vim)

```vim
Plugin 'hankei6km/starttig.vim'
```

## Usage

Starting to `tig`

```vim
:Stig
```

Starting to `tig` with `topic/foo`

```vim
:Stig topic/foo
```

Starting to `tig blame` with current editing file

```vim
:Stig blame
```

## Customize

Customizing command name.

```vim
call starttig#SetTigCmdName("Tig")
```

Default options (it's enable when passed options is blanked).

```vim
call starttig#SetTigBlankedOpt(["--all"])
```
(Acceptable opttions is '--all' and '--topo-oroder' only yet)


## License

Copyright (c) 2018 hankei6km

Licensed under the MIT License. See LICENSE.txt in the project root.
