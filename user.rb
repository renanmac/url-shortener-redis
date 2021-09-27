# frozen_string_literal: true

require 'ohm'

# User model
class User < Ohm::Model
  attribute :name
  index :name

  unique :name

  collection :links, :Link
end
