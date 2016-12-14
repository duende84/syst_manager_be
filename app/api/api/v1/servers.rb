module API
  module V1
    class Servers < Grape::API
      include APIDefaults
      include APIGuard

      guard_all!

      resource :servers do
        desc "Return all servers of current user"
        get "" do
          servers = Server.where(user_id: current_user.id)
          present :servers, servers, with: ServerEntity
        end

        desc "Return a server by UID"
        params do
          requires :uid, type: String, desc: "UID of the Server"
        end
        get ":uid" do
          server = Server.where(uid: permitted_params[:uid]).first!
          present :servers, server, with: ServerEntity
        end

        desc "Register new server"
        params do
          requires :name, type: String, desc: "Name of the Server"
          requires :ip, type: String, desc: "ip of the Server"
          requires :so, type: String, desc: "OS of the Server"
        end
        post "new" do
          server = Server.create(
            uid: SecureRandom.uuid,
            name: permitted_params[:name],
            so: permitted_params[:so],
            ip: permitted_params[:ip],
            user_id: current_user.id
          )
          present :servers, server, with: ServerEntity
        end

        desc "Update server"
        params do
          requires :uid, type: String, desc: "UID of the Server"
          optional :name, type: String, desc: "Name of the Server"
          optional :so, type: String, desc: "OS of the Server"
          optional :ip, type: String, desc: "Ip of the Server"
          optional :disk_used, type: Float, desc: "Disk Usage of the Server"
          optional :disk_used_percent, type: Float, desc: "Disk percent usage of the Server"
          optional :memory_used, type: Float, desc: "Memory used of the Server"
          optional :memory_used_percent, type: Float, desc: "Memory percent use of the Server"
          optional :cpu_used, type: Float, desc: "CPU used of the Server"
          optional :cpu_processes, type: String, desc: "CPU top 10 processes of the Server"
          optional :memory_processes, type: String, desc: "Memory top 10 processes of the Server"
        end
        put "" do
          server = Server.find_by_uid(permitted_params[:uid])
          server.update_attributes({
            name: permitted_params[:name] || server[:name],
            so: permitted_params[:so] || server[:so],
            ip: permitted_params[:ip] || server[:ip],
            disk_used: permitted_params[:disk_used] || server[:disk_used],
            disk_used_percent: permitted_params[:disk_used_percent] || server[:disk_used_percent],
            memory_used: permitted_params[:memory_used] || server[:memory_used],
            memory_used_percent: permitted_params[:memory_used_percent] || server[:memory_used_percent],
            cpu_used: permitted_params[:cpu_used] || server[:cpu_used],
            cpu_processes: permitted_params[:cpu_processes] || server[:cpu_processes],
            memory_processes: permitted_params[:memory_processes] || server[:memory_processes]
            })
          present :servers, server, with: ServerEntity
        end

      end
    end
  end
end