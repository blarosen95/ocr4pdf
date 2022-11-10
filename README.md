[![Coverage Status](https://coveralls.io/repos/github/blarosen95/ocr4pdf/badge.svg?branch=main)](https://coveralls.io/github/blarosen95/ocr4pdf?branch=main)

# Ocr4pdf

System dependencies include:
* Tesseract
* poppler-utils — for its `pdfinfo`, `pdftocairo` and `pdfunite` commands

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ocr4pdf

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ocr4pdf

## Usage

Currently, Ocr4pdf only supports input files in PDF format.
```ruby
require 'ocr4pdf'

new_pdf_blob = Ocr4pdf.new('path/to/file.pdf').create_ocr_pdf

# To save the new PDF to disk, use:
File.binwrite('path/to/new_file.pdf', new_pdf_blob)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ocr4pdf. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ocr4pdf/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ocr4pdf project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ocr4pdf/blob/main/CODE_OF_CONDUCT.md).
