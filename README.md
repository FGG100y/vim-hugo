# vim-hugo

Blogging from the command line should not be tedious.

This script is intended to automate the process of creating
[Hugo](https://gohugo.io/) blog posts from within
[vim](http://www.vim.org/).

This is based on [juev/vim-hugo](https://github.com/juev/vim-hugo)

## Commands

The `:HugoPost` (Hugo post) command is used to create blog posts.

    :HugoPost[!]  [{name}] Create the specified post. With no argument,
                        you will be prompted to select a post or enter a title.

NOTE that if you input the name after `HugoPost` command, then the 'name' will be the
'title' as well (and this file will be saved to './content/posts/' as default), else the
title will be the one that prompted and what you input, while the filename will be
'index.md' (and saved to the current directory).

## Configuration

See `:help hugo-configuration`.

## License

Same as Vim itself, see `:help license`.
