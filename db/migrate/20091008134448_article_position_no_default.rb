class ArticlePositionNoDefault < ActiveRecord::Migration
  def self.up
    # execute "ALTER TABLE `skyline_articles` CHANGE `position` `position` INT( 11 ) NOT NULL"
    change_column_default(:skyline_articles, :position, nil)    
  end

  def self.down
    change_column :skyline_articles, :position, :integer, :null => false, :default => 1
  end
end
