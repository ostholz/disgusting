# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.where(username: 'admin', first_name: 'i2dm', last_name: 'gmbh', email: 'info@i2dm.de').first_or_create do |u|
  u.password = 'izwodm'
  u.password_confirmation = 'izwodm'
end