namespace :dev do
  desc "Configure the development environment"
  task setup: :environment do
    puts "Resetting database"
    %x(rails db:drop db:create db:migrate)

    puts "Registering kinds"

    kinds = %w(Friend Commercial Known)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts "Contact kinds successfully registered!"


    puts "Registering Contacts"

    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago),
        kind: Kind.all.sample
      )
    end

    puts "Contacts successfully registered!"


    puts "Registering phones"

    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create(number:Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end

    puts "Phones successfully registered!"


    puts "Registering Addresses"

    Contact.all.each do |contact|
      Address.create(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end

    puts "Addresses successfully registered!"

  end

end
