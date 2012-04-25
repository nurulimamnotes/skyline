class Skyline::TestSection < ActiveRecord::Base
  include Skyline::Sections::Interface
  include Skyline::HasManyReferablesIn
  
  has_many_referables_in :body_a
  has_many_referables_in :body_b
  
  attr_accessor :fail_validation
  
  validate :validate_fail_validation
  
  self.table_name = "skyline_test_sections"
  
  attr_accessible :body_a, :body_b
  
  protected
  
  def validate_fail_validation
    self.errors.add(:base, "FAILED!!") if self.fail_validation == true
  end
  
    
end

