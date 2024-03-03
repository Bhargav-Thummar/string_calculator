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
    negative_elements = []
    regex_for_delimiter = /^\/\/(.|@|#|$|%|;|:|<|>|!)\n.*/
    regex_for_negative_numbers = /-/
    regex_for_alphabatic_character = /^[A-Za-z]+$/
    regex_for_special_characters = /[!@#$%^&*().?":;{}|<>]/

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
              # setting this variable because later element should be ignored
              ele = "invalid"
            end

            break
          end

      else
        ele
      end

      # ignoring this element because it is not valid
      next if ele == "invalid"

      # to raise error for alphabatic charaters or any special charaters
      raise InvalidInputError if (ele.match?(regex_for_alphabatic_character) || ele.match?(regex_for_special_characters))

      # to capture negative numbers
      if ele.match?(regex_for_negative_numbers)
        ele.split(",").each { |sub_ele| negative_elements << sub_ele if sub_ele.to_i < 0 }
      end

      # resposible for sum of elements
      result <<
        ele
        .split(',')
        .map(&:to_i)
        .sum
    end

    # to raise error for negative numbers
    raise NegativeNumberError, negative_elements unless negative_elements.empty?

    result
  end
end

