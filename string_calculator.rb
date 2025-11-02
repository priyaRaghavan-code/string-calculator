# Class for adding numbers in a string

class StringCalculator
  attr_reader :numbers, :delimiters, :values

  def initialize(numbers = "")
    @numbers = numbers
    @delimiters = [",", "\n"]
    @values = []
  end

  def add(input = @numbers)
    return 0 if input.strip.empty?

    @delimiters, @numbers = parse_delimiters(input)
    @values = extract_numbers

    check_for_negatives
    sum_valid_numbers
  end

  private

  def parse_delimiters(input)
    return [delimiters, input] unless input.start_with?("//")

    header, body = input.split("\n", 2)
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
    raise "negatives not allowed: #{negatives.join(', ')}" unless negatives.empty?
  end

  def sum_valid_numbers
    values.reject { |n| n > 1000 }.sum
  end
end
