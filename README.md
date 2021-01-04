dotfiles
========

install: (not tested with latest changes)

```sh
curl https://raw.githubusercontent.com/viktornonov/dotfiles/master/bootstrap.sh | bash
```

Install separate packages with GNU Stow
```sh
cd dotfiles/
" stow [PACKAGE] -t [TARGET-DIR]
stow vim -t ~
```


Troubleshooting:

If you get NSURLDomain Error -1012, make sure that the date/time is real.

It stops when goes between brew and cask apps in the Brewfile

