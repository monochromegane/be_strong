# BeStrong [![Build Status](https://travis-ci.org/appfolio/be_strong.svg?branch=appfolio)](https://travis-ci.org/appfolio/be_strong)

BeStrong is a tool for converting your `attr_accessible` and `attr_protected` to **strong parameter** method.
This is useful if you are upgrading a large Rails app.

+This is a bug fix fork of the original [be_strong](https://github.com/monochromegane/be_strong) gem by [monochromegane](https://github.com/monochromegane).

## Examples

If your code isn't strong like the following:

```rb
# Model
class Author < ActiveRecord::Base
  attr_accessible :name, :age
end

# Controller
class AuthorsController < ApplicationController
  def create
    Author.new(params[:author])
    ...
  end
end
```

After run `be_strong` command:

```rb
# Strong Model
class Author < ActiveRecord::Base
end

# Strong Controller
class AuthorsController < ApplicationController
  def create
    Author.new(author_params)
    ...
  end

  private

  def author_params
    params.require(:author).permit(:name, :age)
  end
end
```

## Feature

- Generate strong parameter method from model.
- Apply strong parameter method to controller.
- Remove `attr_accessible` method from model.
- Remove `attr_protected` method from model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ae-be_strong'
```

## Usage

```sh
$ cd your-project
$ bundle exec rake be_strong:convert
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/appfolio/be_strong).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

