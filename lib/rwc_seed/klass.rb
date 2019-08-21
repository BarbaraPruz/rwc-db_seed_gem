# frozen_string_literal: true

module RwcSeed
  # Klass - a school class model.  It has a name and a teacher
  class Klass
    include PyInstanceHelpers
    extend PyClassHelpers
    attr_reader :name, :class_id, :teacher_id

    @@all = []

    def initialize(name, teacher_id)
      @name = name
      @teacher_id = teacher_id
      @@all << self
    end

    def self.all
      @@all
    end

    def self.py_table_data_definition
      py_array('classList', @@all)
    end

    def self.create_classes
      data = CSV.read('bin/data/classes.csv', headers: true)
      classes = data.map(&:to_hash)
      # To Do later after db corrections: class is associated with a School,
      # has start/end dates and has grade level info
      classes.each do |c|
        teacher_id = User.find_id_by_username(c['Teacher Username'])
        Klass.new(c['Name'], teacher_id)
      end
    end
  end
end
