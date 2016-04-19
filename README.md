Marshak
=======
Marshak.vim is a lightweight Vim plugin to easily translation
using **[Translate Shell](https://github.com/soimort/translate-shell)**.

Prerequisites
-------------
Install **[Translate Shell](https://github.com/soimort/translate-shell/blob/develop/README.template.md#installation)**.

Installation
------------
### VimPlug:

Place this in your `.vimrc`:

`Plug 'SvichkarevAnatoly/marshak.vim'`

… then run the following in Vim:

```vim
:source %
:PlugInstall
```

There are another Vim plugin managers
(Pathogen, Vundle, NeoBundle).

Options (Default)
------------------------
|Flag|Default|Description|
|----|-------|-----------|
|`g:trans_command`|`trans`|Path to installed Translate Shell|
|`g:trans_source_lang`||Specify the source language (Google Translate can identify the language of the source text automatically)|
|`g:trans_target_lang`|`en`|Specify the target language|

Example `.vimrc`:
```vim
let g:trans_source_lang = "es"
let g:trans_target_lang = "ru"
```
for translation from Spanish to Russian.

For another language use **[Languages and corresponding codes](https://github.com/soimort/translate-shell#code-list)**.

Keybindings (Default)
-----------
- `<leader>tw` - Translate word under cursor
- `<leader>tl` - Translate current line
- `<leader>tv` - Translate selected in visual mode text
- `<leader>ts` - Translate sentence under cursor
- `<leader>ty` - Translate yanked text

License
-------
GPLv3.
