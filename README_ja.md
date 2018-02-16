# starttig

starttig は、 Vim からの [tig](http://jonas.nitro.dk/tig/)  開始をサポートするVimプラグインです。tig のオプション等の補完やコマンド終了後の hit-enter プロンプトを抑止します。

## Requirements

* vim
* tig

## Installation

* 一般的な Vim スクリプトと同じようにインストールできます。

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
