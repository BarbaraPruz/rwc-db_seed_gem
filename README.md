# RwcSeed

This gem is a temporary tool used to help with ReadWriteCommunicate database seeding.
The gem reads CSV files (in bin/data folder) and outputs a corresponding seeds.py file.
The seeds.py file contains python variable definitions where each variable is an array
of dictionaries that can be used by python to seed the RWC database.

Note that this is a fragile process right now - for id's used in join table, the gem
relies on indices into arrays.  So the order of processing is tightly coupled with the 
order of processing in the python database loading code (currently fake.py)

## Installation and Running

Requires Ruby installation. (version 2.6.1 used for development but likely nothing version dependent)

If updating seed data values, replace the CSV files in bin/data with the new versions.  See
source code for specific file names.

bundle install

bin/rwc_seed

Ouptut file, seeds.py will be in the project root folder.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

