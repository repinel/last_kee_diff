# LastKeeDiff

This gem allows you to compare entries from LassPass and KeePass. It describe the differences into three groups: entries only present in LastPass, entries only present in KeePass and common entries.

## Installation

Install the gem and make the executable available:

    $ gem install last_kee_diff

## Usage

*First, to void leaving your passwords vulnerable please consider keeping your exported files in an encrypted storage.*

1. Export the CSV file from LassPass. Let's call it ```lass_pass.csv```.
2. Export the XML file from KeePass. Let's call it ```kee_pass.xml```.
3. Run ```last-kee-diff -l lass_pass.csv -k kee_pass.xml```.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/last_kee_diff/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
