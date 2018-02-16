# starttig

starttig is vim plug-in to support starting [tig](http://jonas.nitro.dk/tig/) from vim. it's enable options/refs input completion and suppress hit-enter prompt.

## Requirements

* vim
* tig

## Installation

* Install startig like as general vim plug-ins

## Usage

start `tig`

```vim
:Stig
```

start `tig` with `topic/foo`

```vim
:Stig topic/foo
```

start `tig blame` with current edit file

```vim
:Stig blame
```

## Customize

Change command name.

```vim
call starttig#SetTigCmdName("Tig")
```

Set default options (it's enable when passed options is blanked).

```vim
call starttig#SetTigBlankedOpt(["--all"])
```
(Acceptable opttions is '--all' and '--topo-oroder' only yet)


## License

Copyright (c) 2018 hankei6km

Licensed under the MIT License. See LICENSE.txt in the project root.
