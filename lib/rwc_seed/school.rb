# frozen_string_literal: true


module RwcSeed
  # School processes schools.csv
  class School
    include PyInstanceHelpers
    extend PyClassHelpers
    attr_reader :name, :address, :city, :state, :country

    @@all = []

    def initialize(name, address, city, state, country)
      @name = name
      @address = address
      @city = city
      @state = state
      @country = country
      @@all << self
    end

    def self.all
      @@all
    end

    def self.py_table_data_definition
      py_array('schoolList', @@all)
    end

    def self.create_schools
      rows = CSV.read('bin/data/Schools.csv')
      rows.shift
      # To Do : ugly!
      rows.each do |row|
        School.new(row[0], row[1], row[2], row[3], row[4])
      end
    end

    def self.find_id_by_name(name)
      @@all.find_index { |s| s.name == name } + 1
    end
  end
end
