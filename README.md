# Steam::Categorizer

Steam-Categorizer is a cross-platform solution to help you manage your Steam game library. It will fetch community defined tags for every game in your library and assign categories.

## Installation

Execute:

    $ rake install

## Usage

```
Options:
  -k, --key=<s>            Steam API Key
  -i, --id=<s>             Steam ID
  -c, --config=<s>         Location of existing sharedconfig.vdf
  -o, --output=<s>         Location to output new sharedconfig.vdf
  -p, --preferences=<s>    Location of steam_categorizer preferences file
  -h, --help               Show this message
```

## Disclaimer

I accept no responsibility for any data lost as the result of running this script. I highly recommend you **backup your sharedconfig.vdf** before overwriting it with the output from this script. This project is still in alpha development stages and should be used with great care.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lyle-tafoya/steam-categorizer.
