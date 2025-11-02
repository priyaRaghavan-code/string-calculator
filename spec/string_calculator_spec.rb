require 'rspec'
require_relative '../string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { described_class.new }

  shared_examples "string addition" do |input, expected|
    it "returns #{expected} for input '#{input}'" do
      expect(calculator.add(input)).to eq(expected)
    end
  end

  context "handles one or two numbers" do
    it_behaves_like "string addition", "", 0
    it_behaves_like "string addition", "1", 1
    it_behaves_like "string addition", "5", 5
    it_behaves_like "string addition", "1,2", 3
    it_behaves_like "string addition", "3,5", 8
  end

  context "handles multiple numbers" do
    it_behaves_like "string addition", "1,2,3", 6
    it_behaves_like "string addition", "4,5,6", 15
  end

  context "handles new lines" do
    it_behaves_like "string addition", "1\n2,3", 6
    it_behaves_like "string addition", "4\n5,6", 15
  end

  context "handles different delimiters" do
    it_behaves_like "string addition", "//;\n1;2", 3
    it_behaves_like "string addition", "//|\n1|2|3", 6
    it_behaves_like "string addition", "//[***]\n1***2***3", 6
    it_behaves_like "string addition", "//[###]\n4###5###6", 15
    it_behaves_like "string addition", "//[*][%]\n1*2%3", 6
    it_behaves_like "string addition", "//[;][&]\n4;5&6", 15
    it_behaves_like "string addition", "//[***][%%%]\n1***2%%%3", 6
    it_behaves_like "string addition", "//[###][&&&]\n4###5&&&6", 15
  end

  context "handles negatives" do
    it "raises an error for single negative number" do
      expect { calculator.add("1,-2,3") }.to raise_error("negatives not allowed: -2")
    end

    it "raises an error for multiple negatives" do
      expect { calculator.add("-1,-2,3") }.to raise_error("negatives not allowed: -1, -2")
    end
  end

  context "handles large numbers" do
    it_behaves_like "string addition", "2,1001", 2
    it_behaves_like "string addition", "1000,1001,2", 1002
  end
end
