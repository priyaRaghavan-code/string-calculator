# Class for adding numbers in a string

class StringCalculator
  attr_reader :numbers, :delimiters, :values

  def initialize(numbers = "")
    @numbers = numbers
    @delimiters = [",", "\n"]
    @values = []
  end

  def add
    return 0 if numbers.strip.empty?

    @delimiters, @numbers = parse_delimiters
    @values = extract_numbers

    check_for_negatives
    sum_valid_numbers
  end

  private

  def parse_delimiters
    return [delimiters, numbers] unless numbers.start_with?("//")

    header, body = numbers.split("\n", 2)
    header_delimiters = extract_delimiters_from_header(header)
    [header_delimiters, body]
  end

  def extract_delimiters_from_header(header)
    return [header[2]] unless header.include?("[")

    header.scan(/\[([^\]]+)\]/).flatten
  end

  def extract_numbers
    numbers.split(Regexp.union(delimiters)).map(&:to_i)
  end

  def check_for_negatives
    negatives = values.select(&:negative?)
    raise "negatives not allowed #{negatives.join(', ')}" unless negatives.empty?
  end

  def sum_valid_numbers
    values.reject { |n| n > 1000 }.sum
  end
end
