# frozen_string_literal: true

# LuhnValidator using Luhn algorithm
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct

  def get_number_string(number)
    number.to_s.chars
  end

  def extract_checksum_digit(number_string)
    number_string.last.to_i
  end

  def get_weight(length, index)
    ((length - index - 1) % 2) + 1
  end

  def get_digit_sum(sum)
    sum.to_s.chars.map(&:to_i).reduce(&:+)
  end

  def compute_checksum_digit(actual_sum)
    (10 - (actual_sum % 10)) % 10
  end

  def validate_checksum
    number_string = get_number_string(number)
    total_sum = number_string[0..-2].map(&:to_i).map.with_index do |m, i|
      sum = m * get_weight(number_string.length, i)
      get_digit_sum(sum)
    end.reduce(&:+)

    expected_check_digit = extract_checksum_digit(number_string)
    actual_check_digit = compute_checksum_digit(total_sum)

    actual_check_digit == expected_check_digit
  end
end
