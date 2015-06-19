# BirthdayInteger

Sometimes you need to handle dates in a year-agnostic date.  For example, a birthday.

At its most basic level, we are not interested in storing a date, but rather an integer from 1 to 366.

In order to easily convert between this integer and a date, this gem provides a core extension to the Date class, that extracts the complexity of converting between dates and birthday integers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'birthday_integer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install birthday_integer

## Usage

### Converting a Ruby Date to your birthday integer

```ruby
your_birthday = Date.new(any_year, your_birthday_month, your_birthday_day)
your_birthday.leap_yday # Returns an integer value representing your birthday
```

Why is it called leap_yday?  Because in a leap year, it's the same as your_birthday.yday.

What is it in a non-leap year? Until February 28th, it's the same as your_birthday.yday.  Beginning March 1st, it's your_birthday.yday + 1.

### Converting your birthday integer to a Ruby Date

```ruby
require "birthday_integer"
```

Suppose your birthday is February 1st.  Your birthday integer is 32.

```ruby
Date.from_leap_yday(32) # returns the calendar date of your birthday this year
```

You could also pass an optional year.

```ruby
Date.from_leap_yday(32, 2011) # returns the calendar date of your birthday in 2011
```

Now, suppose your birthday is March 1st.  Your birthday integer is 61.

"Why not 60?", you ask.

Because 60 means February 29th.

"But there is no February 29th in the year I was born!", you declare.

That may be true, but **SOME** years do have a February 29th, and you **DO** celebrate your birthday that year.  (Don't you?)

Feb 29 obviously makes things a little more complicated.

```ruby
Date.from_leap_yday(60, 2012) # returns February 29th, 2012
Date.from_leap_yday(60, 2014) # raises an ArgumentError
```

"OK, I get it," you say after some thought. "If 61 means March 1st, and 59 means February 28th, then 60 isn't a valid date in 2014. But what if your birthday is really February 29th?  When do you celebrate your birthday in 2014?"

Well, you have 2 choices:

#### Choice 1:

```ruby
Date.from_leap_yday_with_feb_29_birthdays_on_mar_1_in_common_years(60, 2014)
```

#### Choice 2:

```ruby
ArgumentError # There is no February 29th in 2014 since it is not a leap year
```

It's your choice.  Celebrate in March, or celebrate with an ArgumentError!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/birthday_integer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
