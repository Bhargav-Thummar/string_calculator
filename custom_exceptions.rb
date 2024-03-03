class NilInputError < StandardError; end

class NegativeNumberError < StandardError
  def initialize(numbers = [])
    message = "Negative numbers not allowed "
    message.concat(numbers.join(","))
    message.concat(".")

    super(message)
  end
end

class InvalidInputError < StandardError; end

