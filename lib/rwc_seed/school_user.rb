# frozen_string_literal: true

module RwcSeed
  # SchoolUser processes SchoolUsers csv files to create
  # schooluser join table records (school id, user id)
  class SchoolUser
    include PyInstanceHelpers
    extend PyClassHelpers

    attr_reader :school_id, :start_date, :end_date, :user_id

    @@all = []

    def initialize(school_id, start_date, end_date, user_id)
      @school_id = school_id
      @start_date = format_date(start_date)
      @end_date = format_date(end_date)
      @user_id = user_id
      @@all << self
    end

    def self.all
      @@all
    end

    def self.create_school_users
      # To Do: should iterate through directory looking for all
      # SchoolUsers(name).csv files and then extract name.
      # For now, hardcoding.
      file_name = 'bin/data/SchoolUsers(Eastside Elementary).csv'
      school_name = 'Eastside Elementary'

      school_id = School.find_id_by_name(school_name)
      data = CSV.read(file_name, headers: true)

      school_users = data.map(&:to_hash)
      school_users.each do |su|
        user_id = User.find_id_by_username(su['Username'])
        # to do : start date needs to be 0 padded
        end_date = su['End Date'] || '12/31/50'
        SchoolUser.new(school_id, su['Start Date'], end_date, user_id)
      end
    end

    def self.py_table_data_definition
      py_array('schoolUserList', @@all)
    end

    def format_date(mdy)
      date_array = mdy.split('/')
      date = Date.new(date_array[2].to_i, date_array[0].to_i,
                      date_array[1].to_i)
      date.strftime('%D')
    end
  end
end
