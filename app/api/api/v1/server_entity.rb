require 'grape-entity'

module API
  module V1
    class ServerEntity < Grape::Entity
      expose :id
      expose :uid
      expose :name
      expose :so
      expose :ip
      expose :disk_used
      expose :disk_used_percent
      expose :memory_used
      expose :memory_used_percent
      expose :cpu_used
      expose :cpu_processes
      expose :memory_processes
      expose :created_at
    end
  end
end
