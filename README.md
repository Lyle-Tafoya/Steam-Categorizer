# Steam::Categorizer

Steam-Categorizer is a cross-platform solution to help you manage your Steam game library. It will fetch community defined tags for every game in your library and assign categories.

## Installation

Execute:

    $ rake install

## Usage

```
Options:
  -u, --url-name=<s>       Custom URL name set in Profile
  -c, --config=<s>         Location of existing sharedconfig.vdf
  -p, --preferences=<s>    Location of steam_categorizer preferences file
  -h, --help               Show this message

```
A sample preferences file can be found in example/steam-categorizer.json

## Disclaimer

I accept no responsibility for any data lost as the result of running this script. I highly recommend you **backup your sharedconfig.vdf** before overwriting it with the output from this script. This project is still in alpha development stages and should be used with great care.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lyle-tafoya/steam-categorizer.
