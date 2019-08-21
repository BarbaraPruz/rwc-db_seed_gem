# frozen_string_literal: true

module RwcSeed
  # User processes Users.csv to create student and faculty users
  class User
    include PyInstanceHelpers
    extend PyClassHelpers
    attr_reader :name, :email, :username, :password, :confirmed, :type

    @@all = []

    def initialize(name, email, username, type)
      @name = name
      @email = email
      @username = username
      @password = 'password'
      @confirmed = true
      @type = type
      @@all << self
    end

    def self.all
      @@all
    end

    def self.student_py_table_data_definition
      py_array('studentList', students)
    end

    def self.faculty_py_table_data_definition
      py_array('facultyList', faculty)
    end

    def self.faculty
      @@all.select { |u| u.type == 'faculty' }
    end

    def self.students
      @@all.select { |u| u.type == 'student' }
    end

    def self.find_id_by_username(username)
      @@all.find_index { |f| f.username == username } + 1
    end

    def self.create_students
      data = CSV.read('bin/data/users.csv', headers: true)
      users = data.map(&:to_hash)
      users.each do |user|
        if user['Type'] == 'student'
          User.new(user['Name - First and Last'], user['Email'],
                   user['Username'], user['Type'])
        end
      end
    end

    def self.create_faculty
      data = CSV.read('bin/data/users.csv', headers: true)
      users = data.map(&:to_hash)
      users.each do |user|
        if user['Type'] != 'student'
          User.new(user['Name - First and Last'], user['Email'],
                   user['Username'], 'faculty')
        end
      end
    end
  end
end
