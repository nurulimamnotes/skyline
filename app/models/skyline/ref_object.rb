# @private
class Skyline::RefObject < ActiveRecord::Base
  belongs_to :referable, :polymorphic => true, :autosave => true

  self.table_name = "skyline_ref_objects"
  
  serialize :options  
  
  validates_presence_of :referable_type
  
  attr_accessible :referable_id, :referable_type, :options, :refering_id, :refering_type, :refering_column_name
  
end
