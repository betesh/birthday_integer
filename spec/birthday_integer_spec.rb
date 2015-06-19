require 'spec_helper'

describe BirthdayInteger do
  it 'has a version number' do
    expect(BirthdayInteger::VERSION).not_to be nil
  end
end

describe Date do
  describe "leap_yday" do
    def should_be(expected, actual)
      expect(Date.strptime(actual[:for], "%m/%d/%Y").leap_yday).to eq(expected)
    end
    [2012, 2011].each do |year|
      it { should_be(1, for: "1/1/#{year}") }
      it { should_be(59, for: "2/28/#{year}") }
      it { should_be(61, for: "3/1/#{year}") }
      it { should_be(366, for: "12/31/#{year}") }
    end
    it { should_be(60, for: "2/29/2012") }
  end

  describe "from_leap_yday" do
    def should_be(expected, actual)
      expect(Date.from_leap_yday(actual[:for], actual[:year])).to eq(Date.strptime(expected, "%m/%d/%Y"))
    end

    it "cannot be 0" do
      expect{Date.from_leap_yday(0)}.to raise_error(ArgumentError, "Cannot convert yday 0 since it is not between 1 and 366")
    end

    it "cannot be 367" do
      expect{Date.from_leap_yday(367)}.to raise_error(ArgumentError, "Cannot convert yday 367 since it is not between 1 and 366")
    end

    [2012, 2011].each do |year|
      it { should_be("1/1/#{year}", for: 1, year: year) }
      it { should_be("2/28/#{year}", for: 59, year: year) }
      it { should_be("3/1/#{year}", for: 61, year: year) }
      it { should_be("12/31/#{year}", for: 366, year: year) }
    end

    it { should_be("2/29/2012", for: 60, year: 2012) }

    it "should raise ArgumentError for 60 in 2011" do
      expect{Date.from_leap_yday(60,2011)}.to raise_error(ArgumentError, "There is no February 29th in 2011 since it is not a leap year")
    end

    it "should default to this year" do
      expect(Date.from_leap_yday(366)).to eq(Date.new(Date.today.year,12,31))
    end
  end

  describe "from_leap_yday_with_feb_29_birthdays_on_mar_1_in_common_years" do
    def should_be(expected, actual)
      expect(Date.from_leap_yday_with_feb_29_birthdays_on_mar_1_in_common_years(actual[:for], actual[:year])).to eq(Date.strptime(expected, "%m/%d/%Y"))
    end

    it "cannot be 0" do
      expect{Date.from_leap_yday_with_feb_29_birthdays_on_mar_1_in_common_years(0)}.to raise_error(ArgumentError, "Cannot convert yday 0 since it is not between 1 and 366")
    end

    it "cannot be 367" do
      expect{Date.from_leap_yday_with_feb_29_birthdays_on_mar_1_in_common_years(367)}.to raise_error(ArgumentError, "Cannot convert yday 367 since it is not between 1 and 366")
    end

    [2012, 2011].each do |year|
      it { should_be("1/1/#{year}", for: 1, year: year) }
      it { should_be("2/28/#{year}", for: 59, year: year) }
      it { should_be("3/1/#{year}", for: 61, year: year) }
      it { should_be("12/31/#{year}", for: 366, year: year) }
    end

    it { should_be("2/29/2012", for: 60, year: 2012) }
    it { should_be("3/1/2011", for: 60, year: 2011) }

    it "should default to this year" do
      expect(Date.from_leap_yday_with_feb_29_birthdays_on_mar_1_in_common_years(366)).to eq(Date.new(Date.today.year,12,31))
    end
  end
end
