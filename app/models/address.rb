class Address < ApplicationRecord
  belongs_to :contact, optional: :true  #it's not required to add an address when creating a contact
end
