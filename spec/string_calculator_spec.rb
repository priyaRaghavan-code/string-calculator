require 'rspec'
require_relative '../string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  it "returns 0 for an empty string" do
    expect(calculator.add("")).to eq(0)
  end

  it "returns the number itself for a single number" do
    expect(calculator.add("1")).to eq(1)
    expect(calculator.add("5")).to eq(5)
  end

  it "returns the sum of two numbers" do
    expect(calculator.add("1,2")).to eq(3)
    expect(calculator.add("3,5")).to eq(8)
  end

  it "returns the sum of numbers with new lines" do
    expect(calculator.add("1\n2,3")).to eq(6)
    expect(calculator.add("4\n5,6")). to eq(15)
    expect(calculator.add("\n")). to eq(0)
  end
end