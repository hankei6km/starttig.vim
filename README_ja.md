# starttig

starttig は、 Vim からの [Tig](http://jonas.nitro.dk/tig/)  開始をサポートするVimプラグインです。Tig のオプション等の補完やコマンド終了後の hit-enter プロンプトを抑止します。

## Requirements

* Vim
* tig

## Installation

### Vim パッケージ管理によるインストール(Vim 8 on linux).

```bash
mkdir -p ~/.vim/pack/git-plugins/start
git clone https://github.com/hankei6km/starttig.vim.git ~/.vim/pack/git-plugins/start/stattig.vim
```

help ファイルの作成例.

```bash
vim "+silent! helptags ALL" +qall
```

### [Vundle](https://github.com/VundleVim/Vundle.vim) によるインストール.

```vim
Plugin 'hankei6km/starttig.vim'
```

## Usage

`tig` を開始.

```vim
:Stig
```

`tig` に `topic/foo` を付加して開始.

```vim
:Stig topic/foo
```

編集中のファイルで `tig blame` を開始.

```vim
:Stig blame
```

## Customize

コマンド名を変更する.

```vim
call starttig#SetTigCmdName("Tig")
```

デフォルト(オプション無しのときの)のオプションをセットする

```vim
call starttig#SetTigBlankedOpt(["--all"])
```
(現状では、指定できるのは `--all` と `--topo-order` のみです).

## License

Copyright (c) 2018 hankei6km

Licensed under the MIT License. See LICENSE.txt in the project root.
