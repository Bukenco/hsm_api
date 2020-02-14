class UserKey < ApplicationRecord
  attr_accessor :key
  encrypts :key
end
