require "#{ File.dirname __FILE__ }/sequel_spec_helper.rb"

Sequel.sqlite

class Item < Sequel::Model
  is :notnaughty
  validates_uniqueness_of :name, :in => [:category, :domain]

  set_schema :items do
    primary_key :id
    column :name, :text
    column :category, :text
    column :domain, :text
  end
  create_table

end

describe Sequel::Plugins::NotNaughty do

  before(:each) { Item.delete_all }

  it "should not be valid when valid isn't unique" do
    item = Item.new :name => 'abc'
    proc { item.save }.should_not raise_error

    item = Item.new :name => 'abc'
    proc { item.save }.should raise_error(Sequel::Error)
  end

  it "should honor scopes" do
    item = Item.new :name => 'abc', :category => 'efg'
    proc { item.save }.should_not raise_error

    item = Item.new :name => 'abc', :category => 'efg'
    proc { item.save }.should raise_error(Sequel::Error)

    item = Item.new :name => 'abc', :category => 'efg', :domain => 'hij'
    proc { item.save }.should_not raise_error
  end

end
