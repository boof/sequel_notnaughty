require 'rubygems'

gem 'sequel', '>= 2.5.0'
require 'sequel'

#gem 'not-naughty', '0.6.1'
require 'not_naughty'

::NotNaughty::Validation.load(:acceptance, :confirmation, :format, :length, :numericality, :presence)
require "#{ File.dirname __FILE__ }/validations/uniqueness_validation.rb"

module Sequel #:nodoc:
  module Plugins #:nodoc:
    # == Adapter for Ruby Sequel
    #
    # Validate all your Ruby Sequel models with NotNaughty:
    #
    #   class Sequel::Model
    #     is :notnaughty
    #   end
    #
    # Validate just specific models:
    #
    #   class YourModel < Sequel::Model
    #     is :notnaughty
    #   end
    class NotNaughty < NotNaughty::Validator
      
      # Hook called by plugin api.
      def self.apply(receiver, *args)
        receiver.extend ::NotNaughty
        receiver.validator self, :create, :update
      end
      
      # Returns state for given instance.
      def get_state(instance)
        if instance.new? then @states[:create] else @states[:update] end
      end
      
      # Ensures API compatibility.
      module InstanceMethods
        def validate #:nodoc:
          errors.clear
          return false if before_validation == false
          self.class.validator.invoke self
          after_validation
          nil
        end
      end
      # Ensures API compatibility.
      module ClassMethods
        
        def validations #:nodoc:
          validator.states.
          inject({}) do |validations, state_with_name|
            validations.merge(state_with_name[1].validations) {|k,o,n| o|n}
          end
        end
        def has_validations?() #:nodoc:
          validator.has_validations?
        end
        def validate(instance) #:nodoc:
          validator.invoke instance
        end
        
      end
      
    end
    # this isn't a one-liner...
    Notnaughty = NotNaughty
  end
end
