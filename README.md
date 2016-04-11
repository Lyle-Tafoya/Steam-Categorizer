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
  -b, --birthdate=<i>      Epoch value of birth date in seconds (default: 1460376314)
  -h, --help               Show this message

A sample preferences file can be found in sample/category_mapping.json
If an output file is not specified with --output, the default behavior is to overwrite the location provided with --config

example:
steam-categorizer --key "my_steam_api_key" --id "my_steam_id" --config "/home/my_username/.steam/steam/userdata/65357252/7/remote/sharedconfig.vdf" --preferences "/home/my_username/.gem/ruby/2.3.0/gems/steam-categorizer-0.1.0/sample/category_mapping.json" --output "/home/my_username/.steam/steam/userdata/65357252/7/remote/sharedconfig.vdf" --birthdate 0
```

## Disclaimer

I accept no responsibility for any data lost as the result of running this script. I highly recommend you **backup your sharedconfig.vdf** before overwriting it with the output from this script. This project is still in alpha development stages and should be used with great care.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lyle-tafoya/steam-categorizer.
