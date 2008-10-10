module NotNaughty
  
  # Validates only if the fields in the model (specified by atts) are
  # unique in the database.  You should also add a unique index in the
  # database, as this suffers from a fairly obvious race condition.
  #
  # Possible Options:
  # <tt>:in</tt>::      scope could be a single or multiple attributes
  # <tt>:message</tt>:: see NotNaughty::Errors for details
  # <tt>:if</tt>::      see NotNaughty::Validation::Condition for details
  # <tt>:unless</tt>::  see NotNaughty::Validation::Condition for details
  class UniquenessValidation < Validation

    def initialize(valid, attributes) #:nodoc:
      valid[:message] ||= '%s is already taken.'
      valid[:in] = case valid[:in]
      when Array; valid[:in].map { |scp| scp.to_sym }
      when String, String; [ valid[:in].to_sym ]
      else
        []
      end

      if valid[:allow_blank] or valid[:allow_nil]
        valid[:allow] = valid[:allow_blank] ? :blank? : :nil?

        super valid, attributes do |obj, attr, value|
          scope_values = obj.values.values_at(*valid[:in])
          scope = Hash[*valid[:in].zip(scope_values).flatten]

          value.send valid[:allow] or
          obj.model.find(scope.merge(attr => value)).nil? or
          obj.errors.add attr, valid[:message]
        end
      else

        super valid, attributes do |obj, attr, value|
          scope_values = obj.values.values_at(*valid[:in])
          scope = Hash[*valid[:in].zip(scope_values).flatten]

          obj.model.find(scope.merge(attr => value)).nil? or
          obj.errors.add attr, valid[:message]
        end
      end
    end

  end
end
