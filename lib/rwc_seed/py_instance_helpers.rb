# frozen_string_literal: true

# Python code generator helper functions fpr class instances
module PyInstanceHelpers
  def dictionary_definition
    dictionary = '{'
    last_index = instance_variables.count - 1
    instance_variables.each_with_index do |var, index|
      dictionary += "\"#{var.to_s.delete('@')}\":"
      dictionary += "\"#{instance_variable_get(var)}\""
      dictionary += ',' unless index == last_index
    end
    dictionary += '}'
    dictionary
  end
end
