class Server < ApplicationRecord
  resourcify

  belongs_to :user
end
