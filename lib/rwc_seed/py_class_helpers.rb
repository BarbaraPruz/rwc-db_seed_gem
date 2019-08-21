# frozen_string_literal: true

# Class level helper functions for generating Python code
module PyClassHelpers
  def py_array(array_name, collection)
    array = "#{array_name} = [\n"
    last_index = collection.count - 1
    collection.each_with_index do |c, index|
      array += "#{c.dictionary_definition}"\
             "#{index < last_index ? ',' : ''}"
      array += "\n"
    end
    array += "]\n"
  end
end
