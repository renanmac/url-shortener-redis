# frozen_string_literal: true

require 'ohm'

# Site model
class Link < Ohm::Model
  attribute :slug
  index :slug
  unique :slug

  attribute :url

  reference :user, :User

  counter :views

  def attributes
    attrs = super
    attrs.merge(views: views)
  end
end
