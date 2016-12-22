# Steam::Categorizer

Steam-Categorizer is a cross-platform solution to help you manage your Steam game library. It will fetch community defined tags for every game in your library and assign categories. The primary supported operating system is Linux, but it should also work on Mac OS X and Windows.

## Disclaimer

This project is still in alpha development stages and should be used with great care. I accept no responsibility for any data lost as the result of running this script. I highly recommend you **backup your sharedconfig.vdf** before overwriting it with the output from this script.

## Installation

```
Execute:

    $ rake install
```
## Usage
```
Execute:

    $ steam-categorizer -p steam_categorizer.json

Options:
  -b, --backup=<s>         Name of backup sharedconfig.vdf
  -c, --config=<s>         Location of existing sharedconfig.vdf
  -g, --gui, --no-gui      Whether to use a graphical user interface (default: true)
  -p, --preferences=<s>    Location of steam_categorizer preferences file (default: ~/.config/steam_categorizer.json)
  -t, --tag-prefix=<s>     Prefix for automatically categorized tags
  -u, --url-name=<s>       Custom URL name set in Profile
  -h, --help               Show this message
```
A sample preferences file can be found in example/steam_categorizer.json

If the --preferences parameter is omitted, steam-categorizer will default to ~/.config/steam_categorizer.json

If a tag prefix is specified, tags not matching it will be preserved

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lyle-tafoya/steam-categorizer.
