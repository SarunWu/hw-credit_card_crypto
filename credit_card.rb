# frozen_string_literal: true

require_relative './luhn_validator'
require 'json'
require 'digest'

# Contain credit card information
class CreditCard
  include LuhnValidator

  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end

  # returns json string
  def to_json(*arg)
    {
      number: @number,
      expiration_date: @expiration_date,
      owner: @owner,
      credit_network: @credit_network
    }.to_json(*arg)
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    card_hash = JSON.parse(card_s)
    CreditCard.new(card_hash['number'],
                   card_hash['expiration_date'],
                   card_hash['owner'],
                   card_hash['credit_network'])
  end

  # return a hash of the serialized credit card object
  def hash
    to_s.hash
  end

  # return a cryptographically secure hash
  def hash_secure
    Digest::SHA256.base64digest to_s
  end
end
