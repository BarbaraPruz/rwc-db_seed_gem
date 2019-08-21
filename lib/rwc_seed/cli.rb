# frozen_string_literal: true

module RwcSeed
  # CLI is the "main" for the gem
  class CLI
    def call
      puts 'Hello RWC'

      puts 'Processing CSVs'
      read_csv_files

      puts 'Creating seeds.py'
      file = File. open('seeds.py', 'w')
      store_table_definitions(file)
      file.close

      puts 'End'
    end

    private

    def read_csv_files
      School.create_schools
      # note: following order is required to mimic how fake py is creating db
      User.create_students
      User.create_faculty
      SchoolUser.create_school_users
      Klass.create_classes
    end

    def store_table_definitions(file)
      file.puts School.py_table_data_definition
      file.puts User.student_py_table_data_definition
      file.puts User.faculty_py_table_data_definition
      file.puts SchoolUser.py_table_data_definition
      file.puts Klass.py_table_data_definition
    end
  end
end
