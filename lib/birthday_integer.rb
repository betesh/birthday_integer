require "birthday_integer/version"
require "date"

class Date
  def leap_yday
    yday + ((!leap? && yday >= 60) ? 1 : 0)
  end

  class << self
    def from_leap_yday(n,year=Date.today.year)
      n = n.to_i
      raise ArgumentError, "Cannot convert yday #{n} since it is not between 1 and 366" unless n >= 1 && n <= 366

      if leap?(year) || n > 60
        new(year,3,1) - 61 + n
      elsif 60 == n
        raise ArgumentError, "There is no February 29th in #{year} since it is not a leap year"
      else
        new(year,1,1) - 1 + n
      end
    end

    def from_leap_yday_with_feb_29_birthdays_on_mar_1_in_common_years(n, year=Date.today.year)
      n = n + 1 if 60 == n && !leap?(year)
      from_leap_yday(n,year)
    end
  end
end
