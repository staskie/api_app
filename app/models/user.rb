class User < ActiveRecord::Base
  attr_accessible :first_name, :second_name, :hobby
  validates_presence_of :first_name, :second_name, :hobby
end
