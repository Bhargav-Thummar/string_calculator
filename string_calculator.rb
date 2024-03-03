# Refere this for defination https://blog.incubyte.co/blog/tdd-assessment/
# list of test cases for different scenarios
# 1. for the empty string - show message - should fail
# 2. calculator should allow any amount of number/argument
# 3. Allow the add method to handle new lines between numbers instead of commas OR \n character should treated same as commas
# 4. Should decide custom delimiter
# 5. negative numbers not allowed and show all of them in the exception message, separated by commas

# refer this for Rspec https://reintech.io/blog/how-to-test-ruby-code-with-rspec

require './dependencies'

class StringCalculator
  def add(*args)
    # remove nil from array
    args.compact!

    # to raise error for nil input
    raise NilInputError if args.empty?

    result = []
    negatives_or_alphabets_elements = []
    regex_for_delimiter = /^\/\/(.|@|#|$|%|;|:|<|>|!)\n.*/
    regex_for_negative_numbers = /-/

    args.each do |ele|

      if ele.match?(/(\n)/)
        # set delimiter
        if ele.match?(regex_for_delimiter)
          delimiter = ele[2]
          ele.gsub!("//#{delimiter}\n", '')
          ele.gsub!(delimiter, ",")
        end

        # replace delimiter with , after validating element
        ele
          .split(",")
          .each do |sub_ele|
            if sub_ele.match?(/^((\d+)\n(\d+))$/)
              ele.gsub!("\n", ",")
            elsif sub_ele.match?(/(\n)/)
              ele = "invalid"
            end
            break
          end
      else
        ele
      end

      next if ele == "invalid"

      # to raise error for alphabatic charaters
      raise InvalidInputError if ele.match?(/^[A-Za-z]+$/)

      # to capture negative numbers
      if ele.match?(regex_for_negative_numbers)
        ele.split(",").each { |sub_ele| negatives_or_alphabets_elements << sub_ele if sub_ele.to_i < 0 }
      end

      # resposible for sum of elements
      result <<
        ele
        .split(',')
        .map(&:to_i)
        .sum
    end

    # to raise error for negative numbers
    raise NegativeNumberError, negatives_or_alphabets_elements unless negatives_or_alphabets_elements.empty?

    result
  end
end

