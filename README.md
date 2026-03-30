# Roadtrain

<div align="center">
  <img src="roadtrain.webp" alt="A road train">
  <br>
  <sub>
    Photo by <a href="https://commons.wikimedia.org/wiki/File:MGM_C509_Quad_Road_Train.jpg">SquiddyFish</a>
  </sub>
</div>

## Overview

Roadtrain is a [neovim](https://github.com/neovim/neovim) plugin that provides a visual warning when lines are very long by highlighting any parts over a configurable column limit.

It is a re-implementation of [vim-lengthmatters](https://github.com/whatyouhide/vim-lengthmatters) in lua, reduced to the minimum functionality that I personally use.

## Installation

Install using your package manager of choice, and call `setup()`.

For example, using the built-in `vim.pack`:

```lua
local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
  {
    src = gh('smlx/roadtrain'),
  },
})
require('roadtrain').setup()
```

## Usage

The plugin enables highlighting by default.
Use `<leader>t` to toggle highlighting in a window.

By default in neovim `<leader>` is `\`.

## Configuration

There are some configuration options that can be set by passing an options table to the `setup()` function.
The defaults are shown below.

```lua
require('roadtrain').setup({
  -- columns greater than this number containing text are highlighted
  column_limit = 80,
  -- use this highlight group on the text
  highlight_group = 'ErrorMsg',
  -- toggle highlighting using this key
  toggle_key = '<leader>l',
  -- windows default to highlighting long lines
  default_on = true,
  -- do not highlight these filetypes by default when default_on is enabled
  exclude_filetypes = {
    markdown = true,
    text = true,
    help = true,
  }
})
```
