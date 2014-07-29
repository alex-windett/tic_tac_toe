# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Move.delete_all

Move.create(square_id: 'a1')
Move.create(square_id: 'a2')
Move.create(square_id: 'a3')

Move.create(square_id: 'b1')
Move.create(square_id: 'b2')
Move.create(square_id: 'b3')

Move.create(square_id: 'c1')
Move.create(square_id: 'c2')
Move.create(square_id: 'c3')