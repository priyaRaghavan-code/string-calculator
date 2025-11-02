# class for adding numbers string
class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    delimiter = /,|\n/
    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)
      delimiters = extract_delimiters(parts[0])
      delimiter = Regexp.union(delimiters)
      numbers = parts[1]
    end

    num_array = numbers.split(delimiter).map(&:to_i)
    negatives = num_array.select { |n| n < 0 }

    raise "negatives not allowed: #{negatives.join(', ')}" unless negatives.empty?

    num_array.reject { |n| n > 1000 }.inject(0) { |sum, n| sum + n }
  end

  private

  def extract_delimiters(header)
    if header.start_with?("//[") && header.end_with?("]")
      header[3..-2].split('][')
    else
      [header[2]]
    end
  end
end