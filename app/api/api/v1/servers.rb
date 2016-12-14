module API
  module V1
    class Servers < Grape::API
      include APIDefaults
      include APIGuard

      guard_all!

      resource :servers do
        desc "Return all servers of current user"
        get "" do
          servers = Server.where(user_id: @current_user.id)
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
          requires :uid, type: String, desc: "UID of the Server"
          requires :name, type: String, desc: "Name of the Server"
        end
        post "new" do
          server = Server.create(
            uid: permitted_params[:uid],
            name: permitted_params[:name]
          )
          present :servers, server, with: ServerEntity
        end
      end
    end
  end
end