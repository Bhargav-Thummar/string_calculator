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

    raise NilInputError if args.empty?

    result = []

    args.each do |ele|
      if ele.match?(/(\n)/)
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

      result <<
        ele
        .split(',')
        .map(&:to_i)
        .sum
    end

    result
  end
end

